-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:50:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local Dash = require(FoundationParent.Dash)
local filter = Dash.filter
local values = Dash.values

local Flags = require(Foundation.Utility.Flags)
local StudioUri = require(Foundation.Utility.Plugin.StudioUri)

local Logger = require(Foundation.Utility.Logger)

local module = {}
module.__index = module

function module.new(_widgetsApi)
    local self = setmetatable({}, module)

    self._widgetsApi = _widgetsApi
    self._pendingRegisters = {}
    self._pendingDeregisters = {}
    self._registeredWidgets = {}
    self._signals = {}
    self._deferredAncestrySignals = {}
    self._running = false

    return self
end

local function getWidgetHost(arg1): ScreenGui? | PluginGui -- Luacid: Inlined by compiler; 2 call sites recovered
    local pluginGui = arg1:FindFirstAncestorWhichIsA("PluginGui")
    if pluginGui then
        return pluginGui
    end
    return arg1:FindFirstAncestorWhichIsA("ScreenGui")
end

local function makeRegistration(uri, widget, deprecatedPluginGui) -- Luacid: unused: defined but never referenced
    return {
        Uri = uri,
        Widget = widget,
        DEPRECATED_PluginGui = deprecatedPluginGui,
        Position = widget.AbsolutePosition,
        Size = widget.AbsoluteSize,
        Visible = widget:GetStyled("Visible")
    }
end

function module.nextId(_): string
    return HttpService:GenerateGUID(false)
end

function module:flush()
    if Flags.FoundationWidgetManagerSnapshotFlush then
        local _pendingDeregisters = self._pendingDeregisters
        local _pendingRegisters = self._pendingRegisters
        self._pendingDeregisters = {}
        self._pendingRegisters = {}

        self:_flushWith(_pendingDeregisters, _pendingRegisters)
        return
    end
    self:_flushWith(self._pendingDeregisters, self._pendingRegisters)
    self._pendingDeregisters = {}
    self._pendingRegisters = {}
end

function module:_flushWith(tbl1, tbl2)
    local tbl3 = {}
    for value, value2 in tbl1 do
        table.insert(tbl3, value2)
        self._registeredWidgets[value] = nil
    end
    if #tbl3 > 0 then
        pcall(function()
            self._widgetsApi:DeregisterAsync(tbl3)
        end)
    end

    local var1 = Flags.FoundationWidgetManagerSnapshotFlush and {} or nil
    local var2 = filter(values(tbl2), function(arg1): boolean
        local bool1 = arg1.Widget:FindFirstAncestorWhichIsA("LayerCollector") ~= nil
        if Flags.FoundationWidgetManagerSnapshotFlush and not bool1 then
            table.insert(var1, arg1)
        end
        return bool1
    end)

    if Flags.FoundationWidgetManagerSnapshotFlush then
        for _, value in var1 do
            local var3 = StudioUri.toString(value.Uri)
            if self._deferredAncestrySignals[var3] then
                continue
            end

            self._deferredAncestrySignals[var3] = value.Widget.AncestryChanged:Connect(function(_: Instance, parent: Instance)
                if parent == nil then
                    local _deferredAncestrySignal = self._deferredAncestrySignals[var3]
                    if _deferredAncestrySignal then
                        _deferredAncestrySignal:Disconnect()
                        self._deferredAncestrySignals[var3] = nil
                    end
                    return
                end
                if not value.Widget:FindFirstAncestorWhichIsA("LayerCollector") then
                    return
                end

                local _deferredAncestrySignal = self._deferredAncestrySignals[var3]
                if _deferredAncestrySignal then
                    _deferredAncestrySignal:Disconnect()
                    self._deferredAncestrySignals[var3] = nil
                end
                self:register(value.Uri, value.Widget)
            end)
        end
    end

    local tbl4 = {}
    for _, value in var2 do
        value.Position = value.Widget.AbsolutePosition
        value.Size = value.Widget.AbsoluteSize
        value.Visible = value.Widget:GetStyled("Visible")
        local var3 = StudioUri.toString(value.Uri)
        local deprecatedPluginGui = value.DEPRECATED_PluginGui

        local _signal = self._signals[var3]
        if _signal then
            if _signal.Widget == value.Widget then
                if _signal.Host == deprecatedPluginGui then
                    continue
                end

                _signal.Host = deprecatedPluginGui
                table.insert(tbl4, value.Uri)
                continue
            end

            _signal.PositionChanged:Disconnect()
            _signal.SizeChanged:Disconnect()
            _signal.VisibleChanged:Disconnect()
            _signal.AncestryChanged:Disconnect()
        end

        local _signals = self._signals

        _signals[var3] = {
            Widget = value.Widget,
            Host = deprecatedPluginGui,
            PositionChanged = value.Widget:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                self:register(value.Uri, value.Widget)
            end),
            SizeChanged = value.Widget:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                self:register(value.Uri, value.Widget)
            end),
            VisibleChanged = value.Widget:GetStyledPropertyChangedSignal("Visible"):Connect(function()
                self:register(value.Uri, value.Widget)
            end),
            AncestryChanged = value.Widget.AncestryChanged:Connect(function(_: Instance, parent: Instance)
                if not parent then
                    self:deregister(value.Uri)
                end
            end)
        }
    end

    if #tbl4 > 0 then
        pcall(function()
            self._widgetsApi:DeregisterAsync(tbl4)
        end)
    end

    if #var2 > 0 then
        self._widgetsApi:RegisterAsync(var2)
    end
end

function module:_run()
    if self._running then
        return
    end
    self._running = true
    task.defer(function()
        self._running = false
        self:flush()
    end)
end

function module:register(uri, widget)
    local deprecatedPluginGui = getWidgetHost(widget)

    if not deprecatedPluginGui then
        return
    end

    local var1 = StudioUri.toString(uri)
    if Flags.FoundationWidgetManagerSnapshotFlush then
        local _deferredAncestrySignal = self._deferredAncestrySignals[var1]
        if _deferredAncestrySignal then
            _deferredAncestrySignal:Disconnect()
            self._deferredAncestrySignals[var1] = nil
        end
    end
    self._registeredWidgets[var1] = widget
    self._pendingRegisters[var1] = {
        Uri = uri,
        Widget = widget,
        DEPRECATED_PluginGui = deprecatedPluginGui
    }
    self._pendingDeregisters[var1] = nil
    self:_run()
end

function module:refreshAsync(uri): boolean
    local var1 = StudioUri.toString(uri)
    local widget = self._registeredWidgets[var1]
    if not widget then
        return false
    end

    local deprecatedPluginGui = getWidgetHost(widget)

    if not deprecatedPluginGui then
        return false
    end

    self._widgetsApi:RegisterAsync({{
        Uri = uri,
        Widget = widget,
        DEPRECATED_PluginGui = deprecatedPluginGui,
        Position = widget.AbsolutePosition,
        Size = widget.AbsoluteSize,
        Visible = widget:GetStyled("Visible")
    }})
    return true
end

function module:deregister(arg1, widget)
    local var1 = StudioUri.toString(arg1)
    self._pendingDeregisters[var1] = arg1
    if Flags.FoundationWidgetManagerSnapshotFlush then
        self._pendingRegisters[var1] = nil
        local _deferredAncestrySignal = self._deferredAncestrySignals[var1]
        if _deferredAncestrySignal then
            _deferredAncestrySignal:Disconnect()
            self._deferredAncestrySignals[var1] = nil
        end
    end
    local _signal = self._signals[var1]
    if _signal then
        if widget == nil or _signal.Widget == widget then
            _signal.PositionChanged:Disconnect()
            _signal.SizeChanged:Disconnect()
            _signal.VisibleChanged:Disconnect()
            _signal.AncestryChanged:Disconnect()
            self._signals[var1] = nil
        else
            Logger:warning(`WidgetManager:deregister called with mismatched widget for uri {var1}`)
        end
    end
    self:_run()
end

function module:destroy()
    for _, _signal in self._signals do
        _signal.PositionChanged:Disconnect()
        _signal.SizeChanged:Disconnect()
        _signal.VisibleChanged:Disconnect()
        _signal.AncestryChanged:Disconnect()
    end
    if Flags.FoundationWidgetManagerSnapshotFlush then
        for _, _deferredAncestrySignal in self._deferredAncestrySignals do
            _deferredAncestrySignal:Disconnect()
        end
        self._deferredAncestrySignals = {}
    end
    self._signals = {}
    self._pendingRegisters = {}
    self._pendingDeregisters = {}
    self._registeredWidgets = {}
end

return module

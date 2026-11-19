-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:51:33Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local Foundation = script:FindFirstAncestor("Foundation")
local Flags = require(Foundation.Utility.Flags)
local StudioUri = require(Foundation.Utility.Plugin.StudioUri)
local _Types = require(script.Parent.Parent.Types)

local function bindToClose(arg1, func1: (...any) -> (...any)) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1:IsA("PluginGui") then
        arg1:BindToClose(func1)
    end
end

local function isStrictDescendantOf(_active, tbl1, tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    local parentPopoverId = tbl2.parentPopoverId
    while parentPopoverId do
        if parentPopoverId == tbl1.id then
            return true
        end
        local var1 = _active[parentPopoverId]
        if not var1 then
            break
        end

        parentPopoverId = var1.parentPopoverId
    end
    return false
end

local module = {}
module.__index = module

function module.new(plugin, _uriScope: string?)
    local self = setmetatable({}, module)
    self._uriScope = _uriScope

    self._plugin = plugin
    self._panels = plugin:GetPluginComponent("Panels")
    self._pluginUri = StudioUri.wrap(plugin:GetUri())

    self._active = {}
    self._pool = {}
    self._didPrewarm = false

    return self
end

function module:openAtAsync(arg1, func1: ((...any) -> (...any))?, num1: number?, str1: string?, bool1: boolean?)
    local var1 = if num1 == nil then 0 else num1
    local bool2 = if Flags.FoundationPopoverPluginFocusable then bool1 == true else false
    local var2 = self:_acquirePanelAsync(func1, var1, str1, bool2)

    var2.panel.Enabled = false

    self._panels:SetAttachmentAsync(var2.uri, {
        TargetWidgetUri = arg1.targetWidgetUri,
        TargetAnchorPoint = arg1.targetAnchorPoint,
        SubjectAnchorPoint = arg1.subjectAnchorPoint,
        Offset = arg1.offset
    })
    self._panels:SetSizeAsync(var2.uri, Vector2.new(0, 0))

    var2.panel.Enabled = true
    var2.open = true

    if not Flags.FoundationPopoverPluginOverlayMeasurement then
        return {
            container = var2.panel,
            popoverId = var2.id,
            setSizeAsync = function(vector2: Vector2)
                local x = math.ceil(math.min(3000, vector2.X))
                local y = math.ceil(math.min(3000, vector2.Y))
                self._panels:SetSizeAsync(var2.uri, Vector2.new(x, y))
            end,
            updateAsync = function(arg2)
                if not var2.uri then
                    return
                end

                self._panels:SetAttachmentAsync(var2.uri, {
                    TargetWidgetUri = arg2.targetWidgetUri,
                    TargetAnchorPoint = arg2.targetAnchorPoint,
                    SubjectAnchorPoint = arg2.subjectAnchorPoint,
                    Offset = arg2.offset
                })
            end,
            close = function()
                self:_closePopover(var2, true)
            end
        }
    end

    local generation = var2.generation
    return {
        container = var2.panel,
        popoverId = var2.id,
        setSizeAsync = function(vector2: Vector2)
            if var2.generation ~= generation or not var2.open then
                return
            end
            local x = math.ceil(math.min(3000, vector2.X))
            local y = math.ceil(math.min(3000, vector2.Y))
            self._panels:SetSizeAsync(var2.uri, Vector2.new(x, y))
        end,
        updateAsync = function(arg2)
            if var2.generation ~= generation or not (var2.open and var2.uri) then
                return
            end

            self._panels:SetAttachmentAsync(var2.uri, {
                TargetWidgetUri = arg2.targetWidgetUri,
                TargetAnchorPoint = arg2.targetAnchorPoint,
                SubjectAnchorPoint = arg2.subjectAnchorPoint,
                Offset = arg2.offset
            })
        end,
        close = function()
            self:_closePopover(var2, true, generation)
        end
    }
end

function module:_createPanelAsync(str1: string, num1: number, focusable: boolean)
    local _plugin = self._plugin
    local tbl1 = {
        Id = str1,
        InitialEnabled = true,
        Tooltip = true,
        Focusable = 0,
        Transparent = true,
        Resizable = true,
        Title = 0,
        ZIndex = 0
    }

    if not Flags.FoundationPopoverPluginFocusable then
        focusable = nil
    end

    tbl1.Focusable = focusable

    tbl1.Title = str1
    tbl1.ZIndex = num1 + 200
    local var1 = _plugin:CreateQWidgetPluginGui(str1, tbl1)

    var1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    return var1, StudioUri.join(self._pluginUri, { Category = "Panels", ItemId = str1 })
end

function module:_makePopoverId(): string
    return `Popovers{if self._uriScope then `/{self._uriScope}` else ""}/{HttpService:GenerateGUID(false)}`
end

function module:_createPopoverAsync(id: string, depth: number, isFocusable: boolean)
    local panel, uri = self:_createPanelAsync(id, depth, isFocusable)
    local tbl1 = {
        id = id,
        uri = uri,
        panel = panel,
        open = false,
        depth = depth,
        isFocusable = isFocusable,
        generation = 0,
        parentPopoverId = nil,
        onClose = nil
    }

    bindToClose(panel, function()
        if Flags.FoundationPopoverPluginOverlayMeasurement then
            self:_closePopover(tbl1, false, tbl1.generation)
            return
        end
        self:_closePopover(tbl1)
    end)

    if panel:IsA("PluginGui") then
        panel.InputBegan:Connect(function(input: InputObject)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and tbl1.open then
                self:_closeChildPopovers(tbl1)
            end
        end)
    end

    return tbl1
end

function module:_activatePopover(tbl1, onClose: ((...any) -> (...any))?, parentPopoverId: string?)
    if Flags.FoundationPopoverPluginOverlayMeasurement then
        tbl1.generation += 1
    end
    tbl1.onClose = onClose
    tbl1.parentPopoverId = parentPopoverId
    tbl1.open = false
    self._active[tbl1.id] = tbl1
end

function module:_tryAcquireFromPool(func1: ((...any) -> (...any))?, num1: number, str1: string?, isFocusable: boolean)
    local var1 = self._pool[num1]
    local var2 = nil
    if Flags.FoundationPopoverPluginFocusable then
        if var1 then
            for i = #var1, 1, -1 do
                if var1[i].isFocusable == isFocusable then
                    var2 = table.remove(var1, i)
                    break
                end
            end
        end
    elseif var1 then
        var2 = table.remove(var1)
    else
        var2 = nil
    end
    if not var2 then
        return nil
    end

    self:_activatePopover(var2, func1, str1)
    return var2
end

function module:_acquirePanelAsync(func1: ((...any) -> (...any))?, num1: number, str1: string?, bool1: boolean)
    local var1 = self:_tryAcquireFromPool(func1, num1, str1, bool1)
    if var1 then
        return var1
    end

    local var2 = self:_createPopoverAsync(self:_makePopoverId(), num1, bool1)
    self:_activatePopover(var2, func1, str1)
    return var2
end

function module:prewarmPoolAsync(num1: number)
    if self._didPrewarm then
        return
    end

    for i = 0, math.max(0, num1) do
        if self._pool[i] == nil then
            self._pool[i] = {}
        end

        local var1 = self._pool[i]
        if #var1 == 0 then
            local var2 = self:_createPopoverAsync(self:_makePopoverId(), i, false)
            var2.panel.Enabled = false
            table.insert(var1, var2)
        end
    end

    self._didPrewarm = true
end

function module:_closeChildPopovers(tbl1)
    local tbl2 = {}
    for _, value in self._active do
        if value.open and value.id ~= tbl1.id and isStrictDescendantOf(self._active, tbl1, value) then
            table.insert(tbl2, value)
        end
    end

    for _, value in tbl2 do
        self:_closePopover(value)
    end
end

function module:_closePopover(tbl1, bool1: boolean?, generation: number?)
    if Flags.FoundationPopoverPluginOverlayMeasurement and generation ~= nil and tbl1.generation ~= generation
        or not tbl1.open
    then
        return
    end

    tbl1.open = false
    tbl1.panel.Enabled = false

    if not bool1 and tbl1.onClose then
        tbl1.onClose()
    end

    self._active[tbl1.id] = nil

    local depth = tbl1.depth
    if not self._pool[depth] then
        self._pool[depth] = {}
    end
    table.insert(self._pool[depth], tbl1)
end

function module:closeAll()
    local tbl1 = {}
    for _, value in self._active do
        table.insert(tbl1, value)
    end
    for _, value in tbl1 do
        self:_closePopover(value)
    end
end

function module:destroy()
    self:closeAll()

    for _, value in self._pool do
        for _, value2 in value do
            if value2.panel then
                value2.panel:Destroy()
            end
        end
    end
    self._pool = {}
end

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
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
    if Flags.FoundationPopoverPluginPoolReclaim then
        self._destroyed = false
    end

    return self
end

function module:openAtAsync(arg1, func1: ((...any) -> (...any))?, num1: number?, str1: string?, bool1: boolean?, vector2: Vector2?)
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
    local var3 = nil
    if Flags.FoundationPopoverPluginPoolReclaim then
        local var4 = vector2 or Vector2.new(0, 0)

        var3 = Vector2.new(math.ceil(math.min(3000, var4.X)), math.ceil(math.min(3000, var4.Y)))
        self._panels:SetSizeAsync(var2.uri, var3)
    else
        self._panels:SetSizeAsync(var2.uri, Vector2.new(0, 0))
    end

    var2.panel.Enabled = true
    var2.open = true
    if Flags.FoundationPopoverPluginPoolReclaim then
        var2.openingThread = nil
    end

    if not Flags.FoundationPopoverPluginPoolReclaim then
        local generation = var2.generation
        return {
            container = var2.panel,
            popoverId = var2.id,
            setSizeAsync = function(vector2_2: Vector2)
                if var2.generation ~= generation or not var2.open then
                    return
                end
                local x = math.ceil(math.min(3000, vector2_2.X))
                local y = math.ceil(math.min(3000, vector2_2.Y))
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

    local generation = var2.generation
    local var4 = table.clone(arg1)

    local num2 = 0
    local num3 = 0
    return {
        container = var2.panel,
        popoverId = var2.id,
        setSizeAsync = function(vector2_2: Vector2)
            if var2.generation ~= generation or not var2.open then
                return
            end

            local var5 = Vector2.new(math.ceil(math.min(3000, vector2_2.X)), math.ceil(math.min(3000, vector2_2.Y)))
            if var3 == var5 then
                return
            end

            var3 = nil
            num3 += 1
            local num4 = num3
            self._panels:SetSizeAsync(var2.uri, var5)
            if num3 == num4 then
                var3 = var5
            end
        end,
        updateAsync = function(arg2)
            if var2.generation ~= generation
                or not var2.open
                or var4
                    and StudioUri.equals(var4.targetWidgetUri, arg2.targetWidgetUri)
                    and var4.targetAnchorPoint == arg2.targetAnchorPoint
                    and var4.subjectAnchorPoint == arg2.subjectAnchorPoint
                    and var4.offset == arg2.offset
            then
                return
            end

            local var5 = table.clone(arg2)
            var4 = nil
            num2 += 1
            local num4 = num2
            self._panels:SetAttachmentAsync(var2.uri, {
                TargetWidgetUri = var5.targetWidgetUri,
                TargetAnchorPoint = var5.targetAnchorPoint,
                SubjectAnchorPoint = var5.subjectAnchorPoint,
                Offset = var5.offset
            })
            if num2 == num4 then
                var4 = var5
            end
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
        InitialEnabled = not Flags.FoundationPopoverPluginPoolReclaim,
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
    if Flags.FoundationPopoverPluginPoolReclaim and self._destroyed then
        panel:Destroy()
        error("PopoverManager is destroyed")
    end

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
        self:_closePopover(tbl1, false, tbl1.generation)
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

function module:_createTrackedPopoverAsync(str1: string, num1: number, bool1: boolean)
    local thread = coroutine.running()
    local bool2 = false
    local bool3 = false
    local bool4 = false
    local var1 = nil

    task.spawn(function()
        bool4, var1 = pcall(self._createPopoverAsync, self, str1, num1, bool1)
        bool2 = true
        if bool4 then
            local var2 = var1
            var2.openingThread = thread
            self._active[str1] = var2
            if coroutine.status(thread) == "dead" then
                self:_closePopover(var2, true, var2.generation)
            end
        end
        if bool3 and coroutine.status(thread) == "suspended" then
            task.spawn(thread)
        end
    end)
    if not bool2 then
        bool3 = true
        coroutine.yield()
    end
    if not bool4 then
        error(var1)
    end
    self._active[str1] = nil
    var1.openingThread = nil
    return var1
end

function module:_activatePopover(tbl1, onClose: ((...any) -> (...any))?, parentPopoverId: string?)
    tbl1.generation += 1
    tbl1.onClose = onClose
    tbl1.parentPopoverId = parentPopoverId
    tbl1.open = false
    if Flags.FoundationPopoverPluginPoolReclaim then
        tbl1.openingThread = coroutine.running()
    end
    self._active[tbl1.id] = tbl1
end

function module:_reclaimAbandonedPopovers()
    local tbl1 = {}
    for _, value in self._active do
        local openingThread = value.openingThread
        if openingThread and coroutine.status(openingThread) == "dead" then
            table.insert(tbl1, value)
        end
    end
    for _, value in tbl1 do
        self:_closePopover(value, true, value.generation)
    end
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
    if Flags.FoundationPopoverPluginPoolReclaim then
        if self._destroyed then
            error("PopoverManager is destroyed")
        end
        self:_reclaimAbandonedPopovers()
    end

    local var1 = self:_tryAcquireFromPool(func1, num1, str1, bool1)
    if var1 then
        return var1
    end

    local var2 = self:_makePopoverId()
    local var3 = if Flags.FoundationPopoverPluginPoolReclaim then self:_createTrackedPopoverAsync(var2, num1, bool1) else self:_createPopoverAsync(var2, num1, bool1)
    self:_activatePopover(var3, func1, str1)
    return var3
end

function module:prewarmPoolAsync(num1: number)
    if Flags.FoundationPopoverPluginPoolReclaim and self._destroyed or self._didPrewarm then
        return
    end

    for i = 0, math.max(0, num1) do
        if self._pool[i] == nil then
            self._pool[i] = {}
        end

        local var1 = self._pool[i]
        if #var1 == 0 then
            local var2 = if Flags.FoundationPopoverPluginPoolReclaim then self:_createTrackedPopoverAsync(self:_makePopoverId(), i, false) else self:_createPopoverAsync(self:_makePopoverId(), i, false)
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
    if generation ~= nil and tbl1.generation ~= generation then
        return
    end

    if not Flags.FoundationPopoverPluginPoolReclaim then
        if tbl1.open then
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

        return
    end

    if self._active[tbl1.id] ~= tbl1 then
        return
    end
    local openingThread = tbl1.openingThread
    if openingThread then
        if coroutine.status(openingThread) == "suspended" then
            task.cancel(openingThread)
        end
        tbl1.openingThread = nil
    end
    tbl1.open = false
    tbl1.panel.Enabled = false
    self._active[tbl1.id] = nil
    local onClose = tbl1.onClose
    tbl1.onClose = nil
    local depth = tbl1.depth
    if not self._pool[depth] then
        self._pool[depth] = {}
    end
    table.insert(self._pool[depth], tbl1)
    if not bool1 and onClose then
        onClose()
    end
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
    if Flags.FoundationPopoverPluginPoolReclaim then
        self._destroyed = true
        self:_reclaimAbandonedPopovers()
    end
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

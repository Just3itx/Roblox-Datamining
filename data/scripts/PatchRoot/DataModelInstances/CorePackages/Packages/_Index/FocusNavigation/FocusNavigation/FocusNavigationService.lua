-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:10:33Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local EventPropagation = require(scriptParentParent.EventPropagation)
local FocusNavigationUtils = require(scriptParentParent.FocusNavigationUtils)
local var1 = require(scriptParentParent.SafeFlags).createGetFFlag("FocusNavigationRefocusSuppression")

local createSignal = FocusNavigationUtils.createSignal
local shallowEqual = FocusNavigationUtils.shallowEqual
local getAncestors = FocusNavigationUtils.getAncestors
local mockableWarn = FocusNavigationUtils.mockableWarn
local isValidFocusTarget = require(script.Parent.isValidFocusTarget)

local _types = require(script.Parent.types)

local module = ({})
module.__index = module

function module.new(_engineInterface, tbl1)
    local activeEventMap, _fireActiveEventMapSignal = createSignal({})
    local focusedGuiObject, _fireFocusedGuiObjectSignal = createSignal(_engineInterface.getSelection())
    local eventDispatched, _fireEventDispatchedSignal = createSignal(nil)

    local self = setmetatable({
        _eventPropagationService = EventPropagation.new(),
        _engineInterface = _engineInterface,
        _eventMapByInstance = setmetatable({}, { __mode = "k" }),
        _focusBehaviorByInstance = setmetatable({}, { __mode = "k" }),
        _engineEventConnections = {},
        _silentFocusTarget = nil,
        _silentBlurTarget = nil,
        _shouldSuppressContainerRefocus = if tbl1 then tbl1.shouldSuppressContainerRefocus else nil,
        _fireActiveEventMapSignal = _fireActiveEventMapSignal,
        _fireFocusedGuiObjectSignal = _fireFocusedGuiObjectSignal,
        _fireEventDispatchedSignal = _fireEventDispatchedSignal,
        activeEventMap = activeEventMap,
        focusedGuiObject = focusedGuiObject,
        eventDispatched = eventDispatched
    }, module)

    self:_connectToInputEvents()

    return self
end

function module:_fireInputEvent(target, arg1, wasProcessed: boolean?)
    local eventName = self.activeEventMap:getValue()[arg1.KeyCode]

    if not eventName then
        return
    end

    local eventData = {
        Delta = arg1.Delta,
        KeyCode = arg1.KeyCode,
        Position = arg1.Position,
        UserInputState = arg1.UserInputState,
        UserInputType = arg1.UserInputType,
        wasProcessed = wasProcessed
    }
    self._eventPropagationService:propagateEvent(target, eventName, eventData, { synthetic = false, silent = false })

    self._fireEventDispatchedSignal({ eventName = eventName, target = target, eventData = eventData, synthetic = false })
end

function module:_connectToInputEvents()
    local function forwardInputEvent(input: InputObject, arg1)
        local selection = self._engineInterface.getSelection()
        if selection then
            self:_fireInputEvent(selection, input, arg1)
        end
    end
    table.insert(self._engineEventConnections, self._engineInterface.InputBegan:Connect(forwardInputEvent))
    table.insert(self._engineEventConnections, self._engineInterface.InputChanged:Connect(forwardInputEvent))
    table.insert(self._engineEventConnections, self._engineInterface.InputEnded:Connect(forwardInputEvent))

    local _engineEventConnections = self._engineEventConnections
    local selectionChanged = self._engineInterface.SelectionChanged

    table.insert(_engineEventConnections, selectionChanged:Connect(function() -- name: onFocusChanged
        local value = self.focusedGuiObject:getValue()
        local selection = self._engineInterface.getSelection()

        if value then
            local silent = self._silentBlurTarget == value
            self._eventPropagationService:propagateEvent(value, "blur", nil, { synthetic = false, silent = silent })

            self._silentBlurTarget = nil
        end
        self._fireFocusedGuiObjectSignal(selection)
        if selection then
            local silent = selection == self._silentFocusTarget
            self._eventPropagationService:propagateEvent(selection, "focus", nil, { synthetic = false, silent = silent })

            self._silentFocusTarget = nil
        end
        self:_updateActiveEventMap(value)
    end))
end

function module:_cancelHandler(arg1, arg2)
    if arg2 == "blur" or arg2 == "focus" then
        return
    end

    self._eventPropagationService:propagateEvent(
        arg1,
        arg2,
        {
            KeyCode = Enum.KeyCode.None,
            UserInputType = Enum.UserInputType.None,
            UserInputState = Enum.UserInputState.Cancel
        },
        { synthetic = false, silent = false }
    )
end

function module:_updateActiveEventMap(arg1)
    local tbl1 = ({})
    local selection = self._engineInterface.getSelection()
    if selection then
        local ancestors = getAncestors(selection)

        local tbl2 = ({})
        for i = #ancestors, 1, -1 do
            local ancestor = ancestors[i]
            local var2 = self._eventMapByInstance[ancestor]
            if var2 then
                for value, value2 in var2 do
                    tbl2[value] = value2

                    tbl1[value] = nil
                end
            end
            local registeredEventHandlers = self._eventPropagationService:getRegisteredEventHandlers(ancestor)
            if not registeredEventHandlers then
                continue
            end

            for value, value2 in tbl2 do
                if registeredEventHandlers[value2] then
                    tbl1[value] = value2
                end
            end
        end
    end

    local value = self.activeEventMap:getValue()
    if shallowEqual(value, tbl1) then
        return
    end

    if arg1 then
        for value2, value3 in value do
            if not tbl1[value2] then
                self:_cancelHandler(arg1, value3)
            end
        end
    end
    self._fireActiveEventMapSignal(tbl1)
end

function module:registerEventMap(arg1, arg2)
    local var2 = self._eventMapByInstance[arg1] or {}
    for value, value2 in arg2 do
        if var2[value] and var2[value] ~= value2 and _G.__DEV__ then
            mockableWarn(
                string.format(
                    "New event will replace existing registered event mapped to %s:\n\t     new event: %s\n\texisting event: %s",
                    tostring(value),
                    value2,
                    var2[value]
                )
            )
        end

        var2[value] = value2
    end
    self._eventMapByInstance[arg1] = var2
    self:_updateActiveEventMap()
end

function module:deregisterEventMap(arg1, arg2)
    local var2 = self._eventMapByInstance[arg1] or {}
    for value, value2 in arg2 do
        if var2[value] == value2 then
            var2[value] = nil
        elseif _G.__DEV__ then
            mockableWarn(
                string.format(
                    "Cannot deregister non-matching event input %s:\n\t  provided event: %s\n\tregistered event: %s",
                    tostring(value),
                    value2,
                    var2[value]
                )
            )
        end
    end

    self._eventMapByInstance[arg1] = var2
    self:_updateActiveEventMap(self.focusedGuiObject:getValue())
end

function module:registerEventHandler(arg1, str1: string, func1: (...any) -> (...any), arg2)
    self._eventPropagationService:registerEventHandler(arg1, str1, func1, arg2)
    self:_updateActiveEventMap()
end

function module:deregisterEventHandler(arg1, str1: string, func1: (...any) -> (...any), arg2)
    self:_cancelHandler(arg1, str1)
    self._eventPropagationService:deregisterEventHandler(arg1, str1, func1, arg2)
    self:_updateActiveEventMap(self.focusedGuiObject:getValue())
end

function module:registerEventHandlers(arg1, arg2)
    self._eventPropagationService:registerEventHandlers(arg1, arg2)
    self:_updateActiveEventMap()
end

function module:deregisterEventHandlers(arg1, arg2)
    for value, _ in arg2 do
        self:_cancelHandler(arg1, value)
    end

    self._eventPropagationService:deregisterEventHandlers(arg1, arg2)
    self:_updateActiveEventMap(self.focusedGuiObject:getValue())
end

function module:registerFocusBehavior(arg1, behavior)
    if _G.__DEV__ then
        local var2 = self._focusBehaviorByInstance[arg1]
        if var2 ~= nil then
            mockableWarn(
                string.format(
                    "New focus behavior will replace existing registered focus behavior:\n\t     new behavior: %s\n\texisting behavior: %s",
                    tostring(behavior),
                    tostring(var2.behavior)
                )
            )
        end
    end
    local tbl1 = {
        behavior = behavior,
        connection = arg1.SelectionChanged:Connect(function(arg2, arg3, arg4)
            if not arg4 or not arg2 and not arg4:IsDescendantOf(arg1) then
                return
            end

            if arg3 and arg3:IsDescendantOf(arg1) then
                if behavior.onDescendantFocusChanged then
                    behavior.onDescendantFocusChanged(arg4)
                end

                return
            end

            local bool1 = false

            if not (var1() and self._shouldSuppressContainerRefocus and self._shouldSuppressContainerRefocus()) then
                for _, value in behavior.getTargets() do
                    if isValidFocusTarget(value) then
                        self:focusGuiObject(value, false)
                        bool1 = true
                        break
                    end
                end
            end

            if not bool1 and behavior.onDescendantFocusChanged then
                behavior.onDescendantFocusChanged(arg4)
            end
        end)
    }

    self._focusBehaviorByInstance[arg1] = tbl1
end

function module:deregisterFocusBehavior(arg1, behavior)
    local var2 = self._focusBehaviorByInstance[arg1]
    if _G.__DEV__ then
        if not var2 then
            mockableWarn(
                string.format("Cannot deregister an unregistered focus behavior:\n\t  provided behavior: %s", tostring(behavior))
            )
        end

        if var2 and var2.behavior ~= behavior then
            mockableWarn(
                string.format(
                    "Cannot deregister non-matching focus behavior:\n\t  provided behavior: %s\n\tregistered behavior: %s",
                    tostring(behavior),
                    tostring(var2.behavior)
                )
            )
        end
    end

    if var2 then
        var2.connection:Disconnect()
        self._focusBehaviorByInstance[arg1] = nil
    end
end

function module:focusGuiObject(_silentFocusTarget, bool1: boolean)
    if bool1 then
        self._silentBlurTarget = self._engineInterface.getSelection()
        self._silentFocusTarget = _silentFocusTarget
    else
        self._silentBlurTarget = nil
        self._silentFocusTarget = nil
    end
    self._engineInterface.setSelection(_silentFocusTarget)
end

function module:teardown()
    for _, _engineEventConnection in self._engineEventConnections do
        _engineEventConnection:Disconnect()
    end
    for _, value in self._focusBehaviorByInstance do
        value.connection:Disconnect()
    end
end

function module:canDispatchEvent(str1: string, arg1)
    if not arg1 then
        return false
    end

    for _, value in (getAncestors(arg1)) do
        local var2 = self._eventMapByInstance[value]
        if not var2 then
            continue
        end

        for _, value2 in var2 do
            if value2 ~= str1 then
                continue
            end

            local registeredEventHandlers = self._eventPropagationService:getRegisteredEventHandlers(value)
            if registeredEventHandlers and registeredEventHandlers[str1] then
                return true
            end
        end
    end

    return false
end

function module:dispatchSyntheticEvent(eventName: string, target, eventData): boolean
    if not target then
        if _G.__DEV__ then
            mockableWarn("dispatchSyntheticEvent: No target object")
        end
        return false
    end

    if not self:canDispatchEvent(eventName, target) then
        if _G.__DEV__ then
            mockableWarn("dispatchSyntheticEvent: Cannot dispatch event \"" .. eventName .. "\" on target")
        end
        return false
    end

    self._eventPropagationService:propagateEvent(target, eventName, eventData, { synthetic = true, silent = false })

    self._fireEventDispatchedSignal({ eventName = eventName, target = target, eventData = eventData, synthetic = true })

    return true
end

return module

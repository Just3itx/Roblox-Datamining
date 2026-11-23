-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:41:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserTileParent = script:FindFirstAncestor("UserTile").Parent

local React = require(UserTileParent.React)
local HoldDetector = require(UserTileParent.HoldToPlay).HoldDetector
local ReactFocusNavigation = require(UserTileParent.ReactFocusNavigation)
local InputHandlers = require(UserTileParent.InputHandlers)
local _FocusNavigationUtils = require(UserTileParent.FocusNavigationUtils)

local FFlagUserSearchCancelTileActivationOnHoldIntent = require(UserTileParent.SharedFlags).FFlagUserSearchCancelTileActivationOnHoldIntent

local tbl1 = {
    primary = Enum.KeyCode.ButtonA,
    secondary = Enum.KeyCode.ButtonX
}

local function UserTileEventHandlers(tbl2)
    local tileRef = tbl2.tileRef
    local buttons = tbl2.buttons
    local onTileActivated = tbl2.onTileActivated

    local var1 = React.useRef(false)

    local setDisabledForHold = React.useCallback(function(current: boolean)
        var1.current = current
        if FFlagUserSearchCancelTileActivationOnHoldIntent and tbl2.setDisabledForHold then
            tbl2.setDisabledForHold(current)
        end
    end, FFlagUserSearchCancelTileActivationOnHoldIntent and { tbl2.setDisabledForHold } or {})

    local var3, var4 = React.useMemo(function()
        if buttons then
            return buttons[#buttons], buttons[#buttons - 1]
        end
        return nil, nil
    end, { buttons })

    local onRegularActivated = React.useCallback(function()
        if var1.current then
            return
        end
        onTileActivated()
    end, { onTileActivated })

    local onHoldDetected = React.useCallback(function()
        if var3 and var3.onActivated then
            var3.onActivated()
        end
    end, { var3 })

    local var7 = React.useCallback(function()
        if var4 and var4.onActivated then
            var4.onActivated()
        end
    end, { var4 })

    local var8, var9 = React.useMemo(function()
        local focusEventName = if var4 then var4.focusEventName else nil

        if not focusEventName then
            return {}, {}
        end

        return {
            [tbl1.secondary] = focusEventName
        }, {
            [focusEventName] = {
                handler = InputHandlers.onRelease(var7)
            }
        }
    end, { var4, var7 })

    local var10 = ReactFocusNavigation.useEventMap(var8)

    local var11 = ReactFocusNavigation.useEventHandlerMap(var9, var10)

    local useEffect = React.useEffect
    local function func1()
        if var11 and tileRef then
            var11(tileRef.current)
        end
        return function()
            var11(nil)
        end
    end

    local var12 = if FFlagUserSearchCancelTileActivationOnHoldIntent then tileRef else nil
    useEffect(func1, { var11, var12 })

    if FFlagUserSearchCancelTileActivationOnHoldIntent then
        React.useEffect(function()
            if not tileRef then
                return
            end
            local current = tileRef.current
            if not current then
                return
            end
            local function clearHoldGuard() -- Luacid: Inlined by compiler; 1 call site recovered
                if not var1.current then
                    return
                end
                var1.current = false
                if tbl2.setDisabledForHold then
                    tbl2.setDisabledForHold(false)
                end
            end
            local connection = current.SelectionLost:Connect(clearHoldGuard)
            local connection2 = current.InputBegan:Connect(function(input: InputObject)
                local userInputType = input.UserInputType
                local bool1 = userInputType == Enum.UserInputType.MouseButton1 or userInputType == Enum.UserInputType.Touch
                local bool2 = input.KeyCode == tbl1.primary
                if input.UserInputState == Enum.UserInputState.Begin and (bool1 or bool2) then
                    clearHoldGuard()
                end
            end)

            return function()
                connection:Disconnect()
                connection2:Disconnect()
            end
        end, { tbl2.setDisabledForHold, tileRef })
    end

    local focusEventName = if var3 then var3.focusEventName or nil else nil

    if not (tileRef.current and focusEventName) then
        return nil
    end

    return (React.createElement(HoldDetector, {
        guiObject = tileRef.current,
        onHoldDetected = onHoldDetected,
        onRegularActivated = onRegularActivated,
        setDisabledForHold = setDisabledForHold,
        keyCode = tbl1.primary,
        focusNavigationEventName = focusEventName,
        disableRegularActionOnHoldIntent = tbl2.disableRegularActionOnHoldIntent
    }))
end
return UserTileEventHandlers

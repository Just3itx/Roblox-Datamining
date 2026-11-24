-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FocusNavigationUtils = script:FindFirstAncestor("FocusNavigationUtils")
local FocusNavigationUtilsParent = FocusNavigationUtils.Parent

local ArgCheck = require(FocusNavigationUtilsParent.ArgCheck)
local ButtonHoldStateEnum = require(FocusNavigationUtils.ButtonHoldStateEnum)
local ButtonHoldCompletedSignal = require(FocusNavigationUtils.ButtonHoldCompletedSignal)
local FFlagEnableFocusNavTelemetry = require(FocusNavigationUtilsParent.SharedFlags).FFlagEnableFocusNavTelemetry

local InputHandlers = require(FocusNavigationUtilsParent.InputHandlers)
local React = require(FocusNavigationUtilsParent.React)

local function useFakeCancelHoldAfterBlur<T>(arg1, callback: T, callback2: T)
    local var1 = React.useCallback(function()
        callback({ eventData = { UserInputState = Enum.UserInputState.End } })

        callback2()
    end, { callback, callback2 })

    React.useEffect(function()
        if not (arg1 and arg1:IsA("GuiObject")) then
            return function() end
        end

        local connection = arg1.SelectionLost:Connect(var1)
        return function()
            connection:Disconnect()
        end
    end, { arg1, var1 })
end

local function useButtonHold(num1: number, durationSeconds: number, allowReleaseAfterHold: boolean?)
    ArgCheck.assert(num1 >= 0, "signalHoldIntentSeconds must be greater than or equal to 0")
    ArgCheck.assert(durationSeconds > 0, "signalHoldCompleteSeconds must be greater than 0")
    ArgCheck.assert(num1 < durationSeconds, "signalHoldIntentSeconds should be less than signalHoldCompleteSeconds")

    local holdState, var2 = React.useState(ButtonHoldStateEnum.NOT_HELD)
    local var3 = React.useRef(nil)

    local holdTime, var5 = React.useBinding(0)
    local var6, var7 = React.useState(nil)
    local var8 = if FFlagEnableFocusNavTelemetry then React.useRef(nil) else nil

    local onPress = React.useCallback(function()
        var3.current = tick()
        var2(ButtonHoldStateEnum.JUST_PRESSED)
    end, {})

    local onStep = React.useCallback(function(_)
        local now = tick()
        ArgCheck.assert(var3.current ~= nil, "startTime.current should not be nil")
        if var3.current then
            ArgCheck.assert(var3.current <= now, "startTime.current should be less than or equal to tick()")

            var5(now - var3.current)
        end
        if holdTime:getValue() >= num1 then
            var2(ButtonHoldStateEnum.HOLDING)
        end
    end, { holdTime, num1 })

    local onComplete = React.useCallback(function()
        var5(durationSeconds)
        var3.current = nil
        var2(ButtonHoldStateEnum.COMPLETED)
        if FFlagEnableFocusNavTelemetry and var8 and var8.current then
            local current = var8.current
            ButtonHoldCompletedSignal:fire(current.eventName, current.keyCode, current.userInputType)
        end
    end, { durationSeconds })

    local var12 = React.useCallback(function()
        var5(0)
        var3.current = nil
        var2(ButtonHoldStateEnum.NOT_HELD)
    end, {})

    local var13 = React.useCallback(
        InputHandlers.handleInput({
            hold = {
                durationSeconds = durationSeconds,
                onStep = onStep,
                onComplete = onComplete,
                allowReleaseAfterHold = allowReleaseAfterHold
            },
            onPress = onPress,
            onRelease = var12
        }),
        {
            var12,
            onStep,
            onComplete,
            durationSeconds,
            allowReleaseAfterHold
        }
    )

    local eventHandler = React.useCallback(function(arg1)
        var7(arg1.targetInstance)
        if FFlagEnableFocusNavTelemetry and var8 and arg1.eventName then
            local var14 = var8
            var14.current = {
                eventName = arg1.eventName,
                keyCode = if arg1.eventData then arg1.eventData.KeyCode else nil,
                userInputType = if arg1.eventData then arg1.eventData.UserInputType else nil
            }
        end
        var13(arg1)
    end, { var13 })

    useFakeCancelHoldAfterBlur(var6, var13, var12)

    return {
        eventHandler = eventHandler,
        holdState = holdState,
        holdTime = holdTime,
        holdProgress = holdTime:map(function(num3: number): number
            return num3 / durationSeconds
        end),
        cancelHold = var12
    }
end

return useButtonHold

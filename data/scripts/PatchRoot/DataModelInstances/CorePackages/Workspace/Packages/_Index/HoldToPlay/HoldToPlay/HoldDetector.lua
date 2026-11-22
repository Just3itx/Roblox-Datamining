-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HoldToPlay = script:FindFirstAncestor("HoldToPlay")
local HoldToPlayParent = HoldToPlay.Parent

local React = require(HoldToPlayParent.React)
local useSelected = require(HoldToPlayParent.GuiObjectUtils).useSelected
local FocusNavigationUtils = require(HoldToPlayParent.FocusNavigationUtils)
local ReactFocusNavigation = require(HoldToPlayParent.ReactFocusNavigation)
local AppShortcutBarContext = require(HoldToPlayParent.AppShortcutBar).AppShortcutBarContext
local useButtonHold = FocusNavigationUtils.useButtonHold
local ButtonHoldStateEnum = FocusNavigationUtils.ButtonHoldStateEnum
local Constants = require(HoldToPlay.Constants)

local FFlagUserSearchCancelTileActivationOnHoldIntent = require(HoldToPlayParent.SharedFlags).FFlagUserSearchCancelTileActivationOnHoldIntent

local function HoldDetectorForSelectedObject(tbl1)
    local var1, var2 = React.useState(nil)

    local var3, var4 = React.useState(nil)
    local var5 = var1 or tbl1.keyCode
    local var6 = var3 or tbl1.focusNavigationEventName

    local var7 = React.useRef(false)
    local var8 = React.useRef(false)

    local var9 = useButtonHold(Constants.SIGNAL_HOLD_INTENT_SECONDS, Constants.SIGNAL_HOLD_COMPLETE_SECONDS, true)
    local var10 = AppShortcutBarContext.useDispatchButtonHoldStarted()
    local var11 = AppShortcutBarContext.useDispatchButtonHoldEnded()

    local bool1 = var9.holdState == ButtonHoldStateEnum.HOLDING
        or var9.holdState == ButtonHoldStateEnum.JUST_PRESSED
        or var9.holdState == ButtonHoldStateEnum.COMPLETED
    local var12 = FFlagUserSearchCancelTileActivationOnHoldIntent
        and (var9.holdState == ButtonHoldStateEnum.HOLDING or var9.holdState == ButtonHoldStateEnum.COMPLETED)

    local var13 = FFlagUserSearchCancelTileActivationOnHoldIntent and tbl1.disableRegularActionOnHoldIntent == true

    local useEffect = React.useEffect
    local function func1()
        if var13 then
            if tbl1.setDisabledForHold then
                tbl1.setDisabledForHold(var12)
            end
        elseif not bool1 and tbl1.setDisabledForHold then
            tbl1.setDisabledForHold(false)
        end

        return function()
            if tbl1.setDisabledForHold and not (FFlagUserSearchCancelTileActivationOnHoldIntent and var13 and var12) then
                tbl1.setDisabledForHold(false)
            end
        end
    end

    local setDisabledForHold = tbl1.setDisabledForHold
    local var14 = if var13 then var12 else false
    useEffect(func1, { bool1, setDisabledForHold, var14 })

    React.useEffect(function()
        if not var7.current and bool1 then
            var7.current = true
            if tbl1.focusNavigationEventName then
                var10(tbl1.focusNavigationEventName, var9.holdProgress)
            end

            var2(tbl1.keyCode)
            var4(tbl1.focusNavigationEventName)
            return
        end

        if not var7.current or bool1 then
            return
        end

        if var6 then
            var11(var6)
        end
        var2(nil)
        var4(nil)

        var7.current = false
        if var8.current then
            var8.current = false
        end
    end, {
        bool1,
        var9.holdProgress,
        var10,
        var11,
        tbl1.focusNavigationEventName,
        tbl1.keyCode,
        var6,
        var5
    })

    local bool2 = var9.holdState == ButtonHoldStateEnum.COMPLETED and var8.current == false

    React.useEffect(function()
        if not bool2 or not tbl1.onHoldDetected then
            return
        end

        var8.current = true

        if tbl1.setDisabledForHold and not var13 then
            tbl1.setDisabledForHold(true)
        end

        tbl1.onHoldDetected(tbl1.guiObject)
    end, {
        bool2,
        tbl1.onHoldDetected,
        tbl1.guiObject,
        tbl1.setDisabledForHold,
        var13
    })

    local var15 = React.useMemo(function()
        return if var5 and var6 then {
            [var5] = var6
        } else {}
    end, { var5, var6 })

    local var16 = React.useMemo(function()
        return if var6 then {
            [var6] = {
                handler = var9.eventHandler
            }
        } else {}
    end, { var9.eventHandler, var6 })

    local var17 = ReactFocusNavigation.useEventMap(var15)

    local var18 = ReactFocusNavigation.useEventHandlerMap(var16, var17)

    React.useEffect(function()
        if var18 then
            var18(tbl1.guiObject)
        end
        return function()
            var18(nil)
        end
    end, { var18, tbl1.guiObject })

    return nil
end

return React.memo(function(tbl1) -- name: HoldDetector
    if useSelected({ current = tbl1.guiObject }) then
        return React.createElement(HoldDetectorForSelectedObject, tbl1)
    end
    return nil
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T19:50:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameJoinCardParent = script:FindFirstAncestor("GameJoinCard").Parent

local React = require(GameJoinCardParent.React)
local ReactFocusNavigation = require(GameJoinCardParent.ReactFocusNavigation)
local FocusNavigationUtils = require(GameJoinCardParent.FocusNavigationUtils)
local HoldToPlay = require(GameJoinCardParent.HoldToPlay)
local AppShortcutBarContext = require(GameJoinCardParent.AppShortcutBar).AppShortcutBarContext

local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local ButtonHoldStateEnum = FocusNavigationUtils.ButtonHoldStateEnum
local useButtonHold = FocusNavigationUtils.useButtonHold
local Constants = HoldToPlay.Constants

local function GamepadJoinFocusBehavior(tbl1)
    local var1 = ReactFocusNavigation.useFocusedGuiObject()

    local var2 = React.useRef(tbl1.joinExperience)
    var2.current = tbl1.joinExperience

    local var3 = useButtonHold(Constants.SIGNAL_HOLD_INTENT_SECONDS, Constants.SIGNAL_HOLD_COMPLETE_SECONDS)

    local var4 = AppShortcutBarContext.useDispatchButtonHoldStarted()
    local var5 = AppShortcutBarContext.useDispatchButtonHoldEnded()

    local var6 = React.useRef(false)
    local bool1 = var3.holdState == ButtonHoldStateEnum.HOLDING
        or var3.holdState == ButtonHoldStateEnum.JUST_PRESSED
        or var3.holdState == ButtonHoldStateEnum.COMPLETED

    React.useEffect(function()
        if not var6.current and bool1 then
            var6.current = true
            var4(FocusNavigationEventNameEnum.HoldToJoinFriend, var3.holdProgress)
        elseif var6.current and not bool1 then
            var5(FocusNavigationEventNameEnum.HoldToJoinFriend)
            var6.current = false
        end
    end, {
        bool1,
        var3.holdProgress,
        var4,
        var5
    })

    local var7 = React.useRef(false)
    React.useEffect(function()
        if var3.holdState ~= ButtonHoldStateEnum.COMPLETED then
            var7.current = false
            return
        end

        if var7.current then
            return
        end

        var7.current = true
        var2.current()
        if var3.cancelHold then
            var3.cancelHold()
        end
    end, { var3.holdState, var3.cancelHold })

    local var8 = React.useMemo(function()
        return {
            [Enum.KeyCode.ButtonA] = FocusNavigationEventNameEnum.HoldToJoinFriend
        }
    end, {})

    local var9 = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.HoldToJoinFriend] = {
                handler = var3.eventHandler
            }
        }
    end, { var3.eventHandler })

    local var10 = ReactFocusNavigation.useEventMap(var8)

    local var11 = ReactFocusNavigation.useEventHandlerMap(var9, var10)

    React.useEffect(function()
        if not var11 then
            return
        end

        local current = tbl1.tileRef.current
        local current2 = if tbl1.cardRef then tbl1.cardRef.current else nil
        local var12 = nil
        if var1 then
            local var13 = current and (var1 == current or var1:IsDescendantOf(current))
            local var14 = current2 and (var1 == current2 or var1:IsDescendantOf(current2))
            if var13 or var14 then
                var12 = var1
            end
        end
        var11(var12)
        return function()
            var11(nil)
        end
    end, {
        var11,
        tbl1.tileRef,
        tbl1.cardRef,
        var1
    })
    return nil
end

return GamepadJoinFocusBehavior

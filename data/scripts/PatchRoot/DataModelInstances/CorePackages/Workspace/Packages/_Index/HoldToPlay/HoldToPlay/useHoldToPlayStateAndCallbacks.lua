-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T00:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HoldToPlay = script:FindFirstAncestor("HoldToPlay")
local HoldToPlayParent = HoldToPlay.Parent
local React = require(HoldToPlayParent.React)
local FocusNavigationUtils = require(HoldToPlayParent.FocusNavigationUtils)
local useButtonHold = FocusNavigationUtils.useButtonHold
local Constants = require(HoldToPlay.Constants)
local ButtonHoldStateEnum = FocusNavigationUtils.ButtonHoldStateEnum

local function useHoldToPlayStateAndCallbacks(num1: number?, num2: number?)
    local var1 = useButtonHold(num1 or Constants.SIGNAL_HOLD_INTENT_SECONDS, num2 or Constants.SIGNAL_HOLD_COMPLETE_SECONDS)

    local selectedNavigationUniverseId, var3 = React.useState(nil)
    local selectedIndex, var5 = React.useState(nil)
    local selectedEntry, var7 = React.useState(nil)

    local onHoldableFocused = React.useCallback(function(arg1, arg2, arg3)
        var7(arg1)
        var5(arg2)
        var3(arg3)
    end, {})

    local onHoldableUnfocused = React.useCallback(function()
        var3(nil)
        var5(nil)
        var7(nil)
    end, {})

    local bool1 = var1.holdState == ButtonHoldStateEnum.HOLDING or var1.holdState == ButtonHoldStateEnum.COMPLETED
    return {
        selectedEntry = selectedEntry,
        selectedIndex = selectedIndex,
        selectedNavigationUniverseId = selectedNavigationUniverseId,
        onHoldableFocused = onHoldableFocused,
        onHoldableUnfocused = onHoldableUnfocused,
        shouldRenderHoldToPlayLauncher = selectedEntry ~= nil,
        shouldDisableHoldable = React.useCallback(function(num3: number)
            return bool1 and selectedIndex and num3 == selectedIndex
        end, { bool1, selectedIndex }),
        holdState = var1.holdState,
        holdProgress = var1.holdProgress,
        cancelHold = var1.cancelHold,
        holdToPlayEventHandler = var1.eventHandler
    }
end

return useHoldToPlayStateAndCallbacks

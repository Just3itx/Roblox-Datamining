-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:41:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShop = script:FindFirstAncestor("InExperienceShop")
local InExperienceShopParent = InExperienceShop.Parent

local React = require(InExperienceShopParent.React)
local SignalsReact = require(InExperienceShopParent.SignalsReact)

local FFlagLuaAppEnableGamePassFreeTrials = require(InExperienceShop.Flags.FFlagLuaAppEnableGamePassFreeTrials)
local FFlagEnableFreeTrialTopBarChip = require(InExperienceShop.Flags.FFlagEnableFreeTrialTopBarChip)
local getInExperienceShopStore = require(InExperienceShop.Stores.getInExperienceShopStore)
local _Types = require(InExperienceShop.Types)

local function useGamePassTrialRedemption(str1: string, arg1, str2: string?)
    local var1 = SignalsReact.useSignalState(getInExperienceShopStore)

    local isActionLoading = SignalsReact.useSignalState(function(arg2): boolean
        return if FFlagLuaAppEnableGamePassFreeTrials then var1.getTrialRedemptionInFlight(arg2)[str1] == true else false
    end)

    local isActionDisabled = SignalsReact.useSignalState(function(arg2): boolean
        return if FFlagLuaAppEnableGamePassFreeTrials then next(var1.getTrialRedemptionInFlight(arg2)) ~= nil else false
    end)

    local useCallback = React.useCallback
    local function func1()
        if FFlagLuaAppEnableGamePassFreeTrials then
            var1.redeemGamePassTrial(str1, arg1, if FFlagEnableFreeTrialTopBarChip then str2 else nil)
        end
    end

    local var4 = if FFlagEnableFreeTrialTopBarChip then str2 else nil
    return {
        isActionLoading = isActionLoading,
        isActionDisabled = isActionDisabled,
        onTryActivated = useCallback(func1, { str1, arg1, var4, var1.redeemGamePassTrial })
    }
end

return useGamePassTrialRedemption

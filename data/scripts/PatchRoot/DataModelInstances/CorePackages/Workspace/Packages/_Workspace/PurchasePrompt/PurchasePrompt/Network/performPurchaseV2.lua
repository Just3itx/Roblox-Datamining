-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local PurchaseError = require(scriptParentParent.Enums.PurchaseError)
local Constants = require(scriptParentParent.Misc.Constants)
local Promise = require(scriptParentParent.Promise)
local isGenericChallengeResponse = require(scriptParentParent.Utils.isGenericChallengeResponse)

local scriptParentParentParent = scriptParentParent.Parent
local isEconomicRestrictionResponse = require(scriptParentParentParent.IAPExperience).Utility.isEconomicRestrictionResponse

local FFlagEnablePriceChangedErrorHandling = require(scriptParentParent.Flags.FFlagEnablePriceChangedErrorHandling)

local function performPurchaseV2(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    return arg1.performPurchaseV2(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12):andThen(function(arg13)
        if arg13.purchased or arg13.reason == "AlreadyOwned" then
            return Promise.resolve(arg13)
        elseif arg13.reason == Constants.PurchaseFailureReason.EconomyDisabled then
            return Promise.reject(PurchaseError.PurchaseDisabled)
        elseif arg13.reason == Constants.PurchaseFailureReason.TwoStepVerificationRequired or arg13.transactionStatus == 24 then
            return Promise.reject(PurchaseError.TwoFactorNeeded)
        elseif isGenericChallengeResponse(arg13) or isEconomicRestrictionResponse(arg13) then
            return Promise.reject(arg13)
        elseif FFlagEnablePriceChangedErrorHandling and arg13.reason == Constants.PurchaseFailureReason.PriceChanged then
            return Promise.reject(PurchaseError.PriceChanged)
        end
        return Promise.reject(PurchaseError.UnknownFailure)
    end, function(_)
        return Promise.reject(PurchaseError.UnknownFailure)
    end)
end

return performPurchaseV2

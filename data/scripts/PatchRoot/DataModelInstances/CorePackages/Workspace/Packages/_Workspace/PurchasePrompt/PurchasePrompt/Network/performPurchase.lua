-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")

local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local Constants = require(PurchasePrompt.Misc.Constants)
local Promise = require(PurchasePrompt.Promise)
local isGenericChallengeResponse = require(PurchasePrompt.Utils.isGenericChallengeResponse)

local PurchasePromptParent = PurchasePrompt.Parent
local isEconomicRestrictionResponse = require(PurchasePromptParent.IAPExperience).Utility.isEconomicRestrictionResponse

local SharedFlags = require(PurchasePromptParent.SharedFlags)

local FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow = SharedFlags.FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow

local FFlagEnablePurchasePayloadInExperienceShop = SharedFlags.FFlagEnablePurchasePayloadInExperienceShop

local FFlagEnablePriceChangedErrorHandling = require(PurchasePrompt.Flags.FFlagEnablePriceChangedErrorHandling)

local function performPurchase(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)
    local performPurchase2 = arg1.performPurchase

    if not FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow then
        arg11 = nil
    end

    if not FFlagEnablePurchasePayloadInExperienceShop then
        arg12 = nil
    end

    return performPurchase2(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13):andThen(function(arg14)
        if arg14.purchased or arg14.reason == "AlreadyOwned" then
            return Promise.resolve(arg14)
        elseif arg14.reason == Constants.PurchaseFailureReason.EconomyDisabled then
            return Promise.reject(PurchaseError.PurchaseDisabled)
        elseif arg14.reason == Constants.PurchaseFailureReason.TwoStepVerificationRequired or arg14.transactionStatus == 24 then
            return Promise.reject(PurchaseError.TwoFactorNeeded)
        elseif isGenericChallengeResponse(arg14) or isEconomicRestrictionResponse(arg14) then
            return Promise.reject(arg14)
        elseif FFlagEnablePriceChangedErrorHandling and arg14.reason == Constants.PurchaseFailureReason.PriceChanged then
            return Promise.reject(PurchaseError.PriceChanged)
        end
        return Promise.reject(PurchaseError.UnknownFailure)
    end, function(_)
        return Promise.reject(PurchaseError.UnknownFailure)
    end)
end

return performPurchase

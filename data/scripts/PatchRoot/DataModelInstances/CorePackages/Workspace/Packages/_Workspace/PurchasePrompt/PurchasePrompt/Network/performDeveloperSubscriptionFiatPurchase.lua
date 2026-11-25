-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local Promise = require(PurchasePrompt.Promise)
local isEconomicRestrictionResponse = require(PurchasePromptParent.IAPExperience).Utility.isEconomicRestrictionResponse
local parseSubscriptionError = require(PurchasePrompt.Utils.parseSubscriptionError)

local function performDeveloperSubscriptionFiatPurchase(arg1, str1: string)
    return arg1.performSubscriptionPurchase(str1, ""):andThen(function(arg2)
        if isEconomicRestrictionResponse(arg2) then
            return Promise.reject(arg2)
        end

        return Promise.resolve(arg2)
    end, function(arg2)
        if type(arg2) == "string" then
            return Promise.reject(parseSubscriptionError(arg2))
        end
        return Promise.reject(PurchaseError.UnknownFailure)
    end)
end

return performDeveloperSubscriptionFiatPurchase

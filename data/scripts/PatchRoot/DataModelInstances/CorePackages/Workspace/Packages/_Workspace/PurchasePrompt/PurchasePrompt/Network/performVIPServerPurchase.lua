-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local Promise = require(PurchasePrompt.Promise)
local IAPExperience = require(PurchasePromptParent.IAPExperience)
local _types = require(PurchasePrompt.types)

local isEconomicRestrictionResponse = IAPExperience.Utility.isEconomicRestrictionResponse

local function performVIPServerPurchase(arg1, num1: number, arg2)
    return arg1.performVIPServerPurchase(num1, arg2):andThen(function(arg3)
        if isEconomicRestrictionResponse(arg3) then
            return Promise.reject(arg3)
        elseif type(arg3) ~= "table" or type(arg3.vipServerId) ~= "number" then
            return Promise.reject(PurchaseError.UnknownFailure)
        end

        return arg3
    end)
end

return performVIPServerPurchase

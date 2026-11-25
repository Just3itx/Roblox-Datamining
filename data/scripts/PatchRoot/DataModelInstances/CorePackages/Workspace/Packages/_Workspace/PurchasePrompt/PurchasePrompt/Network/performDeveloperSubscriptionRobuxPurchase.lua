-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local _PurchasePromptParent = PurchasePrompt.Parent

local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local Promise = require(PurchasePrompt.Promise)

local parseSubscriptionError = require(PurchasePrompt.Utils.parseSubscriptionError)

local function performDeveloperSubscriptionRobuxPurchase(arg1, str1: string, num1: number)
    return arg1.performDeveloperSubscriptionRobuxPurchase(str1, num1):andThen(function()
        return Promise.resolve()
    end, function(arg2)
        if type(arg2) == "string" then
            return Promise.reject(parseSubscriptionError(arg2))
        end
        return Promise.reject(PurchaseError.UnknownFailure)
    end)
end

return performDeveloperSubscriptionRobuxPurchase

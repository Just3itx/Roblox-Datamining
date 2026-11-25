-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:20:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Promise = require(PurchasePrompt.Promise)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local _PaymentPlatform = require(PurchasePrompt.Enums.PaymentPlatform)
local paymentPlatformToUpsellPlatform = require(PurchasePrompt.Utils.paymentPlatformToUpsellPlatform)

local _HttpService = game:GetService("HttpService")
local GetUpsellSuggestions = require(PurchasePromptParent.PurchasePromptDeps).IAPExperience.Api.PaymentsGateway.GetUpsellSuggestions

local UpsellSuggestionsAPIMaxPackages = require(PurchasePromptParent.SharedFlags).UpsellSuggestionsAPIMaxPackages

return function(num1: number, num2: number, str1: string, bool1: boolean, num3: number?, str2: string?, num4: number?, str3: string?)
    local var1 = paymentPlatformToUpsellPlatform(str1)

    return (Promise.new(function(arg1, arg2)
        spawn(function()
            local var2, var3 = GetUpsellSuggestions(var1, num2, num1, UpsellSuggestionsAPIMaxPackages, num3, str2, num4, str3, bool1)

            if not var2 or not var3 or not var3.products or #var3.products == 0 then
                return arg2(PurchaseError.UnknownFailure)
            end

            return arg1(var3)
        end)
    end))
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)

local isErrorReasonPrefixWithEconomicRestrictions = require(PurchasePromptParent.IAPExperience).Utility.isErrorReasonPrefixWithEconomicRestrictions

local function parseSubscriptionError(arg1)
    if arg1 == "UserHasSpendLimitSet" then
        return PurchaseError.SubscriptionExceededUserSpendLimit
    elseif arg1 == "UnsupportedLocale" then
        return PurchaseError.SubscriptionUnsupportedLocale
    elseif arg1 == "RestrictedUser" then
        return PurchaseError.RestrictedUser
    elseif arg1 == "PurchasePlatformNotSupported" then
        return PurchaseError.SubscriptionPurchasePlatformNotSupported
    elseif arg1 == "InvalidSaleLocation" then
        return PurchaseError.SubscriptionInvalidSaleLocation
    elseif arg1 == "UserAlreadySubscribed" then
        return PurchaseError.AlreadySubscribed
    elseif arg1 == "ProductNotForSale" then
        return PurchaseError.SubscriptionNotForSale
    elseif arg1 == "VpcRequired" then
        return PurchaseError.VpcRequired
    elseif arg1 == "ExceedParentalSpendLimit" then
        return PurchaseError.ExceedParentalSpendLimit
    end

    if isErrorReasonPrefixWithEconomicRestrictions(arg1) then
        return arg1
    end

    return PurchaseError.UnknownFailure
end

return parseSubscriptionError

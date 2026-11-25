-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local MarketplaceService = game:GetService("MarketplaceService")

local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local clearProductInfoCaches = require(PurchasePrompt.Utils.clearProductInfoCaches)

local shouldCheckSubscriptionMembershipForProductType = require(PurchasePrompt.Utils.shouldCheckSubscriptionMembershipForProductType)

local FFlagEnablePriceChangedErrorHandling = require(PurchasePrompt.Flags.FFlagEnablePriceChangedErrorHandling)
local bool1 = game:DefineFastFlag("ClearProductInfoCachesOnPriceChanged", false)

local bool2 = game:DefineFastFlag("EnableConvertPriceChangedToUnknownFailure", false)

local engineFeature = game:GetEngineFeature("EnableSignalCheckPlayerHasRobloxSubscription")

local function handlePriceChangedError(arg1, priceChanged, str1: string?): boolean
    if not FFlagEnablePriceChangedErrorHandling then
        return false
    end
    if priceChanged ~= PurchaseError.PriceChanged then
        return false
    end

    if bool1 then
        clearProductInfoCaches()
    end

    if engineFeature and shouldCheckSubscriptionMembershipForProductType(str1) then
        MarketplaceService:signalCheckPlayerHasRobloxSubscription()
    end

    local var1 = if bool2 then PurchaseError.UnknownFailure else PurchaseError.PriceChanged
    arg1:dispatch(ErrorOccurred(var1))
    return true
end

return handlePriceChangedError

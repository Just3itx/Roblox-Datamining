-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local IAPExperience = require(PurchasePromptParent.IAPExperience)

local getAppFeaturePolicies = require(PurchasePromptParent.UniversalAppPolicy).getAppFeaturePolicies

local DiscountType = IAPExperience.DiscountType

local isRequestTypeHiddenFromBlackbirdUpsell = require(script.Parent.Parent.Utils.BlackbirdUpsellRequestTypeGating).isRequestTypeHiddenFromBlackbirdUpsell
local BlackbirdUpsellImpressionTracker = require(script.Parent.BlackbirdUpsellImpressionTracker)

local SharedFlags = require(PurchasePromptParent.SharedFlags)
local _FFlagBlackbirdUpsellGateResaleAndTimedOption = require(PurchasePrompt.Flags.FFlagBlackbirdUpsellGateResaleAndTimedOption)
local FFlagBlackbirdUpsellGateTimedOption = require(PurchasePrompt.Flags.FFlagBlackbirdUpsellGateTimedOption)
local FFlagBlackbirdUpsellGateResale = require(PurchasePrompt.Flags.FFlagBlackbirdUpsellGateResale)

local FFlagEnableBlackbirdUpsellImpressionGating = SharedFlags.FFlagEnableBlackbirdUpsellImpressionGating
local FFlagBlackbirdUpsellGateResalePurchaseType = SharedFlags.FFlagBlackbirdUpsellGateResalePurchaseType
local FFlagEnableRobuxUpsellPlusButtonExperiment = IAPExperience.Flags.FFlagEnableRobuxUpsellPlusButtonExperiment
local FIntBlackbirdUpsellMinPriceForDiscountInclusive = SharedFlags.FIntBlackbirdUpsellMinPriceForDiscountInclusive
local FIntBlackbirdUpsellMaxPriceForDiscountInclusive = SharedFlags.FIntBlackbirdUpsellMaxPriceForDiscountInclusive

local function shouldShowBlackbirdUpsell(arg1, arg2, bool1: boolean, arg3, bool2: boolean?)
    if bool1 then
        return false
    end

    if FFlagBlackbirdUpsellGateTimedOption and arg3 then
        local timedOptionDays = arg3.timedOptionDays
        if timedOptionDays and timedOptionDays ~= 0 then
            return false
        end
    end

    if FFlagBlackbirdUpsellGateResalePurchaseType and arg3 and arg3.isPurchaseFromResale == true then
        return false
    end

    if FFlagBlackbirdUpsellGateResale and arg3 then
        local collectibleItemInstanceId = arg3.collectibleItemInstanceId
        if collectibleItemInstanceId and collectibleItemInstanceId ~= "" then
            return false
        end
    end

    if getAppFeaturePolicies().getDisableBlackbirdEntrypoints() then
        return false
    end

    if arg2 and isRequestTypeHiddenFromBlackbirdUpsell(arg2) then
        return false
    end

    if arg1 then
        local basePriceInRobux = arg1.basePriceInRobux
        local var1 = FIntBlackbirdUpsellMaxPriceForDiscountInclusive

        if basePriceInRobux <= FIntBlackbirdUpsellMinPriceForDiscountInclusive or var1 ~= 0 and var1 <= basePriceInRobux then
            return false
        end
    end

    if arg1 then
        local discounts = arg1.discounts
        if discounts then
            for _, discount in discounts do
                if discount.type == DiscountType.BlackbirdSubscription or discount.type == DiscountType.RobloxPlusSubscription then
                    return false
                end
            end
        end
    end

    return not not (FFlagEnableRobuxUpsellPlusButtonExperiment and bool2
        or not (FFlagEnableBlackbirdUpsellImpressionGating and BlackbirdUpsellImpressionTracker.hasReachedMaxImpressions()))
end

return shouldShowBlackbirdUpsell

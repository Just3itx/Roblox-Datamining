-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent

local IAPExperience = require(PurchasePromptParent.IAPExperience)
local _RobloxSubscriptionPurchaseApp = require(PurchasePromptParent.RobloxSubscriptionPurchaseApp)

local ProductTypeEnum = require(PurchasePrompt.types).ProductTypeEnum
local FFlagEnableRobuxUpsellPlusButtonExperiment = IAPExperience.Flags.FFlagEnableRobuxUpsellPlusButtonExperiment
local getBlackbirdUpsellBannerProductInfo = require(script.Parent.getBlackbirdUpsellBannerProductInfo)
local shouldShowBlackbirdUpsell = require(script.Parent.shouldShowBlackbirdUpsell)

local tbl1 = {
    [ProductTypeEnum.Asset] = true,
    [ProductTypeEnum.Bundle] = true,
    [ProductTypeEnum.Gamepass] = true,
    [ProductTypeEnum.Product] = true,
    [ProductTypeEnum.Look] = true
}

local function isEligibleForRobuxUpsellPlusButton(bool1: boolean?, arg1, tbl2, arg2, arg3): boolean
    if not bool1 then
        return false
    end
    if type(arg1) ~= "table" or #arg1 == 0 then
        return false
    end

    local blackbirdUpsellBannerProductInfo = getBlackbirdUpsellBannerProductInfo(arg1)
    if blackbirdUpsellBannerProductInfo == nil or type(blackbirdUpsellBannerProductInfo.initialDiscountPercentage) ~= "number" then
        return false
    end
    if type(arg2) ~= "table" or type(arg2.basePriceInRobux) ~= "number" then
        return false
    end
    if type(tbl2) ~= "table" then
        return false
    end
    local kind = tbl2.kind
    return if type(kind) == "string" and tbl1[kind] then not not shouldShowBlackbirdUpsell(arg2, arg3, false, tbl2, if FFlagEnableRobuxUpsellPlusButtonExperiment then true else nil) else false
end

return isEligibleForRobuxUpsellPlusButton

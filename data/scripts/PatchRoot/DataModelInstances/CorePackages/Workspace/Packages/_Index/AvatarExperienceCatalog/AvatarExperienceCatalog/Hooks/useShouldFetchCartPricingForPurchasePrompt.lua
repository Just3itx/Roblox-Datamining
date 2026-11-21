-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AvatarExperienceNavigation = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation)
local useNavigation = require(AvatarExperienceCatalogParent.Navigation).useNavigation
local ItemRestrictions = AvatarExperienceCommon.Enums.ItemRestrictions
local AvatarScreen = AvatarExperienceNavigation.Enums.AvatarScreen

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)

local useHasAtLeastOneCatalogOffer = require(script.Parent.useHasAtLeastOneCatalogOffer)

local function isFree(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local priceInRobux = tbl1.priceInRobux
    return priceInRobux == nil or priceInRobux <= 0
end

local function isLimitedCollectible(tbl1): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    local itemRestrictions = tbl1.itemRestrictions
    return not (itemRestrictions == nil)
        and (itemRestrictions[ItemRestrictions.Limited] == true
            or itemRestrictions[ItemRestrictions.LimitedUnique] == true
            or itemRestrictions[ItemRestrictions.Collectible] == true)
end

local function useShouldFetchCartPricingForPurchasePrompt(tbl1)
    local var1 = useHasAtLeastOneCatalogOffer()
    local var2 = useNavigation()

    if tbl1 == nil then
        return false
    end

    if AvatarExperienceFlags.FFlagPurchasePromptCartPricingSkipFreeItems and isFree(tbl1) then
        return false
    end

    if AvatarExperienceFlags.FFlagPurchasePromptCartPricingSkipLimitedCollectibles and isLimitedCollectible(tbl1) then
        return false
    end

    return if var2
        and var2.state
        and (var2.state.routeName == AvatarScreen.TryOnItem or var2.state.params and var2.state.params.fromProfile) then true else not not (not AvatarExperienceFlags.FFlagPurchasePromptCartPricingRequireOffer or var1)
end

return useShouldFetchCartPricingForPurchasePrompt

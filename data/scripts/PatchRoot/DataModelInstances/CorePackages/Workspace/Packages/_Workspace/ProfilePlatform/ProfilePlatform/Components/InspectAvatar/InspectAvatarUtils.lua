-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:10:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local _AssetInfo = require(ProfilePlatform.Common.AssetInfo)
local _CatalogNetworking = require(ProfilePlatformParent.CatalogNetworking)
local AvatarExperienceInspectAndBuy = require(ProfilePlatformParent.AvatarExperienceInspectAndBuy)
local getPriceStatusInShop = AvatarExperienceInspectAndBuy.Utils.getPriceStatusInShop
local PriceStatus = AvatarExperienceInspectAndBuy.Enums.PriceStatus
local _Types = require(ProfilePlatform.Common.Types)
local SalesLocationType = require(ProfilePlatformParent.AvatarExperienceCommon).Enums.SalesLocationType

local tbl1 = {
    [61] = true,
    [60] = true,
    [55] = true,
    [56] = true,
    [57] = true,
    [58] = true,
    [59] = true,
    [48] = true,
    [9] = true
}

local tbl2 = {}
for _, enumItem in Enum.AvatarAssetType:GetEnumItems() do
    if not tbl1[enumItem.Value] then
        tbl2[enumItem.Value] = true
    end
end

local function getPriceStatusForProfile(arg1) -- Luacid: Inlined by compiler; 5 call sites recovered
    return getPriceStatusInShop(arg1)
end

local function isWearableAssetType(num1: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return tbl2[num1] == true
end

local function isPurchasableStatus(str1: string): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return str1 == PriceStatus.Free or str1 == PriceStatus.PurchaseFromRoblox or str1 == PriceStatus.PurchaseFromResale
end

local function normalizeSaleLocationType(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return if arg1.saleLocationType == SalesLocationType.ShopOnly then SalesLocationType.ShopAndAllExperiences else arg1.saleLocationType
end

local function resolveIsOwned(arg1, arg2, bool1: boolean?) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg2 and arg2.quantityOwned ~= nil then
        return arg2.quantityOwned > 0
    end

    if bool1 == nil then
        return arg1.owned == true
    end

    return bool1
end

local function buildItemRestrictions(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local itemRestrictions = arg1.itemRestrictions
    if not itemRestrictions or #itemRestrictions == 0 then
        return nil
    end
    local itemRestrictions2 = ({})
    for _, itemRestriction in itemRestrictions do
        itemRestrictions2[itemRestriction] = true
    end
    return itemRestrictions2
end

local function buildCollectibleItemDetails(arg1, arg2, collectibleLowestAvailableResaleProductId: string?)
    if not arg1.hasResellers
        and not arg1.unitsAvailableForConsumption
        and not arg1.totalQuantity
        and not arg1.lowestResalePrice
        and (not arg2 or not arg2.quantityOwned)
    then
        return nil
    end

    return {
        hasResellers = arg1.hasResellers,
        unitsAvailableForConsumption = arg1.unitsAvailableForConsumption,
        totalQuantity = arg1.totalQuantity,
        lowestResalePrice = arg1.lowestResalePrice,
        resellableCount = if arg2 then arg2.quantityOwned else nil,
        collectibleLowestAvailableResaleProductId = collectibleLowestAvailableResaleProductId
    }
end

local function buildAssetsInBundle(arg1, arg2)
    local var1 = nil
    if arg2 and arg2.assetsInBundle then
        local assetsInBundle = {}
        for _, value in arg2.assetsInBundle do
            table.insert(
                assetsInBundle,
                {
                    id = tostring(value.id),
                    assetType = tostring(value.assetType),
                    isIncluded = value.isIncluded
                }
            )
        end

        return assetsInBundle
    end

    local tbl3

    if arg1.bundledItems then
        tbl3 = {}
        for _, bundledItem in arg1.bundledItems do
            if bundledItem.type == "Asset" and bundledItem.assetType then
                table.insert(tbl3, { id = tostring(bundledItem.id), assetType = tostring(bundledItem.assetType) })
            end
        end

        if not (#tbl3 > 0) then
            tbl3 = var1
        end
    else
        tbl3 = var1
    end

    return tbl3
end

local function computeBundleParts(arg1, arg2, tbl3)
    local num1 = 0
    local tbl4 = {}
    if arg2 and arg2.assetsInBundle then
        for _, value in arg2.assetsInBundle do
            if not tbl3[tostring(value.id)] then
                continue
            end

            num1 += 1

            if isWearableAssetType(value.assetType) then
                table.insert(tbl4, value.id)
            end
        end

        return num1, tbl4
    end

    if arg1.bundledItems then
        for _, bundledItem in arg1.bundledItems do
            if bundledItem.type ~= "Asset" then
                continue
            end

            num1 += 1

            if bundledItem.assetType and isWearableAssetType(bundledItem.assetType) then
                table.insert(tbl4, bundledItem.id)
            end
        end
    end

    return num1, tbl4
end

local function extractTaxonomyName(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.taxonomy and #arg1.taxonomy > 0 then
        return arg1.taxonomy[1].taxonomyName
    end

    return nil
end

return {
    isWearableAssetType = isWearableAssetType,
    expandBundleToAssetIds = function(arg1)
        local result = {}
        if arg1.bundledItems then
            for _, bundledItem in arg1.bundledItems do
                if bundledItem.type == "Asset" then
                    table.insert(result, bundledItem.id)
                end
            end
        end
        return result
    end,
    collectBundleComponentIds = function(tbl3, tbl4)
        local result = {}
        for _, value in tbl3 do
            local var1 = tbl4[value]
            if not (var1 and var1.assetsInBundle) then
                continue
            end

            for _, value2 in var1.assetsInBundle do
                local id = value2.id
                result[tostring(id)] = true
            end
        end

        return result
    end,
    buildItemData = function(arg1, arg2, tbl3, collectibleProductId: string?, bool1: boolean?, collectibleLowestAvailableResaleProductId: string?)
        local var1 = arg1.assetType or arg1.bundleType
        local bundlePartsCount, bundleAssetIds = computeBundleParts(arg1, arg2, tbl3)
        local itemType = arg1.itemType or "Asset"

        local tbl5 = {
            id = tostring(arg1.id),
            name = arg1.name,
            itemType = itemType,
            itemSubType = if var1 then tostring(var1) else nil,
            priceInRobux = arg1.price,
            creator = {
                creatorId = tostring(arg1.creatorTargetId or ""),
                creatorName = arg1.creatorName,
                creatorHasVerifiedBadge = arg1.creatorHasVerifiedBadge
            },
            saleLocationType = normalizeSaleLocationType(arg1),
            isOffSale = arg1.isOffSale,
            isOwned = resolveIsOwned(arg1, arg2, bool1),
            noPriceStatus = if arg2 then arg2.noPriceStatus else nil,
            catalogPriceStatus = arg1.priceStatus,
            collectibleItemId = arg1.collectibleItemId,
            itemRestrictions = buildItemRestrictions(arg1),
            collectibleItemDetails = buildCollectibleItemDetails(arg1, arg2, collectibleLowestAvailableResaleProductId),
            assetsInBundle = buildAssetsInBundle(arg1, arg2),
            collectibleProductId = 0,
            bundlePartsCount = 0,
            bundleAssetIds = 0,
            taxonomyName = 0
        }

        if arg2 then
            collectibleProductId = arg2.collectibleProductId
        end

        tbl5.collectibleProductId = collectibleProductId
        tbl5.bundlePartsCount = bundlePartsCount
        tbl5.bundleAssetIds = bundleAssetIds
        tbl5.taxonomyName = extractTaxonomyName(arg1)
        return tbl5
    end,
    isPurchasableStatus = isPurchasableStatus,
    isItemPurchasable = function(arg1): boolean
        return not arg1.isOwned and isPurchasableStatus((getPriceStatusForProfile(arg1))) and arg1.collectibleProductId ~= nil
    end,
    getEffectivePrice = function(arg1)
        if getPriceStatusForProfile(arg1) == PriceStatus.PurchaseFromResale then
            if arg1.collectibleItemDetails then
                return arg1.collectibleItemDetails.lowestResalePrice or 0
            end

            return 0
        end

        return arg1.priceInRobux or 0
    end,
    sortDisplayItems = function(tbl3)
        table.sort(tbl3, function(arg1, arg2): boolean
            local function sortKey(arg3): number -- Luacid: Inlined by compiler; 2 call sites recovered
                local priceStatusForProfile = getPriceStatusForProfile(arg3)

                if isPurchasableStatus(priceStatusForProfile) then
                    return 0
                end

                if priceStatusForProfile == PriceStatus.Owned or priceStatusForProfile == PriceStatus.QuantityLimitReached then
                    return 1
                end

                return 2
            end

            return sortKey(arg1) < sortKey(arg2)
        end)

        return tbl3
    end,
    getPriceStatus = getPriceStatusForProfile,
    PriceStatusEnum = PriceStatus
}

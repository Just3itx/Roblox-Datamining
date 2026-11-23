-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local _AXCommon = require(AvatarExperienceInspectAndBuyParent.AXCommon)
local _AvatarExperienceRodux = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceRodux)
local AvatarExperienceModel = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceModel)
local tutils = require(AvatarExperienceInspectAndBuyParent.tutils)
local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum

local function buildCollectibleItemDetails(arg1, arg2)
    local collectibles = arg1.Collectibles
    local collectibleItemId = arg2.collectibleItemId
    local var1 = if collectibles and collectibleItemId and collectibles.CollectiblesItemInfo then collectibles.CollectiblesItemInfo[collectibleItemId] else nil
    local var2 = if collectibles and collectibleItemId and collectibles.CollectiblesResellableInstances then collectibles.CollectiblesResellableInstances[collectibleItemId] else nil
    local resellableCount = if var2 then tutils.fieldCount(var2) else 0
    local lowestAvailableResaleProductId = if var1 then var1.lowestAvailableResaleProductId else nil
    local tbl1 = {
        quantityLimitPerUser = if var1 then var1.quantityLimitPerUser else nil,
        resellableCount = resellableCount,
        collectibleProductId = if var1 then var1.collectibleProductId else nil,
        collectibleLowestAvailableResaleProductId = lowestAvailableResaleProductId,
        collectibleLowestAvailableResaleItemInstanceId = if var1 then var1.lowestAvailableResaleItemInstanceId else nil,
        unitsAvailableForConsumption = (if var1 then var1.unitsAvailableForConsumption else nil) or arg2.numberRobloxHasAvailable,
        hasResellers = arg2.hasResellers
            or (if var1 then var1.hasResellers else nil)
            or lowestAvailableResaleProductId ~= nil and lowestAvailableResaleProductId ~= "",
        lowestResalePrice = arg2.lowestResalePrice,
        totalQuantity = arg2.totalQuantity,
        experiences = 0
    }
    local experiences = arg2.experiences

    if not experiences then
        if var1 then
            experiences = var1.experiences
        else
            experiences = nil
        end
    end

    tbl1.experiences = experiences
    return tbl1
end

local function buildAssetsInBundle(items)
    if not items then
        return nil
    end

    local assetsInBundle = {}
    for _, item in items do
        local tbl1 = {
            id = tostring(item.id),
            assetType = if item.assetType == nil then nil else tostring(item.assetType)
        }
        table.insert(assetsInBundle, tbl1)
    end

    return assetsInBundle
end

local function buildItemDataFromAXRodux(arg1, id: string, itemType): {assetsInBundle: number, catalogPriceStatus: number, collectibleItemDetails: number, collectibleItemId: number, creatingUniverseId: number, creator: number, description: any, discountInformation: number, expirationTime: number, favoritesDetails: number, id: string, isOffSale: number, isOwned: number, itemRestrictions: number, itemSubType: number, itemType: any, name: any, priceInRobux: number, saleLocationType: number, timedOptions: number}?
    if not arg1 then
        return nil
    end

    local var1 = nil
    if itemType == ItemTypeEnum.Asset then
        if arg1.AssetInfos then
            var1 = arg1.AssetInfos[id]
        else
            var1 = nil
        end
    elseif itemType == ItemTypeEnum.Bundle then
        if arg1.BundleInfos then
            var1 = arg1.BundleInfos[id]
        else
            var1 = nil
        end
    end
    if not var1 then
        return nil
    end

    local creator = var1.creator

    return {
        id = id,
        name = var1.name,
        description = var1.description,
        itemType = itemType,
        itemSubType = if itemType == ItemTypeEnum.Bundle then var1.bundleType else var1.assetType,
        creator = {
            creatorId = (if creator then creator.id else nil) or "",
            creatorName = (if creator then creator.name else nil) or var1.creatorName or "",
            creatorHasVerifiedBadge = (if creator then creator.hasVerifiedBadge else nil) or false
        },
        creatingUniverseId = var1.creatingUniverseId,
        saleLocationType = var1.saleLocationType,
        itemRestrictions = var1.itemRestrictions or {},
        priceInRobux = var1.priceInRobux,
        discountInformation = var1.discountInformation,
        catalogPriceStatus = var1.priceStatus,
        isOwned = var1.isOwned,
        isOffSale = var1.isOffSale,
        collectibleItemId = var1.collectibleItemId,
        collectibleItemDetails = buildCollectibleItemDetails(arg1, var1),
        assetsInBundle = if itemType == ItemTypeEnum.Bundle then buildAssetsInBundle(var1.items) else nil,
        favoritesDetails = {
            numFavorites = var1.favoriteCount
        },
        timedOptions = var1.timedOptions,
        expirationTime = var1.expirationTime
    }
end

return buildItemDataFromAXRodux

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local AXCommon = require(AvatarExperienceInspectAndBuy.Parent.AXCommon)
local ItemTypeEnum = require(AvatarExperienceInspectAndBuy.Parent.AvatarExperienceModel).Enums.ItemTypeEnum
local SalesLocationType = AXCommon.Enums.SalesLocationType
local tutils = require(AvatarExperienceInspectAndBuyParent.tutils)

local FFlagAXMarketplaceLicensingItemCards = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceFlags).FFlagAXMarketplaceLicensingItemCards

return function(arg1, tbl1)
    local var1 = if tbl1 then tutils.fieldCount(tbl1) else 0

    local assetsInBundle = {}

    if arg1.assetsInBundle then
        for _, value in arg1.assetsInBundle do
            table.insert(assetsInBundle, {
                id = tostring(value.id),
                assetType = tostring(value.assetType),
                isIncluded = value.isIncluded,
                meta = value.meta,
                name = value.name
            })
        end
    end

    return {
        id = arg1.bundleId,
        name = arg1.name,
        description = arg1.description,
        itemType = ItemTypeEnum.Bundle,
        itemSubType = arg1.bundleType,
        creator = {
            creatorId = arg1.creatorId or "",
            creatorName = arg1.creatorName or "",
            creatorHasVerifiedBadge = arg1.creatorHasVerifiedBadge or false
        },
        itemLicensingInfo = if FFlagAXMarketplaceLicensingItemCards then arg1.itemLicensingInfo else nil,
        saleLocationType = arg1.saleLocationType or SalesLocationType.Invalid,
        itemRestrictions = arg1.itemRestrictions or {},
        priceInRobux = arg1.price,
        noPriceStatus = arg1.noPriceStatus,
        catalogPriceStatus = arg1.catalogPriceStatus,
        isOwned = arg1.owned,
        hasResellers = arg1.hasResellers,
        isOffSale = arg1.isOffSale,
        collectibleItemId = arg1.collectibleItemId,
        collectibleItemDetails = {
            quantityLimitPerUser = arg1.collectibleQuantityLimitPerUser,
            collectibleLowestAvailableResaleProductId = arg1.collectibleLowestAvailableResaleProductId,
            collectibleLowestAvailableResaleItemInstanceId = arg1.collectibleLowestAvailableResaleItemInstanceId,
            unitsAvailableForConsumption = arg1.remaining,
            hasResellers = arg1.hasResellers,
            lowestResalePrice = arg1.collectibleLowestResalePrice,
            resellableCount = arg1.resellableCount or var1,
            totalQuantity = arg1.collectibleTotalQuantity or 0
        },
        assetsInBundle = assetsInBundle,
        favoritesDetails = {
            isFavorited = arg1.isFavorited,
            numFavorites = arg1.numFavorites
        }
    }
end

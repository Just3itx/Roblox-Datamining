-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local _Types = require(AvatarExperienceInspectAndBuy.Types)
local AvatarExperienceModel = require(AvatarExperienceInspectAndBuy.Parent.AvatarExperienceModel)
local tutils = require(AvatarExperienceInspectAndBuyParent.tutils)
local ItemTypeEnum = AvatarExperienceModel.Enums.ItemTypeEnum

local FFlagAXMarketplaceLicensingItemCards = require(AvatarExperienceInspectAndBuyParent.AvatarExperienceFlags).FFlagAXMarketplaceLicensingItemCards

return function(arg1, tbl1)
    local var1 = if tbl1 then tutils.fieldCount(tbl1) else 0

    return {
        id = arg1.assetId,
        name = arg1.name,
        meta = arg1.meta,
        description = arg1.description,
        itemType = ItemTypeEnum.Asset,
        itemSubType = arg1.assetTypeId,
        creator = {
            creatorId = arg1.creatorId or "",
            creatorName = arg1.creatorName or "",
            creatorHasVerifiedBadge = arg1.creatorHasVerifiedBadge or false
        },
        itemLicensingInfo = if FFlagAXMarketplaceLicensingItemCards then arg1.itemLicensingInfo else nil,
        saleLocationType = arg1.saleLocationType,
        itemRestrictions = arg1.itemRestrictions or {},
        priceInRobux = arg1.price,
        noPriceStatus = arg1.noPriceStatus,
        catalogPriceStatus = arg1.catalogPriceStatus,
        isOwned = arg1.owned,
        isOffSale = arg1.isOffSale,
        collectibleItemId = arg1.collectibleItemId,
        creatingUniverseId = arg1.creatingUniverseId,
        collectibleItemDetails = {
            quantityLimitPerUser = arg1.collectibleQuantityLimitPerUser,
            resellableCount = arg1.resellableCount or var1,
            collectibleLowestAvailableResaleProductId = arg1.collectibleLowestAvailableResaleProductId,
            collectibleLowestAvailableResaleItemInstanceId = arg1.collectibleLowestAvailableResaleItemInstanceId,
            unitsAvailableForConsumption = arg1.remaining,
            hasResellers = arg1.hasResellers
                or arg1.collectibleLowestAvailableResaleProductId ~= nil and arg1.collectibleLowestAvailableResaleProductId ~= "",
            lowestResalePrice = arg1.collectibleLowestResalePrice or 0,
            totalQuantity = arg1.collectibleTotalQuantity or 0,
            experiences = not (arg1 and arg1.saleLocation) and {} or arg1.saleLocation.UniverseIds or {}
        },
        favoritesDetails = {
            numFavorites = arg1.numFavorites,
            isFavorited = arg1.isFavorited
        },
        timedOptions = arg1.timedOptions
    }
end

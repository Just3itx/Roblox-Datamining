-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Cryo = require(CorePackages.Packages.Cryo)
local Dash = require(CorePackages.Packages.Dash)

local FFlagAXMarketplaceLicensing = require(CorePackages.Workspace.Packages.AvatarExperienceFlags).FFlagAXMarketplaceLicensing

local scriptParentParent = script.Parent.Parent

local Constants = require(scriptParentParent.Constants)
local _AvatarExperienceInspectAndBuy = require(CorePackages.Workspace.Packages.AvatarExperienceInspectAndBuy)
local AvatarExperienceCommon = require(CorePackages.Workspace.Packages.AvatarExperienceCommon)
local ItemRestrictions = AvatarExperienceCommon.Enums.ItemRestrictions
local getRawItemLicensingInfo = AvatarExperienceCommon.Utils.getRawItemLicensingInfo
local parseItemLicensing = AvatarExperienceCommon.Utils.parseItemLicensing

local MockId = require(script.Parent.Parent.MockId)
local module = {}

function module.new()
    return {}
end

function module.mock()
    local module2 = module.new()

    module2.name = ""
    module2.bundleId = MockId()
    module2.description = ""
    module2.bundleType = ""
    module2.creatorId = ""
    module2.creatorName = ""
    module2.productId = ""
    module2.isForSale = false
    module2.price = ""
    module2.assetIds = {}
    module2.numFavorites = 0
    module2.costumeId = ""
    module2.owned = false
    module2.isForSale = false
    module2.collectibleItemId = ""
    module2.collectibleIsLimited = nil
    module2.collectibleProductId = ""
    module2.collectibleLowestResalePrice = 0
    module2.collectibleLowestAvailableResaleProductId = ""
    module2.collectibleLowestAvailableResaleItemInstanceId = ""
    module2.collectibleQuantityLimitPerUser = 0
    module2.remaining = 0
    module2.productType = ""

    return module2
end

function module.fromBulkPurchaseResult(arg1, arg2)
    local module2 = module.new()
    local var1 = not (arg2 and arg2.itemRestrictions) and {} or arg2.itemRestrictions
    module2.resellableCount = if arg2 and arg2.resellableCount then arg2.resellableCount else 0

    if arg1.status == Enum.MarketplaceItemPurchaseStatus.Success and arg1.type == Enum.MarketplaceProductType.AvatarBundle then
        module2.owned = true

        if var1[ItemRestrictions.Collectible] or var1[ItemRestrictions.Limited] or var1[ItemRestrictions.LimitedUnique] then
            module2.resellableCount += 1
        end
    end
    return module2
end

function module.fromGetFavoriteForAsset(str1: string, isFavorited: boolean)
    local module2 = module.new()
    module2.bundleId = tostring(str1)
    module2.isFavorited = isFavorited
    return module2
end

function module.fromAvatarPreviewItem(arg1)
    local module2 = module.new()

    module2.name = arg1.name
    module2.description = arg1.description
    module2.price = arg1.priceInRobux
    module2.isForSale = arg1.isPurchasable
    module2.productId = tostring(arg1.productId)
    module2.collectibleItemId = arg1.collectibleItemId
    module2.collectibleProductId = arg1.collectibleProductId
    module2.owned = arg1.quantityOwned > 0
    module2.resellableCount = arg1.quantityOwned
    module2.creatorId = tostring(arg1.creator.id)
    module2.creatorName = arg1.creator.name
    module2.creatorHasVerifiedBadge = arg1.creator.hasVerifiedBadge
    module2.bundleId = tostring(arg1.id)
    module2.bundleType = tostring(arg1.bundleType)
    module2.noPriceStatus = arg1.noPriceStatus
    if FFlagAXMarketplaceLicensing then
        module2.itemLicensingInfo = parseItemLicensing(getRawItemLicensingInfo(arg1))
    end

    local assetsInBundle = {}
    if arg1.assetsInBundle then
        for _, value in arg1.assetsInBundle do
            table.insert(
                assetsInBundle,
                {
                    id = tostring(value.id),
                    assetType = tostring(value.assetType),
                    isIncluded = value.isIncluded,
                    meta = value.meta
                }
            )
        end
    end

    module2.assetsInBundle = assetsInBundle

    if arg1.itemRestrictions then
        local itemRestrictions = ({})
        for _, itemRestriction in arg1.itemRestrictions do
            itemRestrictions[itemRestriction] = true
        end
        module2.itemRestrictions = itemRestrictions
    end

    return module2
end

function module.fromGetAssetBundles(arg1)
    local module2 = module.new()

    module2.name = arg1.name
    module2.bundleId = tostring(arg1.id)
    module2.description = arg1.description
    module2.bundleType = arg1.bundleType
    module2.creatorId = tostring(arg1.creator.id)
    module2.creatorName = arg1.creator.name
    module2.productId = tostring(arg1.product.id)

    if arg1.collectibleItemDetail then
        module2.isForSale = arg1.collectibleItemDetail.saleStatus == Constants.SaleStatus.OnSale
        module2.collectibleItemId = arg1.collectibleItemDetail.collectibleItemId or ""
        module2.collectibleProductId = arg1.collectibleItemDetail.collectibleProductId or ""
        module2.collectibleLowestResalePrice = arg1.collectibleItemDetail.lowestResalePrice or 0
        module2.collectibleLowestAvailableResaleProductId = arg1.collectibleItemDetail.lowestAvailableResaleProductId or ""

        module2.collectibleLowestAvailableResaleItemInstanceId = arg1.collectibleItemDetail.lowestAvailableResaleItemInstanceId or ""

        module2.collectibleQuantityLimitPerUser = arg1.collectibleItemDetail.quantityLimitPerUser or 0

        module2.productType = Constants.ProductType.CollectibleItem

        module2.price = arg1.collectibleItemDetail.price

        module2.remaining = arg1.collectibleItemDetail.unitsAvailable or 0

        module2.collectibleIsLimited = arg1.collectibleItemDetail.collectibleItemType == "Limited"

        module2.saleLocation = arg1.collectibleItemDetail.saleLocation
    end

    module2.assetIds = {}

    for _, item in pairs(arg1.items) do
        if item.type == "UserOutfit" then
            module2.costumeId = tostring(item.id)
        else
            table.insert(module2.assetIds, tostring(item.id))
        end
    end

    return module2
end

function module.fromGetItemDetailsV2(arg1)
    local module2 = module.new()

    module2.bundleId = tostring(arg1.id)
    module2.isForSale = arg1.isPurchasable
    module2.price = arg1.price or 0
    module2.hasResellers = arg1.hasResellers
    module2.collectibleItemId = arg1.collectibleItemId

    module2.remaining = arg1.unitsAvailableForConsumption
    module2.collectibleTotalQuantity = arg1.totalQuantity
    module2.collectibleLowestResalePrice = arg1.lowestResalePrice
    module2.isOffSale = arg1.isOffSale
    module2.saleLocationType = arg1.saleLocationType
    module2.numFavorites = arg1.favoriteCount
    module2.catalogPriceStatus = arg1.priceStatus
    local rawItemLicensingInfo = getRawItemLicensingInfo(arg1)
    if FFlagAXMarketplaceLicensing and rawItemLicensingInfo ~= nil then
        module2.itemLicensingInfo = parseItemLicensing(rawItemLicensingInfo) or Cryo.None
    end

    local assetsInBundle = {}
    if arg1.bundledItems then
        for _, bundledItem in arg1.bundledItems do
            table.insert(assetsInBundle, { id = tostring(bundledItem.id), name = bundledItem.name })
        end
    end

    module2.assetsInBundle = assetsInBundle

    return module2
end

function module.fromGetItemDetails(arg1)
    local module2 = module.new()

    module2.bundleId = tostring(arg1.Id)
    module2.owned = arg1.Owned
    module2.isForSale = arg1.IsPurchasable
    module2.price = arg1.Price or 0
    module2.hasResellers = arg1.HasResellers
    module2.collectibleItemId = arg1.CollectibleItemId

    module2.remaining = arg1.UnitsAvailableForConsumption
    module2.collectibleTotalQuantity = arg1.TotalQuantity
    module2.collectibleLowestResalePrice = arg1.LowestResalePrice
    module2.isOffSale = arg1.IsOffSale
    module2.saleLocationType = arg1.SaleLocationType
    module2.numFavorites = arg1.FavoriteCount
    module2.catalogPriceStatus = arg1.PriceStatus

    local assetsInBundle = {}
    if arg1.BundledItems then
        for _, bundledItem in arg1.BundledItems do
            table.insert(assetsInBundle, { id = tostring(bundledItem.Id), name = bundledItem.Name })
        end
    end

    module2.assetsInBundle = assetsInBundle

    return module2
end

function module.fromGetBundleFavoriteCount(arg1, numFavorites)
    local module2 = module.new()
    module2.bundleId = tostring(arg1)
    module2.numFavorites = numFavorites
    return module2
end

function module.fromGetEconomyProductInfo(owned, arg1, price, isForSale)
    local module2 = module.new()
    module2.bundleId = tostring(arg1)
    module2.owned = owned
    module2.price = price
    module2.isForSale = isForSale
    return module2
end

function module.fromPurchaseSuccess(arg1)
    local module2 = module.new()
    module2.bundleId = tostring(arg1)
    module2.owned = true
    return module2
end

function module.getSaleDetailsForCollectibles(arg1)
    local var1 = Dash.joinDeep({}, arg1)
    if arg1.productType == Constants.ProductType.CollectibleItem then
        local saleLocation = var1.saleLocation
        local var2 = saleLocation and saleLocation.saleLocationTypeId ~= Constants.SaleLocationType.ShopOnly

        local var3 = saleLocation and saleLocation.saleLocationTypeId ~= Constants.SaleLocationType.ShopAndExperiencesById
        local bool1 = saleLocation
            and saleLocation.saleLocationTypeId == Constants.SaleLocationType.ShopAndExperiencesById
            and type(saleLocation.universeIds) == "table"
            and table.find(saleLocation.universeIds, game.GameId) ~= nil
        local var4 = saleLocation and saleLocation.saleLocationTypeId ~= Constants.SaleLocationType.ExperiencesDevApiOnly

        local isForSale = var1.isForSale

        if isForSale then
            if var2 then
                if not (var3 or bool1) then
                    var4 = bool1
                end
            else
                var4 = var2
            end
        else
            var4 = isForSale
        end

        var1.isForSale = var4

        if not arg1.collectibleIsLimited then
            var1.isForSale = var1.isForSale and not var1.owned
        end
    end
    return var1
end

return module

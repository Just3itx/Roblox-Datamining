-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:11:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Cryo = require(CorePackages.Packages.Cryo)
local Dash = require(CorePackages.Packages.Dash)

local FFlagAXMarketplaceLicensing = require(CorePackages.Workspace.Packages.AvatarExperienceFlags).FFlagAXMarketplaceLicensing

local scriptParentParent = script.Parent.Parent

local MockId = require(scriptParentParent.MockId)
local Constants = require(scriptParentParent.Constants)
local _AvatarExperienceInspectAndBuy = require(CorePackages.Workspace.Packages.AvatarExperienceInspectAndBuy)
local AvatarExperienceCommon = require(CorePackages.Workspace.Packages.AvatarExperienceCommon)
local ItemRestrictions = AvatarExperienceCommon.Enums.ItemRestrictions
local getRawItemLicensingInfo = AvatarExperienceCommon.Utils.getRawItemLicensingInfo
local parseItemLicensing = AvatarExperienceCommon.Utils.parseItemLicensing

local GetFFlagIBEnableCollectiblesSystemSupport = require(scriptParentParent.Flags.GetFFlagIBEnableCollectiblesSystemSupport)

local module = {}

local function func1(arg1): number -- Luacid: Inlined by compiler; 9 call sites recovered
    return math.round(arg1 * 100) / 100
end

function module.new()
    return {}
end

function module.mock()
    local module2 = module.new()

    module2.name = ""
    module2.assetId = MockId()
    module2.assetTypeId = ""
    module2.creatorId = ""
    module2.creatorName = ""
    module2.creatorHasVerifiedBadge = false
    module2.owned = false
    module2.isForSale = false
    module2.description = ""
    module2.price = ""
    module2.productId = ""
    module2.isLimited = false
    module2.isLimitedUnique = not GetFFlagIBEnableCollectiblesSystemSupport() and nil
    module2.collectibleIsLimited = not GetFFlagIBEnableCollectiblesSystemSupport() and nil

    module2.bundlesAssetIsIn = {}

    module2.parentBundleId = nil
    module2.numFavorites = 0
    module2.minimumMembershipLevel = 0

    module2.collectibleItemId = ""
    module2.collectibleProductId = ""
    module2.collectibleLowestResalePrice = 0
    module2.collectibleLowestAvailableResaleProductId = ""
    module2.collectibleLowestAvailableResaleItemInstanceId = ""
    module2.collectibleQuantityLimitPerUser = 0
    module2.remaining = 0
    module2.creatingUniverseId = nil

    return module2
end

function module.fromBulkPurchaseResult(arg1, arg2)
    local module2 = module.new()
    local var1 = not (arg2 and arg2.itemRestrictions) and {} or arg2.itemRestrictions
    module2.resellableCount = if arg2 and arg2.resellableCount then arg2.resellableCount else 0

    if arg1.status == Enum.MarketplaceItemPurchaseStatus.Success and arg1.type == Enum.MarketplaceProductType.AvatarAsset then
        module2.owned = true

        if var1[ItemRestrictions.Collectible] or var1[ItemRestrictions.Limited] or var1[ItemRestrictions.LimitedUnique] then
            module2.resellableCount += 1
        end
    end
    return module2
end

function module.fromAvatarPreviewItem(arg1)
    local module2 = module.new()

    module2.name = arg1.name
    module2.description = arg1.description
    module2.price = arg1.priceInRobux
    module2.productId = tostring(arg1.productId)
    module2.collectibleItemId = arg1.collectibleItemId
    module2.owned = arg1.quantityOwned > 0
    module2.resellableCount = arg1.quantityOwned
    module2.creatorId = tostring(arg1.creator.id)
    module2.creatorName = arg1.creator.name
    module2.creatorHasVerifiedBadge = arg1.creator.hasVerifiedBadge
    module2.assetId = tostring(arg1.id)
    module2.assetTypeId = tostring(arg1.assetType)
    module2.productId = tostring(arg1.productId)
    module2.isForSale = arg1.isPurchasable
    module2.noPriceStatus = arg1.noPriceStatus
    module2.meta = arg1.meta
    if FFlagAXMarketplaceLicensing then
        module2.itemLicensingInfo = parseItemLicensing(getRawItemLicensingInfo(arg1))
    end

    if arg1.itemRestrictions then
        local itemRestrictions = ({})
        for _, itemRestriction in arg1.itemRestrictions do
            itemRestrictions[itemRestriction] = true
        end
        module2.itemRestrictions = itemRestrictions
    end
    return module2
end

function module.fromGetProductInfo(arg1)
    local module2 = module.new()

    module2.name = arg1.Name
    module2.description = arg1.Description
    module2.price = arg1.PriceInRobux
    module2.productType = arg1.ProductType
    module2.remaining = arg1.Remaining
    module2.creatorId = tostring(arg1.Creator.Id)
    module2.creatorName = arg1.Creator.Name
    module2.assetId = tostring(arg1.AssetId)
    module2.assetTypeId = tostring(arg1.AssetTypeId)
    module2.productId = tostring(arg1.ProductId)

    module2.isForSale = arg1.IsForSale
    module2.canBeSoldInThisGame = arg1.CanBeSoldInThisGame
    module2.saleLocation = arg1.SaleLocation
    module2.remaining = arg1.Remaining or 0
    if module2.productType == Constants.ProductType.CollectibleItem then
        module2.collectibleItemId = arg1.CollectibleItemId or ""
        module2.collectibleProductId = arg1.CollectibleProductId or ""
        if arg1.CollectiblesItemDetails then
            module2.collectibleLowestResalePrice = arg1.CollectiblesItemDetails.CollectibleLowestResalePrice or 0
            module2.collectibleLowestAvailableResaleProductId = arg1.CollectiblesItemDetails.CollectibleLowestAvailableResaleProductId or ""

            module2.collectibleLowestAvailableResaleItemInstanceId = arg1.CollectiblesItemDetails.CollectibleLowestAvailableResaleItemInstanceId or ""

            module2.collectibleQuantityLimitPerUser = arg1.CollectiblesItemDetails.CollectibleQuantityLimitPerUser or 0

            module2.collectibleIsLimited = arg1.CollectiblesItemDetails.IsLimited
        end
    end

    module2.creatorHasVerifiedBadge = arg1.Creator.HasVerifiedBadge
    if not GetFFlagIBEnableCollectiblesSystemSupport() then
        module2.isLimited = arg1.IsLimited or arg1.IsLimitedUnique
    else
        module2.isLimited = arg1.IsLimited
        module2.isLimitedUnique = arg1.IsLimitedUnique
    end

    return module2
end

function module.fromHumanoidDescription(arg1)
    local module2 = module.new()

    module2.assetId = tostring(arg1)

    return module2
end

function module.fromHumanoidDescriptionAccessory(arg1)
    local module2 = module.new()
    module2.assetId = tostring(arg1.AssetId)

    module2.meta = {}
    module2.meta.position = {
        x = func1(arg1.Position.X),
        y = func1(arg1.Position.Y),
        z = func1(arg1.Position.Z)
    }
    module2.meta.rotation = {
        x = func1(arg1.Rotation.X),
        y = func1(arg1.Rotation.Y),
        z = func1(arg1.Rotation.Z)
    }
    module2.meta.scale = {
        x = func1(arg1.Scale.X),
        y = func1(arg1.Scale.Y),
        z = func1(arg1.Scale.Z)
    }

    if arg1.IsLayered then
        module2.meta.order = arg1.Order
    end

    return module2
end

function module.fromGetAssetBundles(arg1, bundlesAssetIsIn)
    local module2 = module.new()
    module2.assetId = tostring(arg1)
    module2.bundlesAssetIsIn = bundlesAssetIsIn
    return module2
end

function module.fromGetFavoriteForAsset(str1: string, isFavorited: boolean)
    local module2 = module.new()
    module2.assetId = tostring(str1)
    module2.isFavorited = isFavorited
    return module2
end

function module.fromBundleInfo(arg1, arg2)
    local module2 = module.new()
    module2.assetId = tostring(arg1)
    module2.parentBundleId = arg2.bundleId
    module2.bundlesAssetIsIn = { arg2.bundleId }
    module2.collectibleItemId = arg2.collectibleItemId
    module2.collectibleProductId = arg2.collectibleProductId
    module2.collectibleLowestResalePrice = arg2.collectibleLowestResalePrice
    module2.collectibleLowestAvailableResaleProductId = arg2.collectibleLowestAvailableResaleProductId
    module2.collectibleLowestAvailableResaleItemInstanceId = arg2.collectibleLowestAvailableResaleItemInstanceId
    module2.collectibleQuantityLimitPerUser = arg2.collectibleQuantityLimitPerUser
    module2.collectibleIsLimited = arg2.collectibleIsLimited

    module2.isForSale = arg2.isForSale
    module2.remaining = arg2.remaining

    module2.owned = arg2.owned
    if not module2.collectibleIsLimited then
        module2.isForSale = module2.isForSale and not module2.owned
    end

    module2.description = arg2.description or ""
    module2.productType = Constants.ProductType.CollectibleItem

    if arg2.price then
        module2.price = arg2.price
    end

    return module2
end

function module.fromGetAssetFavoriteCount(arg1, numFavorites)
    local module2 = module.new()

    module2.assetId = tostring(arg1)
    module2.numFavorites = numFavorites

    return module2
end

function module.fromGetEconomyProductInfo(arg1, owned, price, isForSale, premiumPricing)
    local module2 = module.new()

    module2.assetId = tostring(arg1.assetId)
    module2.owned = owned
    if price then
        module2.price = price
    end
    module2.isForSale = isForSale
    module2.premiumPricing = premiumPricing

    return module2
end

function module.fromGetItemDetailsV2(arg1)
    local module2 = module.new()

    module2.assetId = tostring(arg1.id)
    module2.isForSale = arg1.isPurchasable
    module2.price = arg1.price or 0
    module2.hasResellers = arg1.hasResellers
    module2.collectibleItemId = arg1.collectibleItemId

    local itemRestrictions = ({})
    if arg1.itemRestrictions then
        for _, itemRestriction in arg1.itemRestrictions do
            itemRestrictions[itemRestriction] = true
        end
        module2.itemRestrictions = itemRestrictions
    end

    module2.saleLocationType = arg1.saleLocationType
    module2.remaining = arg1.unitsAvailableForConsumption
    module2.collectibleTotalQuantity = arg1.totalQuantity
    module2.collectibleLowestResalePrice = arg1.lowestResalePrice
    module2.isOffSale = arg1.isOffSale
    module2.saleLocationType = arg1.saleLocationType
    module2.numFavorites = arg1.favoriteCount
    module2.catalogPriceStatus = arg1.priceStatus

    module2.timedOptions = arg1.timedOptions
    local rawItemLicensingInfo = getRawItemLicensingInfo(arg1)
    if FFlagAXMarketplaceLicensing and rawItemLicensingInfo ~= nil then
        module2.itemLicensingInfo = parseItemLicensing(rawItemLicensingInfo) or Cryo.None
    end

    return module2
end

function module.fromGetItemDetails(arg1)
    local module2 = module.new()

    module2.assetId = tostring(arg1.Id)
    module2.owned = arg1.Owned
    module2.isForSale = arg1.IsPurchasable
    module2.price = arg1.Price or 0
    module2.hasResellers = arg1.HasResellers
    module2.collectibleItemId = arg1.CollectibleItemId

    local itemRestrictions = ({})
    if arg1.ItemRestrictions then
        for _, itemRestriction in arg1.ItemRestrictions do
            itemRestrictions[itemRestriction] = true
        end
        module2.itemRestrictions = itemRestrictions
    end

    module2.saleLocationType = arg1.SaleLocationType
    module2.remaining = arg1.UnitsAvailableForConsumption
    module2.collectibleTotalQuantity = arg1.TotalQuantity
    module2.collectibleLowestResalePrice = arg1.LowestResalePrice
    module2.isOffSale = arg1.IsOffSale
    module2.saleLocationType = arg1.SaleLocationType
    module2.numFavorites = arg1.FavoriteCount
    module2.catalogPriceStatus = arg1.PriceStatus

    module2.creatingUniverseId = arg1.CreatingUniverseId

    return module2
end

function module.fromPurchaseSuccess(arg1)
    local module2 = module.new()
    module2.assetId = tostring(arg1)
    module2.owned = true
    return module2
end

function module.fromGetVersionInfo(arg1, arg2)
    local module2 = module.new()

    module2.assetId = tostring(arg1)
    local var1 = if arg2.creatingUniverseId then tostring(arg2.creatingUniverseId) else nil
    module2.creatingUniverseId = var1

    return module2
end

function module.getSaleDetailsForCollectibles(arg1)
    local var1 = Dash.joinDeep({}, arg1)
    local saleLocation = arg1.saleLocation
    if arg1.productType == Constants.ProductType.CollectibleItem then
        local var2 = saleLocation and saleLocation.SaleLocationType ~= Constants.SaleLocationType.ShopOnly
        local var3 = saleLocation and saleLocation.SaleLocationType ~= Constants.SaleLocationType.ShopAndExperiencesById
        local bool1 = saleLocation
            and saleLocation.SaleLocationType == Constants.SaleLocationType.ShopAndExperiencesById
            and type(saleLocation.UniverseIds) == "table"
            and table.find(saleLocation.UniverseIds, game.GameId) ~= nil
        local var4 = saleLocation and saleLocation.SaleLocationType ~= Constants.SaleLocationType.ExperiencesDevApiOnly

        local canBeSoldInThisGame = arg1.isForSale and arg1.canBeSoldInThisGame

        if canBeSoldInThisGame then
            if var2 then
                if not (var3 or bool1) then
                    var4 = bool1
                end
            else
                var4 = var2
            end
        else
            var4 = canBeSoldInThisGame
        end

        var1.isForSale = var4

        if not arg1.collectibleIsLimited then
            var1.isForSale = var1.isForSale and not var1.owned
            return var1
        end
    else
        var1.isForSale = arg1.isForSale and arg1.canBeSoldInThisGame
        if arg1.canBeSoldInThisGame == nil then
            var1.isForSale = arg1.isForSale
        end
    end
    return var1
end

return module

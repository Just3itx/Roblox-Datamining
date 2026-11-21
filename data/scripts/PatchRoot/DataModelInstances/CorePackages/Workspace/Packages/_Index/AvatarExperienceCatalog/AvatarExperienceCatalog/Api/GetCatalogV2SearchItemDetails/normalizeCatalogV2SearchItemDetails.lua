-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local normalize = AvatarExperienceCommon.Utils.normalize
local normalizeBoolean = normalize.normalizeBoolean
local normalizeString = normalize.normalizeString
local normalizeNumber = normalize.normalizeNumber
local makeNormalizeTableFn = normalize.makeNormalizeTableFn
local getRawItemLicensingInfo = AvatarExperienceCommon.Utils.getRawItemLicensingInfo

local convertToPascalCase = require(AvatarExperienceCatalog.Utils.convertToPascalCase)
local FFlagAXMarketplaceLicensing = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXMarketplaceLicensing

local ASSET_TYPE_ID_STRING_TO_NAME = require(AvatarExperienceCatalogParent.AvatarExperienceCommon).Constants.ASSET_TYPE_ID_STRING_TO_NAME
local _CatalogV2SearchItemDetails = require(AvatarExperienceCatalog.Models.CatalogV2SearchItemDetails)

local tbl1 = {
    "BodyParts",
    "Animations",
    "Shoes",
    "DynamicHead"
}

local function normalizeBundledItem(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        Id = normalizeNumber(arg1.id),
        Name = normalizeString(arg1.name),
        Type = normalizeString(arg1.type)
    }
end

local function normalizeBundledItems(bundledItems)
    if typeof(bundledItems) ~= "table" then
        return nil
    end

    local result = {}
    for _, bundledItem in bundledItems do
        table.insert(result, normalizeBundledItem(bundledItem))
    end

    return result
end

local function normalizeTimedOptions(tbl2)
    local tbl3

    if tbl2.timedOptions then
        tbl3 = {}
        for _, timedOption in tbl2.timedOptions do
            table.insert(tbl3, {
                days = normalizeNumber(timedOption.days),
                price = normalizeNumber(timedOption.price),
                selected = if timedOption.selected then normalizeBoolean(timedOption.selected) else nil,
                discountInformation = timedOption.discountInformation
            })
        end
    else
        tbl3 = nil
    end

    return tbl3
end

local function normalizeItem(arg1)
    if type(arg1) ~= "table" then
        return nil, "Item must be a table"
    end

    local var1 = if arg1.assetType then ASSET_TYPE_ID_STRING_TO_NAME[tostring(arg1.assetType)] else nil
    local bundleType = arg1.bundleType
    local bundleType2

    if type(bundleType) == "number" then
        bundleType2 = tbl1[arg1.bundleType]
        bundleType2 = bundleType2 or tostring(arg1.bundleType)
    else
        bundleType2 = arg1.bundleType
    end

    local rawItemLicensingInfo = getRawItemLicensingInfo(arg1)

    local tbl2 = {
        assetType = normalizeString(var1),
        bundleType = normalizeString(bundleType2),
        bundledItems = normalizeBundledItems(arg1.bundledItems),
        collectibleItemId = normalizeString(arg1.collectibleItemId),
        creatorHasVerifiedBadge = normalizeBoolean(arg1.creatorHasVerifiedBadge),
        creatorName = normalizeString(arg1.creatorName),
        creatorTargetId = normalizeNumber(arg1.creatorTargetId),
        creatorType = normalizeString(arg1.creatorType),
        description = normalizeString(arg1.description),
        favoriteCount = normalizeNumber(arg1.favoriteCount),
        hasResellers = normalizeBoolean(arg1.hasResellers),
        id = normalizeNumber(arg1.id),
        isRecolorable = normalizeBoolean(arg1.isRecolorable),
        itemRestrictions = arg1.itemRestrictions or {},
        itemStatus = arg1.itemStatus or {},
        itemType = normalizeString(arg1.itemType),
        lowestPrice = normalizeNumber(arg1.lowestPrice),
        lowestResalePrice = normalizeNumber(arg1.lowestResalePrice),
        name = normalizeString(arg1.name),
        price = normalizeNumber(arg1.price),
        productId = normalizeNumber(arg1.productId),
        priceStatus = normalizeString(arg1.priceStatus),
        saleLocationType = normalizeString(arg1.saleLocationType),
        totalQuantity = normalizeNumber(arg1.totalQuantity),
        unitsAvailableForConsumption = normalizeNumber(arg1.unitsAvailableForConsumption),
        offSaleDeadline = normalizeString(arg1.offSaleDeadline),
        quantityLimitPerUser = normalizeNumber(arg1.quantityLimitPerUser),
        isOffSale = normalizeBoolean(arg1.isOffSale),
        timedOptions = normalizeTimedOptions(arg1),
        itemLicensingInfo = 0
    }

    if not FFlagAXMarketplaceLicensing then
        rawItemLicensingInfo = nil
    end

    tbl2.itemLicensingInfo = rawItemLicensingInfo

    return convertToPascalCase(tbl2), nil
end

return (makeNormalizeTableFn({
    data = function(tbl2) -- name: normalizeItemsData
        if typeof(tbl2) ~= "table" then
            return nil, nil
        end
        local tbl3 = ({})
        local tbl4 = {}
        for value, value2 in tbl2 do
            local var1, var2 = normalizeItem(value2)
            table.insert(tbl4, var2)
            tbl3[value] = var1
        end

        return tbl3, if next(tbl4) then table.concat(tbl4, " ") else nil
    end,
    nextPageCursor = normalizeString
}))

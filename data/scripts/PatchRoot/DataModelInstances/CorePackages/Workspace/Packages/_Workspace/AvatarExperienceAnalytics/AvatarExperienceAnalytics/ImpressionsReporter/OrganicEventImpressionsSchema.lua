-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local Constants = require(script.Parent.Parent.Constants)
local ImpressionEnums = require(script.Parent.Parent.Enums.ImpressionEnums)
local ImpressionsUtil = require(script.Parent.ImpressionsUtil)

local FFlagAXFixUnifiedPurchaseFieldLanding = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags).FFlagAXFixUnifiedPurchaseFieldLanding

local tbl1 = {}

local tbl2 = {
    __newindex = function(_, arg1)
        error("Attempt to insert into impressions schemas: " .. arg1)
    end,
    __index = function(arg1, arg2)
        if not arg2 then
            warn("Nil ImpressionsSchema lookup")
            return
        end

        local var1 = rawget(arg1, arg2)
        if not var1 then
            warn("No such impressions schema: " .. arg2)
        end

        return var1
    end
}

tbl1.defaultItem = ImpressionsUtil.buildSchema(Constants.IMPRESSIONS_EVENTS.AvatarItems, {
    enumMap = {
        contentType = {
            Asset = ImpressionEnums.MarketplaceItemType.ASSET,
            Bundle = ImpressionEnums.MarketplaceItemType.BUNDLE,
            Look = ImpressionEnums.MarketplaceItemType.LOOK
        }
    },
    surfaceSpecificAnalyticsMetadata = {
        [ImpressionEnums.MarketplaceSurfaceType.HOMEPAGE] = {
            { prop = "sortEnumValue", out = "sort" },
            { prop = "filterSalesTypeEnumValue", out = "filterSalesType" },
            { prop = "filterCreatorsTypeEnumValue", out = "filterCreators" },
            { prop = "filterPriceEnumValue", out = "filterPrice" },
            { prop = "filterUnavailableItemsEnumValue", out = "filterUnavailableItems" },
            { prop = "filterCreatorsName", out = "filterCreatorsName" },
            { prop = "filterPriceMin", out = "filterPriceMin" },
            { prop = "filterPriceMax", out = "filterPriceMax" }
        },
        [ImpressionEnums.MarketplaceSurfaceType.SEARCH] = {},
        [ImpressionEnums.MarketplaceSurfaceType.MARKETPLACE_USER_INVENTORY] = {}
    },
    mapping = {
        { prop = "index", out = "absPositions" },
        { prop = "itemId", out = "itemId" },
        { prop = "itemType", out = "contentType" },
        { prop = "impressionsGroup", out = "group" },
        { prop = "impressionsSearch", out = "keyword" },
        { prop = "impressionsCategory", out = "category" },
        { prop = "impressionsSubcategory", out = "subcategory" },
        { prop = "surface", out = "surface" },
        { prop = "sort", out = "sort" }
    },
    groupBy = { "itemId" }
})

if FFlagAXFixUnifiedPurchaseFieldLanding then
    local surfaceSpecificAnalyticsMetadata = tbl1.defaultItem.surfaceSpecificAnalyticsMetadata
    if surfaceSpecificAnalyticsMetadata then
        surfaceSpecificAnalyticsMetadata[ImpressionEnums.MarketplaceSurfaceType.HOMEPAGE] = {
            { prop = "sort", out = "sort" },
            { prop = "filterSalesType", out = "filterSalesType" },
            { prop = "filterCreators", out = "filterCreators" },
            { prop = "filterPrice", out = "filterPrice" },
            { prop = "filterUnavailableItems", out = "filterUnavailableItems" },
            { prop = "filterCreatorsName", out = "filterCreatorsName" },
            { prop = "filterPriceMin", out = "filterPriceMin" },
            { prop = "filterPriceMax", out = "filterPriceMax" }
        }
    end
end

setmetatable(tbl1, tbl2)

return tbl1

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")
local AvatarExperienceAnalyticsParent = AvatarExperienceAnalytics.Parent

local Cryo = require(AvatarExperienceAnalyticsParent.Cryo)
local _AvatarExperienceCommon = require(AvatarExperienceAnalyticsParent.AvatarExperienceCommon)
local ItemTypeEnum = require(AvatarExperienceAnalyticsParent.AvatarExperienceModel).Enums.ItemTypeEnum

local _UnifiedEventTypes = require(AvatarExperienceAnalytics.Generated.UnifiedEventTypes)
local getMarketplaceUnifiedItemType = require(AvatarExperienceAnalytics.Utils.getMarketplaceUnifiedItemType)
local getMarketplaceUnifiedLookType = require(AvatarExperienceAnalytics.Utils.getMarketplaceUnifiedLookType)
local getMarketplaceUnifiedAssetType = require(AvatarExperienceAnalytics.Utils.getMarketplaceUnifiedAssetType)
local getMarketplaceUnifiedBundleType = require(AvatarExperienceAnalytics.Utils.getMarketplaceUnifiedBundleType)
local getItemSelectionAction = require(AvatarExperienceAnalytics.Utils.getItemSelectionAction)
local getTimedOptionForItemData = require(AvatarExperienceAnalytics.Utils.getTimedOptionForItemData)
local UnifiedEventLoggingUtils = require(AvatarExperienceAnalytics.Utils.UnifiedEventLoggingUtils)

local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceFlags.FFlagAXUnifiedEventStrictPayloads

local FFlagAXEditorRecommendedItemsUnifiedImpressions = AvatarExperienceFlags.FFlagAXEditorRecommendedItemsUnifiedImpressions

local function joinIds(tbl1) -- Luacid: Inlined by compiler; 4 call sites recovered
    if tbl1 then
        return table.concat(tbl1, ",")
    end

    return nil
end

local function isReadyToLog(tbl1): boolean
    local itemType = tbl1.itemType
    local itemData = tbl1.itemData
    local lookData = tbl1.lookData
    local hydratedContent = tbl1.hydratedContent

    local var1 = nil
    local var2 = nil
    local var3 = nil

    if tbl1.widgetAnalyticsInfo then
        if itemType == ItemTypeEnum.Look then
            if lookData then
                var1 = lookData.totalPrice ~= nil
            else
                var1 = false
            end

            var2 = tbl1.widgetAnalyticsInfo.itemId ~= nil
            var3 = true
        else
            if hydratedContent then
                var1 = hydratedContent.price ~= nil
            else
                var1 = false
            end

            var2 = tbl1.widgetAnalyticsInfo.itemId ~= nil
            var3 = true
        end
    elseif tbl1.isOrganic then
        if itemType == ItemTypeEnum.Look then
            if lookData then
                var1 = lookData.totalPrice ~= nil
            else
                var1 = false
            end

            var2 = tbl1.itemId ~= nil
            var3 = true
        else
            if itemData then
                var1 = itemData.lowestPrice ~= nil or itemData.priceInRobux ~= nil
            else
                var1 = false
            end

            var2 = tbl1.itemId ~= nil
            if itemData then
                if itemData.assetType ~= nil then
                    var3 = true
                elseif itemData.bundleType == nil then
                    var3 = false
                else
                    var3 = itemData.bundleType ~= "AvatarAnimations"
                end
            else
                var3 = false
            end
        end
    end

    return var1 == true and var2 == true and var3 == true
end

local function buildFields(tbl1)
    local itemData = tbl1.itemData
    local lookData = tbl1.lookData
    local hydratedContent = tbl1.hydratedContent
    local assetAndBundleIds = tbl1.assetAndBundleIds
    local isOrganic = tbl1.isOrganic
    local widgetAnalyticsInfo = tbl1.widgetAnalyticsInfo
    local tbl2

    if widgetAnalyticsInfo then
        tbl2 = widgetAnalyticsInfo
    else
        tbl2 = {
            itemId = if FFlagAXUnifiedEventStrictPayloads and tbl1.itemId ~= nil then tostring(tbl1.itemId) else tbl1.itemId,
            assetType = if itemData then if FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedAssetType(itemData.assetType) else itemData.assetType else nil,
            bundleType = if itemData then if FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedBundleType(itemData.bundleType) else itemData.bundleType else nil,
            gridPositionRow = tbl1.gridPositionRow,
            gridPositionColumn = tbl1.gridPositionColumn,
            itemPosition = tbl1.itemPosition
        }
    end
    local tbl3 = {
        itemType = getMarketplaceUnifiedItemType(tbl1.itemType),
        action = getItemSelectionAction(tbl1.isSelected == true),
        category = tbl1.impressionsCategory,
        subcategory = tbl1.impressionsSubcategory,
        taxonomyId = tbl1.impressionsTaxonomyId,
        section = if FFlagAXEditorRecommendedItemsUnifiedImpressions then tbl1.section else nil,
        gridPositionRow = if FFlagAXUnifiedEventStrictPayloads and tbl2.gridPositionRow == nil then tbl1.gridPositionRow else nil,
        gridPositionColumn = if FFlagAXUnifiedEventStrictPayloads and tbl2.gridPositionColumn == nil then tbl1.gridPositionColumn else nil,
        assetIds = if widgetAnalyticsInfo and assetAndBundleIds then if FFlagAXUnifiedEventStrictPayloads then joinIds(assetAndBundleIds.assetIds) else assetAndBundleIds.assetIds else nil,
        bundleIds = if widgetAnalyticsInfo and assetAndBundleIds then if FFlagAXUnifiedEventStrictPayloads then joinIds(assetAndBundleIds.bundleIds) else assetAndBundleIds.bundleIds else nil,
        organicAssetIds = if isOrganic and assetAndBundleIds then if FFlagAXUnifiedEventStrictPayloads then joinIds(assetAndBundleIds.assetIds) else assetAndBundleIds.assetIds else nil,
        organicBundleIds = if isOrganic and assetAndBundleIds then if FFlagAXUnifiedEventStrictPayloads then joinIds(assetAndBundleIds.bundleIds) else assetAndBundleIds.bundleIds else nil,
        organicLookType = if isOrganic and lookData and lookData.lookType then if FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedLookType(lookData.lookType) else UnifiedEventLoggingUtils.formatLookTypeAttribute(lookData.lookType) else nil,
        widgetLookType = if lookData and lookData.lookType and not isOrganic then if FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedLookType(lookData.lookType) else UnifiedEventLoggingUtils.formatLookTypeAttribute(lookData.lookType) else nil,
        organicItemPrice = if isOrganic then if lookData then lookData.totalPrice elseif itemData then itemData.lowestPrice or itemData.priceInRobux else nil else nil,
        widgetItemPrice = if widgetAnalyticsInfo then if lookData then lookData.totalPrice elseif hydratedContent then hydratedContent.price else nil else nil,
        organicTimedOption = if isOrganic and itemData then getTimedOptionForItemData(itemData) else nil,
        widgetTimedOption = if isOrganic or not itemData then nil else getTimedOptionForItemData(itemData),
        widgetAssetType = if isOrganic or not itemData then nil elseif FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedAssetType(itemData.assetType) else itemData.assetType,
        widgetBundleType = if isOrganic or not itemData then nil elseif FFlagAXUnifiedEventStrictPayloads then getMarketplaceUnifiedBundleType(itemData.bundleType) else itemData.bundleType
    }

    return (Cryo.Dictionary.join(tbl2, tbl3))
end

local function getCatalogItemUnifiedLoggingFields(tbl1)
    if not isReadyToLog(tbl1) then
        return nil
    end

    return (buildFields(tbl1))
end

return getCatalogItemUnifiedLoggingFields

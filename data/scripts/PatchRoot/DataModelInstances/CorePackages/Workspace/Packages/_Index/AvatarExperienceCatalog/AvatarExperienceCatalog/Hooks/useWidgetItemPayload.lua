-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local React = require(AvatarExperienceCatalogParent.React)
local Cryo = require(AvatarExperienceCatalogParent.Cryo)
local _AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AvatarExperienceAnalytics = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics)
local FFlagAXUnifiedEventStrictPayloads = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXUnifiedEventStrictPayloads

local function useWidgetItemPayload(tbl1)
    return React.useMemo(function()
        return Cryo.Dictionary.join(tbl1.widgetAnalyticsInfo or {}, {
            action = tbl1.action,
            itemId = tbl1.itemId,
            itemType = tbl1.itemType,
            itemPosition = tbl1.itemPosition,
            gridPositionRow = tbl1.gridPositionRow,
            gridPositionColumn = tbl1.gridPositionColumn,
            uiTreatmentType = tbl1.uiTreatmentType,
            themeId = tbl1.themeId,
            category = tbl1.category,
            subcategory = tbl1.subcategory,
            taxonomyId = tbl1.taxonomyId,
            widgetItemPrice = tbl1.widgetItemPrice,
            widgetTimedOption = tbl1.widgetTimedOption,
            widgetAssetType = if FFlagAXUnifiedEventStrictPayloads then AvatarExperienceAnalytics.Utils.getMarketplaceUnifiedAssetType(tbl1.widgetAssetType) else tbl1.widgetAssetType,
            widgetBundleType = if FFlagAXUnifiedEventStrictPayloads then AvatarExperienceAnalytics.Utils.getMarketplaceUnifiedBundleType(tbl1.widgetBundleType) else tbl1.widgetBundleType,
            widgetLookType = tbl1.widgetLookType,
            assetIds = tbl1.assetIds,
            bundleIds = tbl1.bundleIds
        })
    end, {
        tbl1.action,
        tbl1.widgetAnalyticsInfo,
        tbl1.itemId,
        tbl1.itemType,
        tbl1.itemPosition,
        tbl1.gridPositionRow,
        tbl1.gridPositionColumn,
        tbl1.uiTreatmentType,
        tbl1.themeId,
        tbl1.category,
        tbl1.subcategory,
        tbl1.taxonomyId,
        tbl1.widgetItemPrice,
        tbl1.widgetTimedOption,
        tbl1.widgetAssetType,
        tbl1.widgetBundleType,
        tbl1.widgetLookType,
        tbl1.assetIds,
        tbl1.bundleIds
    })
end

return useWidgetItemPayload

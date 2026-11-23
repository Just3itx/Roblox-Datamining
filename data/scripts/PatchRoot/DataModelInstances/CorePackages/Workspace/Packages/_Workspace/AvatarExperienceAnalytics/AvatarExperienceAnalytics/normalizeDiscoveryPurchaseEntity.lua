-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local MarketplaceUnifiedAction = require(script.Parent.UnifiedEventLogEnums).MarketplaceUnifiedAction
local UnifiedLoggingSurface = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation).Enums.UnifiedLoggingSurface

local tbl1 = {
    "widgetId",
    "widgetType",
    "assetIds",
    "bundleIds",
    "widgetItemIds",
    "organicResultIds",
    "widgetItemPrice",
    "uiTreatmentType",
    "themeId",
    "widgetItemWearAfterPurchase",
    "widgetItemSaveToMyAvatars"
}

local tbl2 = {
    "assetType",
    "bundleType",
    "organicItemPrice",
    "organicItemWearAfterPurchase",
    "organicItemSaveToMyAvatars",
    "organicAssetIds",
    "organicBundleIds"
}

local function isDiscoverySurface(surface: number?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return surface == UnifiedLoggingSurface.DISCOVERY_HOMEPAGE or surface == UnifiedLoggingSurface.DISCOVERY_SEARCH_RESULTS
end

local function isNonEmpty(arg1): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return not (arg1 == nil) and arg1 ~= ""
end

local function normalizeDiscoveryPurchaseEntity(tbl3)
    local action = tbl3.action

    if action ~= MarketplaceUnifiedAction.PURCHASE_SUCCESS and action ~= MarketplaceUnifiedAction.PURCHASE_ATTEMPT
        or not isDiscoverySurface(tbl3.surface)
    then
        return tbl3
    end

    local bool1 = isNonEmpty(tbl3.widgetId)
        and isNonEmpty(tbl3.widgetType)
        and isNonEmpty(tbl3.widgetItemIds)
        and isNonEmpty(tbl3.requestId)

    local var1 = table.clone(tbl3)
    if bool1 then
        for _, value in tbl2 do
            var1[value] = nil
        end

        return var1
    end

    var1.organicItemPrice = var1.organicItemPrice or var1.widgetItemPrice
    var1.organicAssetIds = var1.organicAssetIds or var1.assetIds
    var1.organicBundleIds = var1.organicBundleIds or var1.bundleIds
    if var1.organicItemWearAfterPurchase == nil then
        var1.organicItemWearAfterPurchase = var1.widgetItemWearAfterPurchase
    end
    if var1.organicItemSaveToMyAvatars == nil then
        var1.organicItemSaveToMyAvatars = var1.widgetItemSaveToMyAvatars
    end
    for _, value in tbl1 do
        var1[value] = nil
    end

    return var1
end

return normalizeDiscoveryPurchaseEntity

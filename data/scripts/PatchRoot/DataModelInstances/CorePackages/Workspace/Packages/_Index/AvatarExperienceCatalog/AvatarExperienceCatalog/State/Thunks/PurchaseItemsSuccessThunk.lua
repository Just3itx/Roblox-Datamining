-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local mutedError = require(AvatarExperienceCatalogParent.Loggers).mutedError

local PurchaseItemsSuccess = require(AvatarExperienceCatalog.State.Actions.PurchaseItemsSuccess)

local AvatarExperienceAnalytics = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics)
local AvatarExperienceNavigation = require(AvatarExperienceCatalogParent.AvatarExperienceNavigation)
local UnifiedSelectionListStore = AvatarExperienceAnalytics.Store.UnifiedSelectionListStore
local sendUnifiedEventsForMultiItemShopping = AvatarExperienceAnalytics.sendUnifiedEventsForMultiItemShopping
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local getUnifiedEventsForMIS = AvatarExperienceAnalytics.Utils.getUnifiedEventsForMIS
local CartIdService = AvatarExperienceAnalytics.Lib.CartIdService
local AvatarScreenProperties = AvatarExperienceNavigation.AvatarRoute.AvatarScreenProperties

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local FFlagAXMISEnableMultiShoppingUnifiedEvents = AvatarExperienceFlags.FFlagAXMISEnableMultiShoppingUnifiedEvents
local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceFlags.FFlagAXUnifiedEventStrictPayloads
local FFlagAXMISSaveWearFix = AvatarExperienceFlags.FFlagAXMISSaveWearFix
local FFlagAXBackgroundsCustomizeHydration = AvatarExperienceFlags.FFlagAXBackgroundsCustomizeHydration

local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local ApplyProfileConfiguration = require(AvatarExperienceCatalogParent.AvatarExperienceRodux).Actions.ApplyProfileConfiguration

local AvatarBackground = AvatarExperienceCommon.Constants.ASSET_TYPE_NAME_TO_ID_STRING.AvatarBackground

local function maybeApplyPurchasedBackground(arg1, equippableAssets)
    local var1 = nil
    for _, equippableAsset in equippableAssets do
        if equippableAsset.assetTypeId == AvatarBackground then
            var1 = tonumber(equippableAsset.assetId)
        end
    end
    if var1 then
        arg1:dispatch(ApplyProfileConfiguration({ BackgroundAssetId = var1 }))
    end
end

local FFlagSignalsNavP3gAvatarExperience = require(AvatarExperienceCatalogParent.SharedFlags).FFlagSignalsNavP3gAvatarExperience
local GetLegacyNavigationStore = require(AvatarExperienceCatalogParent.NavigationRodux).GetLegacyNavigationStore

return if FFlagAXMISEnableMultiShoppingUnifiedEvents then function(items, equippableAssets, replaceAllEquippedAssets, bodyColor3s, bodyScales, bodyPartColorRangeIds, arg2, arg3, shouldClearEquippedMakeup, arg4, arg5, func1: ((...any) -> (...any))?)
    return function(arg6, _)
        local state = arg6:getState()
        local routeName

        if FFlagSignalsNavP3gAvatarExperience then
            local var1 = GetLegacyNavigationStore(false).getCurrentRoute(false)
            routeName = var1 and var1.routeName
        else
            routeName = state.Navigation and state.Navigation.currentRoute and state.Navigation.currentRoute.routeName
        end
        local var1 = AvatarScreenProperties[routeName]
        local unifiedLoggingSurface = if var1 and var1.analyticsData then var1.analyticsData.unifiedLoggingSurface else nil

        if not pcall(function()
            if arg4 then
                arg4.isOrganicLook = state.AvatarExperience.AvatarScene.OutfitTryOn.LookAnalyticsInfo == nil
            end

            if arg5 then
                arg5.isOrganicLook = state.AvatarExperience.AvatarScene.OutfitTryOn.MakeupLookAnalyticsInfo == nil
            end

            local var2, var3 = getUnifiedEventsForMIS(
                items,
                arg2,
                arg4,
                arg5,
                UnifiedEventLogEnums.MarketplaceUnifiedAction.PURCHASE_SUCCESS,
                if FFlagAXUnifiedEventStrictPayloads then unifiedLoggingSurface else nil,
                if FFlagAXUnifiedEventStrictPayloads then state.AvatarExperience.AvatarScene.OutfitTryOn.LookAnalyticsInfo else nil,
                if FFlagAXUnifiedEventStrictPayloads then state.AvatarExperience.AvatarScene.OutfitTryOn.MakeupLookAnalyticsInfo else nil
            )

            local var4 = sendUnifiedEventsForMultiItemShopping

            local var5 = unifiedLoggingSurface
            if not FFlagAXUnifiedEventStrictPayloads then
                var3 = nil
            end

            var4(var2, var5, var3)
        end) then
            mutedError("Failed to send unified events for multi-item shopping purchase success")
        end

        CartIdService.refreshCartId()
        UnifiedSelectionListStore.clearSelectionList()
        local var2 = if FFlagAXMISSaveWearFix and func1 then func1(state, arg2) else nil
        local tbl1 = {}
        if FFlagAXMISSaveWearFix and var2 then
            for _, child in var2:GetChildren() do
                if child:IsA("MakeupDescription") then
                    local assetId = child.assetId
                    tbl1[tostring(assetId)] = child.order
                end
            end
        end

        if bodyScales == nil then
            local var3 = arg3(state, arg2)
            bodyScales = if var3 then var3.scales else nil
        end

        local var3 = PurchaseItemsSuccess
        local tbl2 = {
            items = items,
            equippableAssets = equippableAssets,
            replaceAllEquippedAssets = replaceAllEquippedAssets,
            shouldClearEquippedMakeup = if FFlagAXMISSaveWearFix then shouldClearEquippedMakeup else nil,
            bodyColor3s = bodyColor3s,
            bodyScales = bodyScales,
            bodyPartColorRangeIds = bodyPartColorRangeIds,
            makeupAssetsOnHumanoid = 0
        }

        if not FFlagAXMISSaveWearFix then
            tbl1 = nil
        end

        tbl2.makeupAssetsOnHumanoid = tbl1
        arg6:dispatch(var3(tbl2))

        if FFlagAXBackgroundsCustomizeHydration then
            maybeApplyPurchasedBackground(arg6, equippableAssets)
        end
    end
end else function(items, equippableAssets, replaceAllEquippedAssets, bodyColor3s, bodyScales, bodyPartColorRangeIds, arg2, arg3, shouldClearEquippedMakeup)
    return function(arg4, _)
        local state = arg4:getState()

        if bodyScales == nil then
            local var1 = arg3(state, arg2)
            bodyScales = if var1 then var1.scales else nil
        end

        arg4:dispatch(
            PurchaseItemsSuccess({
                items = items,
                equippableAssets = equippableAssets,
                replaceAllEquippedAssets = replaceAllEquippedAssets,
                shouldClearEquippedMakeup = shouldClearEquippedMakeup,
                bodyColor3s = bodyColor3s,
                bodyScales = bodyScales,
                bodyPartColorRangeIds = bodyPartColorRangeIds
            })
        )
        if FFlagAXBackgroundsCustomizeHydration then
            maybeApplyPurchasedBackground(arg4, equippableAssets)
        end
    end
end

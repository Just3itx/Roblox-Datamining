-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")
local AvatarExperienceAnalyticsParent = AvatarExperienceAnalytics.Parent

local Cryo = require(AvatarExperienceAnalyticsParent.Cryo)
local React = require(AvatarExperienceAnalyticsParent.React)
local UnifiedEventLogEnums = require(script.Parent.UnifiedEventLogEnums)
local AvatarExperienceNavigation = require(AvatarExperienceAnalyticsParent.AvatarExperienceNavigation)
local useAvatarRoute = AvatarExperienceNavigation.AvatarRoute.Hooks.useAvatarRoute
local AvatarScreenProperties = AvatarExperienceNavigation.AvatarRoute.AvatarScreenProperties
local UnifiedLoggingSurface = AvatarExperienceNavigation.Enums.UnifiedLoggingSurface
local sendUnifiedEventLogForInstance = require(script.Parent.sendUnifiedEventLogForInstance)
local AvatarExperienceCommon = require(AvatarExperienceAnalyticsParent.AvatarExperienceCommon)
local useSelectorSignal = AvatarExperienceCommon.Hooks.useSelectorSignal
local selectSearchKeyword = AvatarExperienceCommon.State.Selectors.selectSearchKeyword
local UnifiedEventLoggingUtils = require(AvatarExperienceAnalytics.Utils.UnifiedEventLoggingUtils)
local mapAnalyticsMetadataFields = require(AvatarExperienceAnalytics.Utils.mapAnalyticsMetadataFields)
local AvatarExperienceFlags = require(AvatarExperienceAnalyticsParent.AvatarExperienceFlags)
local FFlagAXUnifiedImpressionsOnThumbnail = AvatarExperienceFlags.FFlagAXUnifiedImpressionsOnThumbnail
local FFlagAXUnifiedEventStrictPayloads = AvatarExperienceFlags.FFlagAXUnifiedEventStrictPayloads
local UnifiedEventLogConstants = require(script.Parent.UnifiedEventLogConstants)

local function selectAnalyticsMetadata(arg1)
    return arg1.AvatarExperience.AnalyticsMetadata
end

local function useUnifiedEventImpressionsReporter(str1: string?)
    local var1 = useAvatarRoute()
    local var2 = useSelectorSignal(selectSearchKeyword)
    local var3 = useSelectorSignal(selectAnalyticsMetadata)

    local useCallback = React.useCallback
    local function func1(tbl1)
        local visibleInstance = tbl1.visibleInstance
        local var4 = AvatarScreenProperties[var1.opaque.name]

        local var5 = nil

        for value, value2 in (visibleInstance:GetAttributes()) do
            if not UnifiedEventLoggingUtils.isUnifiedLoggingAttribute(value)
                or UnifiedEventLoggingUtils.getUnifiedLoggingFieldName(value) ~= "action"
            then
                continue
            end

            if value2 == UnifiedEventLogEnums.MarketplaceUnifiedAction.WIDGET_IMPRESSION then
                var5 = true
            end

            if value2 == UnifiedEventLogEnums.MarketplaceUnifiedAction.PURCHASE_ATTEMPT
                or value2 == UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK
            then
                return
            end
        end

        if FFlagAXUnifiedImpressionsOnThumbnail then
            local var6 = AvatarScreenProperties[str1 or var1.opaque.name]

            local tbl2 = {
                action = if var5 then UnifiedEventLogEnums.MarketplaceUnifiedAction.WIDGET_IMPRESSION else UnifiedEventLogEnums.MarketplaceUnifiedAction.ITEM_IMPRESSION,
                keyword = var2(false)
            }
            if visibleInstance:GetAttribute(UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "surface") == nil then
                tbl2.surface = if var6 and var6.analyticsData then var6.analyticsData.unifiedLoggingSurface else nil
            end

            if (tbl2.surface or visibleInstance:GetAttribute(UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "surface")) ~= UnifiedLoggingSurface.SEARCH_RESULTS then
                tbl2.keyword = nil
            end

            local var7 = Cryo.Dictionary.join(
                if FFlagAXUnifiedEventStrictPayloads then mapAnalyticsMetadataFields(var3(false), true) else var3(false),
                {
                    selectedItemIndex = Cryo.None
                }
            )
            sendUnifiedEventLogForInstance(
                visibleInstance,
                Cryo.Dictionary.union(var7, tbl2),
                { includeScreenSize = true, includeElementSizeAndPosition = true }
            )
        elseif FFlagAXUnifiedEventStrictPayloads then
            sendUnifiedEventLogForInstance(
                visibleInstance,
                Cryo.Dictionary.join(mapAnalyticsMetadataFields(var3(false), true), {
                    action = if var5 then UnifiedEventLogEnums.MarketplaceUnifiedAction.WIDGET_IMPRESSION else UnifiedEventLogEnums.MarketplaceUnifiedAction.ITEM_IMPRESSION,
                    surface = if var4 and var4.analyticsData then var4.analyticsData.unifiedLoggingSurface else nil,
                    keyword = var2(false)
                }),
                { includeScreenSize = true, includeElementSizeAndPosition = true }
            )
        else
            sendUnifiedEventLogForInstance(
                visibleInstance,
                Cryo.Dictionary.join(var3(false), {
                    action = if var5 then UnifiedEventLogEnums.MarketplaceUnifiedAction.WIDGET_IMPRESSION else UnifiedEventLogEnums.MarketplaceUnifiedAction.ITEM_IMPRESSION,
                    surface = if var4 and var4.analyticsData then var4.analyticsData.unifiedLoggingSurface else nil,
                    keyword = var2(false)
                }),
                { includeScreenSize = true, includeElementSizeAndPosition = true }
            )
        end
    end

    local var4 = if FFlagAXUnifiedImpressionsOnThumbnail then str1 else nil
    return useCallback(func1, { var1, var2, var3, var4 })
end

return useUnifiedEventImpressionsReporter

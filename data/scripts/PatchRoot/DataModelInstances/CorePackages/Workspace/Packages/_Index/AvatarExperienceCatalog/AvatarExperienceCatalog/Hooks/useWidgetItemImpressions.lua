-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local Cryo = require(AvatarExperienceCatalogParent.Cryo)
local _AppCommonLib = require(AvatarExperienceCatalogParent.AppCommonLib)

local _AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local SeenImpressionsStore = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics).Store.SeenImpressionsStore
local Category = SeenImpressionsStore.Category

local useOnRequestImpressionsSignal = require(AvatarExperienceCatalog.Components.Hooks.useOnRequestImpressionsSignal)

local function useWidgetItemImpressions(tbl1)
    local onRequestImpressionsSignal = useOnRequestImpressionsSignal()

    local widgetId = tbl1.widgetId
    local content = tbl1.content
    local widgetRow = tbl1.widgetRow
    local itemsPerRow = tbl1.itemsPerRow
    local widgetAnalyticsInfo = tbl1.widgetAnalyticsInfo
    local uiTreatmentType = tbl1.uiTreatmentType
    local reportItemImpression = tbl1.reportItemImpression
    local buildItemImpressionInfo = tbl1.buildItemImpressionInfo

    return {
        onRequestImpressionsSignal = onRequestImpressionsSignal,
        onImpressionsDetected = React.useCallback(function(tbl2)
            for _, itemPosition in tbl2 do
                local var2 = widgetId .. "_" .. itemPosition
                if SeenImpressionsStore.hasSeen(Category.WidgetItems, var2) then
                    continue
                end

                local var3 = content[itemPosition] or {}
                local itemImpressionInfo

                if buildItemImpressionInfo then
                    itemImpressionInfo = buildItemImpressionInfo(var3, itemPosition)
                else
                    local var4 = if var3.id == nil then nil else tostring(var3.id)
                    itemImpressionInfo = Cryo.Dictionary.join(widgetAnalyticsInfo, {
                        widgetPosition = widgetRow,
                        widgetId = widgetId,
                        itemPosition = itemPosition,
                        itemId = var4,
                        itemType = var3.type,
                        widgetAbsPosition = (widgetRow - 1) * itemsPerRow,
                        uiTreatmentType = uiTreatmentType
                    })
                end
                reportItemImpression(itemImpressionInfo)
                SeenImpressionsStore.markSeen(Category.WidgetItems, var2)
            end
        end, {
            widgetId,
            content,
            widgetRow,
            itemsPerRow,
            widgetAnalyticsInfo,
            uiTreatmentType,
            reportItemImpression,
            buildItemImpressionInfo
        })
    }
end
return useWidgetItemImpressions

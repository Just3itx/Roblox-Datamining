-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)
local Cryo = require(AvatarExperienceCatalogParent.Cryo)

local _AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local ItemTypeEnum = require(AvatarExperienceCatalogParent.AvatarExperienceModel).Enums.ItemTypeEnum

local AvatarExperienceAnalytics = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics)
local ImpressionEnums = AvatarExperienceAnalytics.Enums.ImpressionEnums
local sendAXCounterV2 = AvatarExperienceAnalytics.sendAXCounterV2

local FFlagAXDeferLookImpressionsForHydration = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXDeferLookImpressionsForHydration

local useStore = require(AvatarExperienceCatalogParent.RoactUtils).Hooks.RoactRodux.useStore

local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)
local selectHydratedWidgetData = require(AvatarExperienceCatalog.State.Selectors.selectHydratedWidgetData)
local Constants = require(AvatarExperienceCatalog.Constants)
local useCatalogPageMonolithDependencies = require(AvatarExperienceCatalog.Providers.useCatalogPageMonolithDependencies)

local function useOnCatalogSortImpressionsDetectedCallback(tbl1)
    local catalogAnalytics = useCatalogPageMonolithDependencies().catalogAnalytics

    local widgetInfo = tbl1.widgetInfo
    local widgetAnalyticsInfo = tbl1.widgetAnalyticsInfo
    local widgetRow = tbl1.widgetRow
    local itemsPerRow = tbl1.itemsPerRow
    local uiTreatmentType = tbl1.uiTreatmentType

    local var1 = useStore()

    local id = widgetInfo and widgetInfo.id or ""
    local content = if widgetInfo then widgetInfo.content else nil

    return React.useCallback(function(tbl2)
        local var2 = nil
        local function getHydratedLooks() -- Luacid: Inlined by compiler; 1 call site recovered
            if var2 ~= nil then
                return var2
            end
            local var3 = selectHydratedWidgetData(var1:getState())
            var2 = var3 and var3[ItemTypeEnum.Look] or false
            return var2
        end

        for _, itemPosition in tbl2 do
            local var3 = not content and {} or content[itemPosition] or {}
            local var4 = if var3.id == nil then nil else tostring(var3.id)
            local bool1 = var3.type == ItemTypeEnum.Look
            local lookType

            if bool1 then
                local hydratedLooks = getHydratedLooks()
                local hydratedLook = hydratedLooks and hydratedLooks[var4]
                if hydratedLook and hydratedLook.lookType then
                    lookType = hydratedLook.lookType
                else
                    lookType = nil
                end
            else
                lookType = nil
            end

            if FFlagAXDeferLookImpressionsForHydration and bool1 and lookType == nil then
                sendAXCounterV2(Constants.COUNTERS.LookImpressionMissingLookType)
            end

            local tbl3 = {
                widgetPosition = widgetRow,
                widgetId = id,
                itemPosition = itemPosition,
                itemId = var4,
                itemType = var3.type,
                lookType = lookType,
                widgetAbsPosition = (widgetRow - 1) * itemsPerRow,
                uiTreatmentType = uiTreatmentType
            }

            catalogAnalytics.widgetInteractionV2(
                Cryo.Dictionary.join(widgetAnalyticsInfo, tbl3),
                ImpressionEnums.ActionType.ITEM_IMPRESSION
            )
        end
    end, {
        id,
        content,
        widgetAnalyticsInfo,
        widgetRow,
        itemsPerRow,
        uiTreatmentType,
        var1,
        catalogAnalytics
    })
end

return useOnCatalogSortImpressionsDetectedCallback

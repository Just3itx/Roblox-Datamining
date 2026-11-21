-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local HttpService = game:GetService("HttpService")

local React = require(AvatarExperienceCatalogParent.React)
local Cryo = require(AvatarExperienceCatalogParent.Cryo)

local _AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)

local FFlagAXSduiSeeAllClickLogging = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXSduiSeeAllClickLogging

local AvatarExperienceAnalytics = require(AvatarExperienceCatalogParent.AvatarExperienceAnalytics)
local UnifiedEventLogEnums = AvatarExperienceAnalytics.UnifiedEventLogEnums
local UnifiedEventLogConstants = AvatarExperienceAnalytics.UnifiedEventLogConstants
local addUnifiedEventLogging = AvatarExperienceAnalytics.addUnifiedEventLogging

local WidgetConstants = require(AvatarExperienceCatalog.WidgetConstants)
local WidgetIxpLayerMap = require(AvatarExperienceCatalog.Utils.WidgetIxpLayerMap)
local _WidgetListInfoViewModel = require(AvatarExperienceCatalog.Components.ResultsList.WidgetListInfoViewModel)

local function useAddUnifiedLoggingToCatalogSortEffect(tbl1)
    local containerRef = tbl1.containerRef
    local widgetInfo = tbl1.widgetInfo
    local widgetAnalyticsInfo = tbl1.widgetAnalyticsInfo
    local widgetRow = tbl1.widgetRow
    local uiTreatmentType = tbl1.uiTreatmentType

    local var1 = WidgetIxpLayerMap[widgetInfo.type]

    React.useEffect(function()
        addUnifiedEventLogging(
            containerRef,
            Cryo.Dictionary.join(widgetAnalyticsInfo, {
                action = UnifiedEventLogEnums.MarketplaceUnifiedAction.WIDGET_IMPRESSION,
                gridPositionRow = widgetRow,
                gridPositionColumn = 1,
                uiTreatmentType = uiTreatmentType,
                themeId = widgetInfo.tagId
            }),
            {
                sessionTagName = UnifiedEventLogConstants.L2_SESSION_TAG_NAME
            }
        )

        local current = containerRef.current
        if var1 and current then
            current:SetAttribute(WidgetConstants.WidgetExposureMetadata.AttributeKey, var1)
        elseif current then
            current:SetAttribute(WidgetConstants.WidgetExposureMetadata.AttributeKey, nil)
        end
    end, {
        var1,
        widgetRow,
        uiTreatmentType,
        widgetInfo.tagId,
        widgetAnalyticsInfo
    })
    if not FFlagAXSduiSeeAllClickLogging then
        return
    end

    local seeAllRef = tbl1.seeAllRef

    local bool1 = tbl1.seeAllCallback ~= nil

    React.useEffect(function()
        if not bool1 or not seeAllRef or not seeAllRef.current then
            return
        end

        addUnifiedEventLogging(seeAllRef, {
            action = UnifiedEventLogEnums.MarketplaceUnifiedAction.UI_ELEMENT_CLICK,
            requestId = widgetAnalyticsInfo.requestId,
            elementName = "SEE_ALL",
            elementMetadata = HttpService:JSONEncode(
                {
                    widget_id = widgetAnalyticsInfo.widgetId,
                    widget_type = widgetAnalyticsInfo.widgetType,
                    tag_id = widgetInfo.tagId
                }
            ),
            gridPositionRow = widgetRow,
            gridPositionColumn = 1
        }, {
            sessionTagName = UnifiedEventLogConstants.L2_SESSION_TAG_NAME
        })
    end, {
        bool1,
        widgetRow,
        widgetInfo.tagId,
        widgetAnalyticsInfo
    })
end

return useAddUnifiedLoggingToCatalogSortEffect

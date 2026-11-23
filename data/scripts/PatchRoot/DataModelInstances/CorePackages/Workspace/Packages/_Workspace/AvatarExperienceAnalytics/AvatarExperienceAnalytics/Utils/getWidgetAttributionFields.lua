-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalyticsParent = script:FindFirstAncestor("AvatarExperienceAnalytics").Parent

local _AvatarExperienceCommon = require(AvatarExperienceAnalyticsParent.AvatarExperienceCommon)

local function getWidgetAttributionFields(arg1): {requestId: number, uiTreatmentType: number, widgetId: any, widgetItemIds: number, widgetType: any}?
    if arg1 == nil or arg1.widgetType == nil then
        return nil
    end
    return {
        widgetId = arg1.widgetId,
        widgetType = arg1.widgetType,
        widgetItemIds = if arg1.widgetItemIds then table.concat(arg1.widgetItemIds, ",") else nil,
        requestId = arg1.requestId,
        uiTreatmentType = arg1.uiTreatmentType
    }
end

return getWidgetAttributionFields

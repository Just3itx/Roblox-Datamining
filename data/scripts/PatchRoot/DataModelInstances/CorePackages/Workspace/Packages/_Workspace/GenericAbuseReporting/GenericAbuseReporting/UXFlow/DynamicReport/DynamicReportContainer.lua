-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T16:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GenericAbuseReporting = script:FindFirstAncestor("GenericAbuseReporting")
local GenericAbuseReportingParent = GenericAbuseReporting.Parent

local React = require(GenericAbuseReportingParent.React)
local LayerCollectorProvider = require(GenericAbuseReportingParent.UIBlox).Core.Layout.LayerCollector.LayerCollectorProvider

local AbuseReportAnalyticsProvider = require(GenericAbuseReporting.Bedui.Provider.AbuseReportAnalyticsProvider)
local AbuseReportBeduiProvider = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiProvider)
local AbuseReportFormDataProvider = require(GenericAbuseReporting.Bedui.Provider.AbuseReportFormDataProvider)
local _AbuseReportBeduiTypes = require(GenericAbuseReporting.Bedui.Provider.AbuseReportBeduiTypes)
local _AbuseSheetFlowTypes = require(GenericAbuseReporting.BeduiV2.Hooks.AbuseSheetFlow.AbuseSheetFlowTypes)
local AbuseVector = require(GenericAbuseReporting.Enums.AbuseVector)
local DynamicReport = require(GenericAbuseReporting.UXFlow.DynamicReport.DynamicReport)
local DynamicReportV2Container = require(GenericAbuseReporting.UXFlow.DynamicReportV2.DynamicReportV2Container)

local SharedFlags = require(GenericAbuseReportingParent.SharedFlags)
local FFlagAddThumbnailSelectorReport = SharedFlags.FFlagAddThumbnailSelectorReport
local FFlagEnableMomentsCommentReporting = SharedFlags.FFlagEnableMomentsCommentReporting
local FFlagEnableNewReportFlowGameTile = SharedFlags.FFlagEnableNewReportFlowGameTile
local FFlagEnableGroupAnnouncementReporting = SharedFlags.FFlagEnableGroupAnnouncementReporting
local FFlagAbuseReportAttributes = SharedFlags.FFlagAbuseReportAttributes

local function DynamicReportV2Adapter(arg1)
    local targetId = arg1.targetId
    local var1 = React.useMemo(function()
        if targetId == nil then
            return nil
        end
        assert(type(targetId) == "string", "DynamicReportV2 requires a string targetId")
        return { targetId = targetId }
    end, { targetId })

    local createElement = React.createElement
    local var2 = DynamicReportV2Container
    local tbl1 = {
        abuseVector = arg1.abuseVector,
        attributes = 0,
        analyticsTargetId = 0,
        onClose = 0,
        onSubmit = 0,
        onCustomSubmit = 0,
        clientActionHandlers = 0,
        custom = 0
    }

    if targetId == nil then
        var1 = arg1.attributes
    end

    tbl1.attributes = var1
    tbl1.analyticsTargetId = if targetId == nil then arg1.analyticsTargetId else targetId
    tbl1.onClose = arg1.onClose
    tbl1.onSubmit = arg1.onSubmit
    tbl1.onCustomSubmit = arg1.onCustomSubmit
    tbl1.clientActionHandlers = arg1.clientActionHandlers
    tbl1.custom = arg1.custom
    return createElement(var2, tbl1)
end

return React.memo(function(arg1) -- name: DynamicReportContainer
    if FFlagAbuseReportAttributes and arg1.targetId ~= nil and (arg1.attributes ~= nil or arg1.analyticsTargetId ~= nil) then
        error("targetId is mutually exclusive with attributes and analyticsTargetId")
    end

    if arg1.abuseVector == AbuseVector.UserProfile
        or arg1.abuseVector == AbuseVector.MomentsFeed
        or FFlagEnableMomentsCommentReporting and arg1.abuseVector == AbuseVector.MomentComment
        or FFlagEnableNewReportFlowGameTile and arg1.abuseVector == AbuseVector.GameTile
        or FFlagEnableGroupAnnouncementReporting and arg1.abuseVector == AbuseVector.GroupAnnouncement
    then
        if FFlagAbuseReportAttributes then
            return React.createElement(DynamicReportV2Adapter, arg1)
        end
        local tbl1 = {
            abuseVector = arg1.abuseVector,
            targetId = arg1.targetId,
            onClose = arg1.onClose,
            onSubmit = arg1.onSubmit,
            onCustomSubmit = arg1.onCustomSubmit,
            clientActionHandlers = arg1.clientActionHandlers,
            custom = arg1.custom
        }
        return React.createElement(DynamicReportV2Container, tbl1)
    end
    if FFlagAbuseReportAttributes then
        assert(arg1.targetId ~= nil, "attributes are only supported by the Dynamic Report V2 flow")
    end
    local createElement = React.createElement
    local var1 = LayerCollectorProvider
    local tbl1 = {}
    local tbl2 = { AbuseReportBeduiProvider = 0 }
    local createElement2 = React.createElement
    local var2 = AbuseReportBeduiProvider
    local tbl3 = {
        abuseVector = arg1.abuseVector
    }
    local tbl4 = {
        AbuseReportFormDataProvider = React.createElement(
            AbuseReportFormDataProvider,
            {
                custom = if FFlagAddThumbnailSelectorReport then arg1.custom else nil
            },
            {
                AbuseReportAnalyticsProvider = React.createElement(AbuseReportAnalyticsProvider, {
                    abuseVector = arg1.abuseVector
                }, {
                    DynamicReport = React.createElement(DynamicReport, {
                        abuseVector = arg1.abuseVector,
                        targetId = arg1.targetId,
                        onClose = arg1.onClose,
                        onSubmit = arg1.onSubmit,
                        custom = arg1.custom
                    })
                })
            }
        )
    }
    tbl2.AbuseReportBeduiProvider = createElement2(var2, tbl3, tbl4)
    return createElement(var1, tbl1, tbl2)
end)

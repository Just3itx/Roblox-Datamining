-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local _Types = require(AbuseReportMenu.Components.Types)
local Constants = require(AbuseReportMenu.Components.Constants)

local ReportAnythingActions = Constants.ReportAnythingActions

local function reportAnythingReducer(arg1, arg2)
    local var1 = table.clone(arg1)
    local type = arg2.type

    if type == ReportAnythingActions.ClearAll then
        return Constants.ReportAnythingInitialState
    end

    if type == ReportAnythingActions.ClearAnnotationFlowProperties then
        var1.annotationPoints = {}
        var1.attachCompleted = false
        var1.annotationPageSeen = false
        var1.annotationOptionSeen = false
        return var1
    end

    if type == ReportAnythingActions.SetScreenshotId then
        var1.screenshotId = arg2.screenshotId
        return var1
    end

    if type == ReportAnythingActions.SetScreenshotContentId then
        var1.screenshotContentId = arg2.screenshotContentId
        return var1
    end

    if type == ReportAnythingActions.SetAnnotationPoints then
        var1.annotationPoints = arg2.annotationPoints
        var1.annotationPageSeen = true
        var1.annotationOptionSeen = true
        return var1
    end

    if type == ReportAnythingActions.SetIdentificationResults then
        var1.identificationResults = arg2.identificationResults
        return var1
    end

    if type == ReportAnythingActions.CompleteAttachment then
        var1.attachCompleted = true
        return var1
    end

    if type == ReportAnythingActions.SetAnnotationCircleRadius then
        var1.annotationCircleRadius = arg2.radius
        return var1
    end

    if type ~= ReportAnythingActions.SetAnnotationAreaDimensions then
        if type == ReportAnythingActions.SetAnnotationOptionSeen then
            var1.annotationOptionSeen = true
        end

        return var1
    end

    var1.annotationAreaWidth = arg2.width
    var1.annotationAreaHeight = arg2.height
    return var1
end

return reportAnythingReducer

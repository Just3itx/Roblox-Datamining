-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")

local _Types = require(AbuseReportMenu.Components.Types)
local Constants = require(AbuseReportMenu.Components.Constants)

local TnSIXPWrapper = require(AbuseReportMenu.IXP.TnSIXPWrapper)
local AnnotationModal = require(AbuseReportMenu.ReportAnything.Components.AnnotationModal)

return {
    componentType = "button",
    getIsVisible = function(arg1)
        return TnSIXPWrapper.getReportAnythingAvatarEnabled()
            and (arg1.methodOfAbuse == Constants.AbuseMethods.Other or arg1.methodOfAbuse == Constants.AbuseMethods.Avatar)
    end,
    getIsDisabled = function(_, arg1)
        return arg1.reportAnythingState.attachCompleted
    end,
    variant = "secondary",
    getIconSrc = function(arg1): string
        return if arg1.reportAnythingState.attachCompleted then "icons/actions/accept" else "icons/controls/screenshot"
    end,
    getButtonLabel = function(arg1): string
        return if arg1.reportAnythingState.attachCompleted then "SceneCaptured" else "CaptureScene"
    end,
    onClick = function(_, _, arg1)
        arg1.analyticsDispatch({ type = Constants.AnalyticsActions.IncrementCaptureScene })
        AnnotationModal.mountAnnotationPage(
            Constants.ReportTypes.Person,
            arg1.hideReportTab,
            arg1.reportAnythingAnalytics,
            arg1.reportAnythingState,
            arg1.reportAnythingDispatch
        )
    end,
    fieldLabel = "AttachScreenshot",
    componentName = "OptionalScreenshot"
}

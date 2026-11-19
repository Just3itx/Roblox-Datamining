-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")

local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)

local Constants = require(AbuseReportMenu.Components.Constants)
local useHideForScreenshot = require(AbuseReportMenu.Hooks.useHideForScreenshot)
local useCaptureScreenshot = require(AbuseReportMenu.Hooks.useCaptureScreenshot)
local reportAnythingReducer = require(AbuseReportMenu.Reducers.reportAnythingReducer)
local TnSIXPWrapper = require(AbuseReportMenu.IXP.TnSIXPWrapper)

return function(arg1, arg2, arg3, callback)
    local reportAnythingAvatarEnabled = TnSIXPWrapper.getReportAnythingAvatarEnabled()
    local reportAnythingExperienceEnabled = TnSIXPWrapper.getReportAnythingExperienceEnabled()

    local var1, var2 = React.useReducer(reportAnythingReducer, Constants.ReportAnythingInitialState)

    if reportAnythingAvatarEnabled or reportAnythingExperienceEnabled then
        reportAnythingExperienceEnabled = var1.screenshotContentId == ""
    end
    local var3 = useCaptureScreenshot(React.useCallback(function(screenshotContentId)
        var2({ type = Constants.ReportAnythingActions.SetScreenshotContentId, screenshotContentId = screenshotContentId })
    end), React.useCallback(function(screenshotId)
        var2({ type = Constants.ReportAnythingActions.SetScreenshotId, screenshotId = screenshotId })
    end), React.useCallback(function(identificationResults)
        var2({ type = Constants.ReportAnythingActions.SetIdentificationResults, identificationResults = identificationResults })
    end))

    useHideForScreenshot(reportAnythingExperienceEnabled, arg1, arg2, arg3, var3, function()
        callback(var1, var2)
    end)

    return var1, var2
end

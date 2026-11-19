-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local _Types = require(AbuseReportMenu.Components.Types)
local CorePackages = game:GetService("CorePackages")
local Constants = require(AbuseReportMenu.Components.Constants)
local ReportTypes = Constants.ReportTypes

local EventIngestService = game:GetService("EventIngestService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local ReportAnythingAnalytics = require(AbuseReportMenu.ReportAnything.Utility.ReportAnythingAnalytics)
local EventIngest = require(CorePackages.Workspace.Packages.Analytics).AnalyticsReporters.EventIngest
local var1 = require(CorePackages.Workspace.Packages.Analytics).Analytics.new(RbxAnalyticsService)
local ReportAbuseAnalytics = require(AbuseReportMenu.Analytics.ReportAbuseAnalytics)
local collectAnalyticsParameters = require(AbuseReportMenu.Analytics.collectAnalyticsParameters)

local reportAbuseAnalytics = ReportAbuseAnalytics.new(EventIngest.new(EventIngestService), var1.Diag, ReportAbuseAnalytics.MenuContexts.NewMenu)

return function(arg1, callback: (...any) -> (...any), callback2: (...any) -> (...any), person: string)
    return function(arg2, callback3)
        if not arg1.menuEverShown then
            return
        end

        local var2 = if person == ReportTypes.Person then collectAnalyticsParameters.forPersonReport(arg1, arg2, ReportAnythingAnalytics.getAccumulatedParameters()) else collectAnalyticsParameters.forExperienceReport(arg1, arg2, ReportAnythingAnalytics.getAccumulatedParameters())
        reportAbuseAnalytics:reportInGameAbuseReportInteraction(var2)

        callback3({ type = Constants.ReportAnythingActions.ClearAnnotationFlowProperties })

        callback({ type = Constants.AnalyticsActions.Reset })
        ReportAnythingAnalytics.clear()
        callback2(nil)
        reportAbuseAnalytics:endAbuseReportSession()
    end
end

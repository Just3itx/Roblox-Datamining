-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:00:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local CorePackages = game:GetService("CorePackages")
local _Types = require(AbuseReportMenu.Components.Types)
local Constants = require(AbuseReportMenu.Components.Constants)
local Cryo = require(CorePackages.Packages.Cryo)

local AnalyticsActions = Constants.AnalyticsActions

local tbl1 = {
    typeofabuseSelection = Cryo.None,
    reasonSelection = Cryo.None
}

local function analyticsReducer(arg1, arg2)
    local var1 = table.clone(arg1)
    local type = arg2.type

    if type == AnalyticsActions.Reset then
        local menuEverShown = var1.menuEverShown
        local analyticsInitialState = Constants.AnalyticsInitialState
        analyticsInitialState.menuEverShown = menuEverShown
        return analyticsInitialState
    end

    if type == AnalyticsActions.SetMenuOpenedTimestamp then
        var1.menuEverShown = true
        var1.menuOpenedUnixTimestampMilliseconds = arg2.timestamp
        return var1
    end

    if type == AnalyticsActions.IncrementExperiencePersonChanged then
        var1.experiencePersonChangeCount += 1
        return var1
    end

    if type == AnalyticsActions.IncrementTypeofabuseChanged then
        var1.typeofabuseChangeCount += 1
        return var1
    end

    if type == AnalyticsActions.IncrementPersonChanged then
        var1.personChangeCount += 1
        return var1
    end

    if type == AnalyticsActions.IncrementReasonChanged then
        var1.reasonChangeCount += 1
        return var1
    end

    if type == AnalyticsActions.IncrementCaptureScene then
        var1.captureSceneCount += 1
        return var1
    end

    if type == AnalyticsActions.SetViewportInformation then
        var1.viewportSizeX = arg2.viewportSizeX
        var1.viewportSizeY = arg2.viewportSizeY
        var1.isPortraitMode = arg2.viewportSizeX < arg2.viewportSizeY
        return var1
    end

    if type == AnalyticsActions.SetMemoryRequirementMet then
        var1.memoryRequirementMet = arg2.memoryRequirementMet
        return var1
    end

    if type == AnalyticsActions.SetSubmissionCompleted then
        var1.isSubmissionCompleted = true
        return var1
    end

    if type == AnalyticsActions.SetTypeOfAbuseSelection then
        var1.typeofabuseSelection = arg2.selection
        return var1
    end

    if type == AnalyticsActions.SetPreselectedAbuseSelection then
        var1.preselectedAbuseSelection = arg2.selection
        return var1
    end

    if type == AnalyticsActions.SetReasonSelection then
        var1.reasonSelection = arg2.selection
        return var1
    end

    if type == AnalyticsActions.SetCommentAdded then
        var1.commentAdded = arg2.commentAdded
        return var1
    end

    if type == AnalyticsActions.SwitchToExperienceInitialSelections then
        return (Cryo.Dictionary.join(var1, tbl1, Constants.AnalyticsExpeirenceInitialSelections))
    end

    if type == AnalyticsActions.SwitchToPersonInitialSelections then
        var1 = Cryo.Dictionary.join(var1, tbl1, Constants.AnalyticsPersonInitialSelections)
    end

    return var1
end

return analyticsReducer

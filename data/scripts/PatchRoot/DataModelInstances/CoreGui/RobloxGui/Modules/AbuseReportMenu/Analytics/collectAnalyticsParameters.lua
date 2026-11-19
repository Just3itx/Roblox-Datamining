-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:41:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AbuseReportMenu = script:FindFirstAncestor("AbuseReportMenu")
local _Types = require(AbuseReportMenu.Components.Types)
local CorePackages = game:GetService("CorePackages")
local Cryo = require(CorePackages.Packages.Cryo)
local Constants = require(AbuseReportMenu.Components.Constants)
local _ReportAnythingAnalytics = require(AbuseReportMenu.ReportAnything.Utility.ReportAnythingAnalytics)
local AbuseReportBuilder = require(AbuseReportMenu.ReportAnything.Utility.AbuseReportBuilder)

local function func1(arg1, arg2, arg3)
    local num1 = math.floor(workspace:GetServerTimeNow() * 1000)
    local var1 = if arg1.menuOpenedUnixTimestampMilliseconds > 0 then math.floor(num1 - arg1.menuOpenedUnixTimestampMilliseconds) else 0
    local var2, _ = AbuseReportBuilder.interpretAnnotations(arg2)

    local tbl1 = {
        placeId = game.PlaceId,
        isPortraitMode = arg1.isPortraitMode,
        viewportSizeX = arg1.viewportSizeX,
        viewportSizeY = arg1.viewportSizeY,
        timeSpentMs = var1,
        experiencePersonChangeCount = arg1.experiencePersonChangeCount,
        typeofabuseChangeCount = arg1.typeofabuseChangeCount,
        personChangeCount = arg1.personChangeCount,
        reasonChangeCount = arg1.reasonChangeCount,
        captureSceneCount = arg1.captureSceneCount,
        reasonSelection = arg1.reasonSelection,
        commentAdded = arg1.commentAdded,
        experiencePersonSelection = arg1.experiencePersonSelection,
        annotationFinalCount = #arg2.annotationPoints,
        avatarFinalCount = #var2,
        interactionType = if arg1.isSubmissionCompleted then 1 else 2,
        typeofabuseSelection = arg1.typeofabuseSelection,
        memoryRequirementMet = arg1.memoryRequirementMet,
        preselectedAbuseSelection = arg1.preselectedAbuseSelection
    }

    return (Cryo.Dictionary.join(tbl1, arg3))
end

return {
    forPersonReport = function(arg1, arg2, arg3)
        local var1 = func1(arg1, arg2, arg3)
        local var2 = nil
        local Chat = Constants.AnalyticsAbuseMethods.Chat

        for k, value in pairs(Constants.AbuseMethodToAnalyticsMapping) do
            if k == arg1.typeofabuseSelection then
                Chat = value
                var2 = Chat
            end
        end

        var1.typeofabuseSelection = var2
        var1.inferredTypeofabuseSelection = Chat

        return var1
    end,
    forExperienceReport = function(arg1, arg2, arg3)
        local var1 = func1(arg1, arg2, arg3)

        var1.typeofabuseSelection = Constants.AnalyticsAbuseMethods.Game
        var1.inferredTypeofabuseSelection = Constants.AnalyticsAbuseMethods.Game

        return var1
    end
}

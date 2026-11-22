-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local HttpService = game:GetService("HttpService")

local SquadsParent = Squads.Parent
local AbuseReporting = require(SquadsParent.AbuseReporting)

local _ModelTypes = require(Squads.Common.ModelTypes)
local dependencies = require(Squads.dependencies)
local Logger = require(Squads.Logger)

local React = dependencies.React
local DefaultTwoStepReportFlow = AbuseReporting.UXFlows.DefaultTwoStepReportFlow
local NetworkingSquads = dependencies.NetworkingSquads
local useDispatch = dependencies.Hooks.useDispatch

local reportCategories = {
    { localizationKey = "Feature.ReportAbuse.Label.CategoryInappropriate", value = "Swearing" },
    { localizationKey = "Feature.ReportAbuse.Label.CategoryBullyingV2", value = "Bullying" },
    { localizationKey = "Feature.ReportAbuse.Label.CategoryTheft", value = "Scamming" },
    { localizationKey = "Feature.ReportAbuse.Label.CategoryDating", value = "Dating" },
    {
        localizationKey = "Feature.ReportAbuse.Label.CategoryScamming",
        value = "Cheating/Exploiting"
    },
    {
        localizationKey = "Feature.ReportAbuse.Label.CategoryPrivateInfo",
        value = "Personal Question"
    }
}

local function SquadVoiceAbuseReport(tbl2)
    local var1 = useDispatch()
    local onSubmit = React.useCallback(function(abuseReason, abuseComment)
        Logger:info(
            "Submitting abuse report. Reason: {}, Comment: {}, Data: {}",
            abuseReason,
            abuseComment,
            HttpService:JSONEncode(tbl2.reportData)
        )

        local var2, input = var1(
            NetworkingSquads.SendSquadVoiceAbuseReport.API({
                submitterUserId = tbl2.reportData.submitterUserId,
                abuserUserId = tbl2.reportData.abuserUserId,
                reportBeginTimestampMs = tbl2.reportData.reportBeginTimestampMs,
                voiceChannelId = tbl2.reportData.voiceChannelId,
                voiceUserIds = tbl2.reportData.voiceUserIds,
                voiceUserCount = tbl2.reportData.voiceUserCount,
                abuseReason = abuseReason,
                abuseComment = abuseComment
            })
        ):await()

        if var2 then
            Logger:info("Abuse report submitted successfully. Response: {}", HttpService:JSONEncode(input))
        else
            Logger:error("Failed to submit abuse report. Response: {}", HttpService:JSONEncode(input))
        end

        return var2
    end, { tbl2.reportData, var1 })

    return React.createElement(DefaultTwoStepReportFlow, {
        analyticsContext = "Squad",
        onSubmitProps = { hasNextSteps = false, onSubmit = onSubmit },
        onCloseProps = {
            hasPreviousSteps = false,
            onAbandon = tbl2.onAbandon
        },
        onComplete = tbl2.onComplete,
        reportCategories = reportCategories
    })
end

return SquadVoiceAbuseReport

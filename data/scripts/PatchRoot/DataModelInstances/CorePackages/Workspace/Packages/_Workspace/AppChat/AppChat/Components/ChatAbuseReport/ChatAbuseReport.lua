-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local DefaultTwoStepReportFlow = require(AppChatParent.AbuseReporting).UXFlows.DefaultTwoStepReportFlow

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local var1 = require(AppChat.Logger):new(script.Name)
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local Players = game:GetService("Players")

local reportCategories = {
    {
        localizationKey = "Feature.ReportAbuse.Label.CategoryInappropriate",
        value = "ABUSE_TYPE_PROFANITY"
    },
    {
        localizationKey = "Feature.ReportAbuse.Label.CategoryPrivateInfo",
        value = "ABUSE_TYPE_PRIVACY_ASKING_FOR_PII"
    },
    {
        localizationKey = "Feature.ReportAbuse.Label.CategoryBullyingV2",
        value = "ABUSE_TYPE_HARASSMENT"
    },
    {
        localizationKey = "Feature.ReportAbuse.Label.CategoryDating",
        value = "ABUSE_TYPE_DATING_AND_ROMANTIC_CONTENT"
    },
    {
        localizationKey = "Feature.ReportAbuse.Label.CategoryScamming",
        value = "ABUSE_TYPE_CHEAT_AND_EXPLOITS"
    },
    { localizationKey = "Feature.ReportAbuse.Label.CategoryTheft", value = "ABUSE_TYPE_SCAMMING" },
    {
        localizationKey = "Feature.ReportAbuse.Label.CategoryContent",
        value = "ABUSE_TYPE_SEXUAL_CONTENT"
    },
    {
        localizationKey = "Feature.ReportAbuse.Label.CategoryThreats",
        value = "ABUSE_TYPE_REAL_LIFE_THREATS"
    },
    { localizationKey = "Feature.ReportAbuse.Label.CategoryOther", value = "ABUSE_TYPE_OTHER" }
}

local function getLocalPlayerUserId(): number -- Luacid: Inlined by compiler; 1 call site recovered
    local localPlayer = Players.LocalPlayer
    return if localPlayer then localPlayer.UserId else 0
end

local function ChatAbuseReport(tbl2)
    local var2 = useDispatch()

    local onSubmit = React.useCallback(function(reportCategory, comment)
        local var3, var4 = var2(
            AppChatNetworking.rodux.SubmitAppChatAbuseReport.API({
                comment = comment,
                reportedUserId = tbl2.participantId,
                reportCategory = reportCategory,
                conversationId = tbl2.conversationId,
                submitterUserId = getLocalPlayerUserId()
            })
        ):await()

        if var3 then
            var1:info("Abuse report submitted successfully. Response: {}", tostring(var4))
        else
            var1:error("Failed to submit abuse report. Response: {}", tostring(var4))
        end

        return var3
    end, { var2, tbl2.conversationId, tbl2.participantId })

    return React.createElement(DefaultTwoStepReportFlow, {
        analyticsContext = "AppChat",
        onSubmitProps = { hasNextSteps = false, onSubmit = onSubmit },
        onCloseProps = {
            hasPreviousSteps = false,
            onAbandon = tbl2.onAbandon
        },
        onComplete = tbl2.onComplete,
        reportCategories = reportCategories
    })
end

return ChatAbuseReport

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local LocalPlayer = game:GetService("Players").LocalPlayer
local InExperienceInterventionParent = InExperienceIntervention.Parent
local EventIngestService = game:GetService("EventIngestService")
local EventIngest = require(InExperienceInterventionParent.Analytics).AnalyticsReporters.EventIngest
local Cryo = require(InExperienceInterventionParent.Cryo)

local eventIngest = EventIngest.new(EventIngestService)

local Constants = {
    InterventionTypes = {
        Nudge = "INTERVENTION_CHAT_NUDGE",
        Timeout = "INTERVENTION_CHAT_TIMEOUT",
        PartyChatNudge = "INTERVENTION_PARTY_CHAT_NUDGE",
        PartyChatTimeout = "INTERVENTION_PARTY_CHAT_TIMEOUT",
        DictationSafetyReminder = "INTERVENTION_DICTATION_SAFETY_REMINDER"
    },
    EventTypes = {
        AppealClicked = "EVENT_APPEAL_CLICKED",
        CtaClicked = "EVENT_CTA_CLICKED",
        ModalAppeared = "EVENT_MODAL_APPEARED",
        ModalMessageReceived = "EVENT_MODAL_MESSAGE_RECEIVED",
        ToastMessageReceived = "EVENT_TOAST_MESSAGE_RECEIVED",
        NudgeToastAppeared = "EVENT_NUDGE_TOAST_APPEARED",
        NudgeToastDismissed = "EVENT_NUDGE_TOAST_DISMISSED",
        ChatAttemptToastAppeared = "EVENT_CHAT_ATTEMPT_TOAST_APPEARED",
        ChatAttemptToastDismissed = "EVENT_CHAT_ATTEMPT_TOAST_DISMISSED",
        DictationSafetyReminderToastAppeared = "EVENT_DICTATION_SAFETY_REMINDER_TOAST_APPEARED",
        DictationSafetyReminderToastDismissed = "EVENT_DICTATION_SAFETY_REMINDER_TOAST_DISMISSED",
        GetModerationDetailFailed = "EVENT_GET_MODERATION_DETAIL_FAILED"
    },
    EventContext = "InExperienceInterventionEvent",
    EventName = "InExperienceInterventionEvent"
}

local UserId = if LocalPlayer then LocalPlayer.UserId else 0

local function func1(eventType, interventionType, arg1, eventId, evidence, timeoutDurationSeconds, error, acknowledgeable)
    local unixTimestampMillis = DateTime.now().UnixTimestampMillis
    local tbl2 = {
        user_id = UserId,
        timestamp_milliseconds = unixTimestampMillis,
        event_type = eventType,
        intervention_type = interventionType,
        event_id = eventId,
        evidence = evidence,
        timeout_duration_seconds = timeoutDurationSeconds,
        acknowledgeable = acknowledgeable
    }

    if eventType == Constants.EventTypes.CtaClicked
        or eventType == Constants.EventTypes.AppealClicked
        or eventType == Constants.EventTypes.NudgeToastDismissed
        or eventType == Constants.EventTypes.ChatAttemptToastDismissed
        or eventType == Constants.EventTypes.DictationSafetyReminderToastDismissed
    then
        tbl2 = Cryo.Dictionary.join({ time_to_interact_seconds = (unixTimestampMillis - arg1) / 1000 }, tbl2)
    end

    if eventType == Constants.EventTypes.GetModerationDetailFailed then
        tbl2 = Cryo.Dictionary.join({ error = error }, tbl2)
    end

    return tbl2
end

return {
    sendAnalyticsEvent = function(eventType, interventionType, arg1, eventId, evidence, timeoutDurationSeconds, error, acknowledgeable)
        eventIngest:sendEventDeferred(
            Constants.EventContext,
            Constants.EventName,
            (func1(eventType, interventionType, arg1, eventId, evidence, timeoutDurationSeconds, error, acknowledgeable))
        )
    end,
    Constants = Constants
}

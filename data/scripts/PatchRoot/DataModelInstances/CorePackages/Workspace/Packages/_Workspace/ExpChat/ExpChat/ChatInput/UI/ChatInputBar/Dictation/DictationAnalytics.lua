-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local TelemetryService = game:GetService("TelemetryService")

local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local Analytics = require(ExpChatParent.ExpChatShared).Analytics

local engineFeature = game:GetEngineFeature("RbxAnalyticsServiceExposePlaySessionId")

local Properties = {
    SttMode = "stt_mode",
    SttOutcome = "stt_outcome",
    EntryPoint = "entry_point",
    TriggerType = "trigger_type",
    Status = "status",
    Timestamp = "client_timestamp",
    PlaySessionId = "play_session_id",
    Success = "success",
    ErrorReason = "error_reason",
    LatencyMs = "latency_ms",
    CharCount = "char_count",
    FinalCharCount = "final_char_count",
    DurationSeconds = "duration_seconds",
    EditType = "edit_type",
    WasEdited = "was_edited",
    EditDistance = "edit_distance",
    TextStt = "text_stt",
    TextSent = "text_sent",
    TextSttTruncated = "text_stt_truncated",
    TextSentTruncated = "text_sent_truncated",
    DismissReason = "dismiss_reason",
    CanDeepLink = "can_deep_link"
}

local function getPlaySessionId() -- Luacid: Inlined by compiler; 1 call site recovered
    if engineFeature then
        return RbxAnalyticsService:GetPlaySessionId()
    end
    return ""
end

local Counters = {
    Started = {
        eventName = "ExpChatDictationStarted",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2026, 9, 9 },
        description = "A user initiated a dictation session from the chat input mic. customFields: mode (standard/continuous), entry_point (tap/long_press).",
        links = ""
    },
    Ended = {
        eventName = "ExpChatDictationEnded",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2026, 11, 2 },
        description = "A dictation recording session ended. Session-level only; continuous auto-chunk stops are excluded. customFields: mode, reason (user_manual/time_up/auto_pause/safety_intervention/rate_limited).",
        links = ""
    },
    VadStop = {
        eventName = "ExpChatDictationVadStop",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2026, 9, 10 },
        description = "A standard-mode dictation recording ended early because the engine VAD finalized the utterance (end-of-speech detected) rather than the user tapping stop or the timer running out. customFields: mode.",
        links = ""
    },
    Permission = {
        eventName = "ExpChatDictationPermission",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2026, 9, 9 },
        description = "Microphone permission resolved for a dictation attempt. customFields: mode, result (granted/denied/already_allowed).",
        links = ""
    },
    Transcription = {
        eventName = "ExpChatDictationTranscription",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2026, 9, 9 },
        description = "A speech-to-text transcription completed for a dictation utterance. customFields: mode, result (success/failure).",
        links = ""
    },
    SafetyReminder = {
        eventName = "ExpChatDictationSafetyReminder",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2026, 9, 30 },
        description = "A continuous-dictation message came back fully text-filtered and the once-per-session \"use kind words\" reminder was requested.",
        links = ""
    },
    MessageSent = {
        eventName = "ExpChatDictationMessageSent",
        backends = { "RobloxTelemetryCounter" },
        lastUpdated = { 2026, 9, 9 },
        description = "A chat message produced via dictation was sent. customFields: mode.",
        links = ""
    }
}

local telemetryService = TelemetryService

local function logDictationCounter(config, customFields) -- Luacid: Inlined by compiler; 7 call sites recovered
    if telemetryService then
        telemetryService:LogCounter(config, { customFields = customFields }, 1)
    end
end

return {
    Events = {
        MicClick = "dictation_mic_click",
        PermissionPrompt = "dictation_permission_prompt",
        RecordingStart = "dictation_recording_start",
        RecordingStop = "dictation_recording_stop",
        VadStop = "dictation_vad_stop",
        TranscriptionDone = "transcription_done",
        TextEdit = "text_edit",
        MessageSent = "dictation_message_sent",
        FtuxShown = "dictation_ftux_shown",
        FtuxDismiss = "dictation_ftux_dismiss",
        MicToastShown = "dictation_mic_toast_shown",
        MicToastActivated = "dictation_mic_toast_activated",
        MicToastDismiss = "dictation_mic_toast_dismiss",
        SafetyReminderTriggered = "dictation_safety_reminder_triggered"
    },
    Properties = Properties,
    Modes = { Standard = "standard", Continuous = "continuous" },
    EntryPoints = { Tap = "tap", LongPress = "long_press" },
    TriggerTypes = {
        UserManual = "user_manual",
        TimeUp = "time_up",
        AutoPause = "auto_pause",
        AutoChunk = "auto_chunk",
        SafetyIntervention = "safety_intervention",
        RateLimited = "rate_limited"
    },
    PermissionStatuses = {
        Granted = "granted",
        Denied = "denied",
        AlreadyAllowed = "already_allowed"
    },
    EditTypes = {
        Addition = "addition",
        Deletion = "deletion",
        FullClear = "full_clear",
        Mixed = "mixed"
    },
    Outcomes = { Full = "stt_full", Partial = "stt_partial" },
    DismissReasons = { Visibility = "visibility", UserInteraction = "user_interaction" },
    Counters = Counters,
    fire = function(arg1, tbl3)
        local var1 = not tbl3 and {} or table.clone(tbl3)
        var1[Properties.PlaySessionId] = getPlaySessionId()
        if var1[Properties.Timestamp] == nil then
            var1[Properties.Timestamp] = os.clock()
        end
        Analytics.FireClientAnalyticsWithEventName(arg1, var1)
    end,
    withTelemetryService = function(arg1)
        telemetryService = arg1 or TelemetryService
    end,
    reportStartedCounter = function(mode, entryPoint)
        logDictationCounter(Counters.Started, { mode = mode, entry_point = entryPoint })
    end,
    reportEndedCounter = function(mode, reason)
        logDictationCounter(Counters.Ended, { mode = mode, reason = reason })
    end,
    reportVadStopCounter = function(mode)
        logDictationCounter(Counters.VadStop, { mode = mode })
    end,
    reportPermissionCounter = function(mode, arg1)
        logDictationCounter(Counters.Permission, { mode = mode, result = arg1 })
    end,
    reportTranscriptionCounter = function(mode, bool1: boolean)
        logDictationCounter(
            Counters.Transcription,
            {
                mode = mode or "unknown",
                result = if bool1 then "success" else "failure"
            }
        )
    end,
    reportMessageSentCounter = function(mode)
        logDictationCounter(Counters.MessageSent, { mode = mode })
    end,
    reportSafetyReminderCounter = function()
        logDictationCounter(Counters.SafetyReminder, {})
    end
}

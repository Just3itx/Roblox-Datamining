-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T23:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InterventionShared = script:FindFirstAncestor("InterventionShared")
local Players = game:GetService("Players")
local InterventionSharedParent = InterventionShared.Parent
local Cryo = require(InterventionSharedParent.Cryo)
local LoggingProtocol = require(InterventionSharedParent.LoggingProtocol)
local default = LoggingProtocol.default

local Constants = {
    InterventionTypes = {
        Nudge = "INTERVENTION_CHAT_NUDGE",
        Timeout = "INTERVENTION_CHAT_TIMEOUT",
        PartyChatNudge = "INTERVENTION_PARTY_CHAT_NUDGE",
        PartyChatTimeout = "INTERVENTION_PARTY_CHAT_TIMEOUT",
        UFRNudge = "INTERVENTION_UFR_NUDGE",
        UFRTimeout = "INTERVENTION_UFR_TIMEOUT"
    },
    CounterNamespaceTypes = { PartyChat = "PartyChat" },
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
        DialogInterventionDismissSuccess = "EVENT_DIALOG_INTERVENTION_DISMISS_SUCCESS",
        DialogInterventionDismissFailed = "EVENT_DIALOG_INTERVENTION_DISMISS_FAILED",
        GetModerationDetailFailed = "EVENT_GET_MODERATION_DETAIL_FAILED"
    },
    EventContext = "InExperienceInterventionEvent",
    EventName = "InExperienceInterventionEvent"
}

local Event = {
    eventName = Constants.EventName,
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    formatCustomFields = function(tbl2)
        local eventType = tbl2.eventType
        local interventionType = tbl2.interventionType
        local renderedTimestamp = tbl2.renderedTimestamp
        local eventId = tbl2.eventId
        local evidence = tbl2.evidence
        local duration = tbl2.duration
        local acknowledgeable = tbl2.acknowledgeable
        local userId = Players and Players.LocalPlayer and Players.LocalPlayer.UserId or 0

        local unixTimestampMillis = DateTime.now().UnixTimestampMillis
        local tbl3 = {
            user_id = tostring(userId),
            timestamp_milliseconds = tostring(unixTimestampMillis),
            event_type = eventType,
            intervention_type = interventionType,
            event_id = eventId,
            evidence = evidence,
            timeout_duration_seconds = if duration == nil then nil else tostring(duration),
            placement = tbl2.placement
        }

        if acknowledgeable ~= nil then
            tbl3 = Cryo.Dictionary.join({ acknowledgeable = tostring(acknowledgeable) }, tbl3)
        end

        if tbl2.abuseVector ~= nil then
            tbl3 = Cryo.Dictionary.join({ abuse_vector = tbl2.abuseVector }, tbl3)
        end

        if eventType == Constants.EventTypes.CtaClicked
            or eventType == Constants.EventTypes.AppealClicked
            or eventType == Constants.EventTypes.NudgeToastDismissed
            or eventType == Constants.EventTypes.ChatAttemptToastDismissed
        then
            tbl3 = Cryo.Dictionary.join({ time_to_interact_seconds = tostring((unixTimestampMillis - renderedTimestamp) / 1000) }, tbl3)
        end

        if eventType == Constants.EventTypes.DialogInterventionDismissFailed
            or eventType == Constants.EventTypes.GetModerationDetailFailed
        then
            tbl3 = Cryo.Dictionary.join({ error = tbl2.error }, tbl3)
        end

        return tbl3
    end
}

local function func1(counterSuffix: string)
    return {
        counterSuffix = counterSuffix,
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        formatCustomFields = function(tbl3)
            return {
                eventType = tbl3.eventType,
                interventionType = tbl3.interventionType,
                placement = tbl3.placement
            }
        end
    }
end

return {
    sendAnalyticsEvent = function(tbl3, tbl4)
        local loggingTypes = tbl3.loggingTypes

        if loggingTypes.Event then
            local event = loggingTypes.Event
            local var1 = event.formatCustomFields(tbl4)

            default:logRobloxTelemetryEvent({
                eventName = event.eventName,
                backends = event.backends,
                throttlingPercentage = tbl3.throttlingPercentage,
                lastUpdated = tbl3.lastUpdated,
                description = tbl3.description,
                links = tbl3.links
            }, event.standardizedFields or {}, var1)
        end

        if not loggingTypes.Counter then
            return
        end

        local counter = loggingTypes.Counter
        local var1 = counter.formatCustomFields(tbl4)
        local counterNamespace = tbl4.counterNamespace or "Unknown"

        default:logRobloxTelemetryCounter({
            eventName = `Intervention.{counterNamespace}.{counter.counterSuffix}`,
            backends = counter.backends,
            throttlingPercentage = tbl3.throttlingPercentage,
            lastUpdated = tbl3.lastUpdated,
            description = tbl3.description,
            links = tbl3.links
        }, 1, var1)
    end,
    Constants = Constants,
    TelemetryConfigs = {
        MessageReceived = {
            loggingTypes = {
                Event = Event,
                Counter = func1("Message.Received")
            },
            throttlingPercentage = 10000,
            lastUpdated = { 2025, 3, 25 },
            description = "Intervention RTN message Received"
        },
        DialogRendered = {
            loggingTypes = {
                Event = Event,
                Counter = func1("Dialog.Rendered")
            },
            throttlingPercentage = 10000,
            lastUpdated = { 2025, 3, 25 },
            description = "Intervention Dialog Rendered"
        },
        DialogCtaClicked = {
            loggingTypes = {
                Event = Event,
                Counter = func1("Dialog.Button.Cta")
            },
            throttlingPercentage = 10000,
            lastUpdated = { 2025, 3, 25 },
            description = "Intervention Dialog CTA Clicked"
        },
        DialogAppealClicked = {
            loggingTypes = {
                Event = Event,
                Counter = func1("Dialog.Button.Appeal")
            },
            throttlingPercentage = 10000,
            lastUpdated = { 2025, 3, 25 },
            description = "Intervention Dialog Appeal Clicked"
        },
        DialogInterventionDismissSuccess = {
            loggingTypes = { Event = Event },
            throttlingPercentage = 10000,
            lastUpdated = { 2025, 10, 20 },
            description = "Intervention Dialog Intervention Dismiss Success"
        },
        DialogInterventionDismissFailed = {
            loggingTypes = { Event = Event },
            throttlingPercentage = 10000,
            lastUpdated = { 2025, 10, 20 },
            description = "Intervention Dialog Intervention Dismiss Failed"
        },
        GetModerationDetailFailed = {
            loggingTypes = { Event = Event },
            throttlingPercentage = 10000,
            lastUpdated = { 2026, 3, 27 },
            description = "Intervention Get Moderation Detail Failed"
        }
    }
}

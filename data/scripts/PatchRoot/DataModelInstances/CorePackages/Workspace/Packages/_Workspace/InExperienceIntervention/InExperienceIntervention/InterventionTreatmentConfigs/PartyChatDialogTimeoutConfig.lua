-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent

local AbuseVector = require(InExperienceInterventionParent.UniversalFeatureRestrictions.AbuseVector)
local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants
local InterventionAnalytics = require(InExperienceInterventionParent.InterventionShared).InterventionAnalytics
local interventionTreatmentShownSignal = require(InExperienceInterventionParent.InterventionShared).Signals.interventionTreatmentShownSignal
local partyChatTimeoutReceivedSignal = require(InExperienceInterventionParent.InterventionShared).Signals.partyChatTimeoutReceivedSignal

local showFeatureRestrictionFromRealtime = require(InExperienceInterventionParent.UniversalFeatureRestrictions.showFeatureRestrictionFromRealtime)

local FFlagAppChatReactiveFeatureRestrictions = require(InExperienceInterventionParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions
local FFlagAppChatUniversalFeatureRestriction = require(InExperienceInterventionParent.SharedFlags).FFlagAppChatUniversalFeatureRestriction

local _Types = require(InExperienceIntervention.Utils.Types)

local function onPartyChatTimeoutUFRShown()
    interventionTreatmentShownSignal:fire(Constants.TreatmentType.PartyChatTimeoutDialog)
end

local function onPartyChatTimeoutAcknowledgementSuccess()
    partyChatTimeoutReceivedSignal:fire(nil)
end

local function onPartyChatTimeoutUFRAppeal() end

return {
    configName = "PartyChatDialogNudge",
    shouldTriggerVisualTreatment = function(arg1): boolean
        return arg1.type == Constants.NotificationDialogType.ChatTimeout and arg1.abuseVector == Constants.AbuseVectorType.PartyChat
    end,
    shouldTriggerBehavioralTreatment = function(arg1): boolean
        return arg1.type == Constants.NotificationDialogType.ChatTimeout and arg1.abuseVector == Constants.AbuseVectorType.PartyChat
    end,
    shouldTriggerEventReceived = function(arg1): boolean
        return arg1.type == Constants.NotificationDialogType.ChatTimeout and arg1.abuseVector == Constants.AbuseVectorType.PartyChat
    end,
    onTriggerVisualTreatment = function(callback, detail)
        if FFlagAppChatUniversalFeatureRestriction then
            showFeatureRestrictionFromRealtime(AbuseVector.PartyChat, detail, {
                onAppeal = onPartyChatTimeoutUFRAppeal,
                onShown = onPartyChatTimeoutUFRShown,
                onAcknowledgementSuccess = if FFlagAppChatReactiveFeatureRestrictions then onPartyChatTimeoutAcknowledgementSuccess else nil
            })
            return
        end

        callback({
            type = Constants.UIStateActions.ToggleNotificationDialog,
            treatmentType = Constants.TreatmentType.PartyChatTimeoutDialog,
            isShown = true,
            endTime = DateTime.now().UnixTimestamp + detail.timeoutDurationSeconds,
            detail = detail
        })
    end,
    onTriggerBehavioralTreatment = function(arg1)
        partyChatTimeoutReceivedSignal:fire(arg1.vectorTargetId)
    end,
    onTriggerEventReceived = function(arg1)
        InterventionAnalytics.sendAnalyticsEvent(InterventionAnalytics.TelemetryConfigs.MessageReceived, {
            eventType = InterventionAnalytics.Constants.EventTypes.ModalMessageReceived,
            counterNamespace = InterventionAnalytics.Constants.CounterNamespaceTypes.PartyChat,
            interventionType = InterventionAnalytics.Constants.InterventionTypes.PartyChatTimeout,
            renderedTimestamp = DateTime.now().UnixTimestampMillis,
            eventId = arg1.decisionEventId,
            duration = arg1.timeoutDurationSeconds,
            placement = Constants.InterventionPlacementType.InExperience
        })
    end
}

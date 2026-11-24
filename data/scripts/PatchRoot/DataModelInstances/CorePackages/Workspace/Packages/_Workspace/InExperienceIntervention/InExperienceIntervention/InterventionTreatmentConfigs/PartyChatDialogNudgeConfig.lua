-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:11:08Z
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

local function onPartyChatNudgeUFRAppeal() end

local function onPartyChatNudgeUFRShown()
    interventionTreatmentShownSignal:fire(Constants.TreatmentType.PartyChatNudgeDialog)
end

local function onPartyChatNudgeAcknowledgementSuccess()
    partyChatTimeoutReceivedSignal:fire(nil)
end

return {
    configName = "PartyChatDialogNudge",
    shouldTriggerVisualTreatment = function(arg1): boolean
        return arg1.type == Constants.NotificationDialogType.ChatNudge
            and arg1.modalType == Constants.NotificationModalType.Dialog
            and arg1.abuseVector == Constants.AbuseVectorType.PartyChat
    end,
    shouldTriggerBehavioralTreatment = function(arg1)
        local bool1 = FFlagAppChatReactiveFeatureRestrictions
        return bool1
            and arg1.type == Constants.NotificationDialogType.ChatNudge
            and arg1.modalType == Constants.NotificationModalType.Dialog
            and arg1.abuseVector == Constants.AbuseVectorType.PartyChat
            and arg1.acknowledgeable == true
    end,
    shouldTriggerEventReceived = function(arg1): boolean
        return arg1.type == Constants.NotificationDialogType.ChatNudge
            and arg1.modalType == Constants.NotificationModalType.Dialog
            and arg1.abuseVector == Constants.AbuseVectorType.PartyChat
    end,
    onTriggerVisualTreatment = function(callback, detail)
        if FFlagAppChatUniversalFeatureRestriction then
            showFeatureRestrictionFromRealtime(AbuseVector.PartyChat, detail, {
                onAppeal = onPartyChatNudgeUFRAppeal,
                onShown = onPartyChatNudgeUFRShown,
                onAcknowledgementSuccess = if FFlagAppChatReactiveFeatureRestrictions then onPartyChatNudgeAcknowledgementSuccess else nil
            })
            return
        end

        callback({
            type = Constants.UIStateActions.ToggleNotificationDialog,
            treatmentType = Constants.TreatmentType.PartyChatNudgeDialog,
            isShown = true,
            detail = detail
        })
    end,
    onTriggerBehavioralTreatment = function(_)
        partyChatTimeoutReceivedSignal:fire(nil)
    end,
    onTriggerEventReceived = function(arg1)
        InterventionAnalytics.sendAnalyticsEvent(InterventionAnalytics.TelemetryConfigs.MessageReceived, {
            eventType = InterventionAnalytics.Constants.EventTypes.ModalMessageReceived,
            counterNamespace = InterventionAnalytics.Constants.CounterNamespaceTypes.PartyChat,
            interventionType = InterventionAnalytics.Constants.InterventionTypes.PartyChatNudge,
            renderedTimestamp = DateTime.now().UnixTimestampMillis,
            eventId = arg1.decisionEventId,
            duration = arg1.timeoutDurationSeconds,
            placement = Constants.InterventionPlacementType.InExperience
        })
    end
}

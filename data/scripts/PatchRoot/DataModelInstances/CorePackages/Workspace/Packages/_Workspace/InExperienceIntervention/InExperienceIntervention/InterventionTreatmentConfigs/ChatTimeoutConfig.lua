-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent

local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants

local experienceChatInterventionShownSignal = require(InExperienceInterventionParent.InterventionShared).Signals.experienceChatInterventionShownSignal

local FFlagExpChatDictationStopOnSafetyIntervention = require(InExperienceInterventionParent.SharedFlags).FFlagExpChatDictationStopOnSafetyIntervention
local _Types = require(InExperienceIntervention.Utils.Types)
local InExperienceInterventionAnalytics = require(InExperienceIntervention.InExperienceInterventionAnalytics)

return {
    configName = "ChatTimeout",
    shouldTriggerVisualTreatment = function(arg1): boolean
        return arg1.type == Constants.NotificationDialogType.ChatTimeout
            and arg1.abuseVector == Constants.AbuseVectorType.ExperienceChat
            and not arg1.acknowledgeable
    end,
    shouldTriggerBehavioralTreatment = function(arg1): boolean
        return arg1.type == Constants.NotificationDialogType.ChatTimeout
            and arg1.abuseVector == Constants.AbuseVectorType.ExperienceChat
    end,
    shouldTriggerEventReceived = function(arg1): boolean
        return arg1.type == Constants.NotificationDialogType.ChatTimeout
            and arg1.abuseVector == Constants.AbuseVectorType.ExperienceChat
    end,
    onTriggerVisualTreatment = function(callback, detail)
        callback({
            type = Constants.UIStateActions.ToggleNotificationDialog,
            treatmentType = Constants.TreatmentType.ChatTimeoutDialog,
            isShown = true,
            detail = detail
        })
        if FFlagExpChatDictationStopOnSafetyIntervention then
            experienceChatInterventionShownSignal:fire()
        end
    end,
    onTriggerBehavioralTreatment = function(_) end,
    onTriggerEventReceived = function(arg1)
        InExperienceInterventionAnalytics.sendAnalyticsEvent(
            InExperienceInterventionAnalytics.Constants.EventTypes.ModalMessageReceived,
            InExperienceInterventionAnalytics.Constants.InterventionTypes.Timeout,
            DateTime.now().UnixTimestampMillis,
            arg1.decisionEventId,
            arg1.evidence,
            arg1.timeoutDurationSeconds
        )
    end
}

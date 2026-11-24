-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent

local AbuseVector = require(InExperienceInterventionParent.UniversalFeatureRestrictions.AbuseVector)
local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants
local voiceInterventionReceivedSignal = require(InExperienceInterventionParent.InterventionShared).Signals.voiceInterventionReceivedSignal

local showFeatureRestrictionFromRealtime = require(InExperienceInterventionParent.UniversalFeatureRestrictions.showFeatureRestrictionFromRealtime)

local _Types = require(InExperienceIntervention.Utils.Types)

local function isVoiceRestriction(arg1): boolean
    return arg1.abuseVector == Constants.AbuseVectorType.Voice
        and (arg1.type == Constants.NotificationDialogType.ChatNudge or arg1.type == Constants.NotificationDialogType.ChatTimeout)
end

local function onVoiceRestrictionAppeal() end

return {
    configName = "VoiceIntervention",
    shouldTriggerVisualTreatment = isVoiceRestriction,
    shouldTriggerBehavioralTreatment = isVoiceRestriction,
    shouldTriggerEventReceived = function(_): boolean
        return false
    end,
    onTriggerVisualTreatment = function(_, arg1)
        showFeatureRestrictionFromRealtime(AbuseVector.Voice, arg1, { onAppeal = onVoiceRestrictionAppeal })
    end,
    onTriggerBehavioralTreatment = function(arg1)
        voiceInterventionReceivedSignal:fire(arg1)
    end,
    onTriggerEventReceived = function(_) end
}

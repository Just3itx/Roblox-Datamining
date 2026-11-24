-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent

local ChatToastNudgeConfig = require(InExperienceIntervention.InterventionTreatmentConfigs.ChatToastNudgeConfig)
local ChatTimeoutConfig = require(InExperienceIntervention.InterventionTreatmentConfigs.ChatTimeoutConfig)
local ChatDialogNudgeConfig = require(InExperienceIntervention.InterventionTreatmentConfigs.ChatDialogNudgeConfig)
local PartyChatDialogNudgeConfig = require(InExperienceIntervention.InterventionTreatmentConfigs.PartyChatDialogNudgeConfig)
local PartyChatDialogTimeoutConfig = require(InExperienceIntervention.InterventionTreatmentConfigs.PartyChatDialogTimeoutConfig)
local VoiceInterventionConfig = require(InExperienceIntervention.InterventionTreatmentConfigs.VoiceInterventionConfig)

local SharedFlags = require(InExperienceInterventionParent.SharedFlags)
local FFlagProactiveVoiceRestrictionsUFR = SharedFlags.FFlagProactiveVoiceRestrictionsUFR
local FFlagReactiveVoiceRestrictionsUFR = SharedFlags.FFlagReactiveVoiceRestrictionsUFR

local tbl1 = { ChatToastNudgeConfig, ChatDialogNudgeConfig, ChatTimeoutConfig }

table.insert(tbl1, PartyChatDialogNudgeConfig)
table.insert(tbl1, PartyChatDialogTimeoutConfig)

if FFlagProactiveVoiceRestrictionsUFR and FFlagReactiveVoiceRestrictionsUFR then
    table.insert(tbl1, VoiceInterventionConfig)
end

return tbl1

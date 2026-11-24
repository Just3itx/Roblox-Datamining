-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent
local React = require(InExperienceInterventionParent.React)
local Constants = require(InExperienceInterventionParent.InterventionShared).Utils.Constants
local useLocalization = require(InExperienceInterventionParent.Localization).Hooks.useLocalization
local InExperienceInterventionAnalytics = require(InExperienceIntervention.InExperienceInterventionAnalytics)
local ChatInterventionGenericToast = require(InExperienceIntervention.Components.ChatInterventionGenericToast)

function ChatNudgeToast(tbl1)
    local var1 = useLocalization(Constants.localizationKeys)

    return React.createElement(ChatInterventionGenericToast, {
        eventId = tbl1.eventId,
        violatingChatLine = tbl1.violatingChatLine,
        toastTitle = var1.ChatBreaksRulesText,
        toastBody = var1.TextChatMayBeSuspendedText,
        interventionType = InExperienceInterventionAnalytics.Constants.InterventionTypes.Nudge,
        toastAppearEventName = InExperienceInterventionAnalytics.Constants.EventTypes.NudgeToastAppeared,
        toastDismissEventName = InExperienceInterventionAnalytics.Constants.EventTypes.NudgeToastDismissed
    })
end

return ChatNudgeToast

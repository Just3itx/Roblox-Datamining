-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceIntervention = script:FindFirstAncestor("InExperienceIntervention")
local InExperienceInterventionParent = InExperienceIntervention.Parent
local React = require(InExperienceInterventionParent.React)
local Foundation = require(InExperienceInterventionParent.Foundation)
local LocalizationRoactContext = require(InExperienceInterventionParent.Localization).LocalizationRoactContext
local InExperienceInterventionAnalytics = require(InExperienceIntervention.InExperienceInterventionAnalytics)
local ChatInterventionGenericToast = require(InExperienceIntervention.Components.ChatInterventionGenericToast)

local function format(arg1, str1: string, str2: string): string -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 == nil then
        return str2
    end
    local success, result = pcall(function()
        return arg1:Format(str1)
    end)
    return if success and type(result) == "string" and result ~= "" then result else str2
end

local function DictationSafetyReminderToast()
    local var1 = React.useContext(LocalizationRoactContext)
    local var2 = Foundation.Hooks.useTokens()

    return React.createElement(ChatInterventionGenericToast, {
        toastTitle = format(
            var1,
            "Feature.InExperienceIntervention.Heading.VoiceTypingMayBeTurnedOff",
            "Voice typing may be turned off if you break the rules"
        ),
        toastBody = format(
            var1,
            "Feature.InExperienceIntervention.Description.KeepWordsKindCommunitySafe",
            "Keep your words kind and your community safe."
        ),
        interventionType = InExperienceInterventionAnalytics.Constants.InterventionTypes.DictationSafetyReminder,
        toastAppearEventName = InExperienceInterventionAnalytics.Constants.EventTypes.DictationSafetyReminderToastAppeared,
        toastDismissEventName = InExperienceInterventionAnalytics.Constants.EventTypes.DictationSafetyReminderToastDismissed,
        iconColor = var2.Color.Content.Emphasis.Color3
    })
end

return DictationSafetyReminderToast

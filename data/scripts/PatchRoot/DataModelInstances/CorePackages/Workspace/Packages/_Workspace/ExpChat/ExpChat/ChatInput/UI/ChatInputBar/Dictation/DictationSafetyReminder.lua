-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local dictationSafetyReminderSignal = require(ExpChatParent.InterventionShared.dictationSafetyReminderSignal)

local FFlagExpChatDictationGrafanaMetrics = require(ExpChat.Flags.FFlagExpChatDictationGrafanaMetrics)
local DictationAnalytics = require(script.Parent.DictationAnalytics)
return require(script.Parent.createDictationSafetyReminder)({
    onTriggered = function()
        DictationAnalytics.fire(
            DictationAnalytics.Events.SafetyReminderTriggered,
            {
                [DictationAnalytics.Properties.SttMode] = DictationAnalytics.Modes.Continuous
            }
        )

        if FFlagExpChatDictationGrafanaMetrics then
            DictationAnalytics.reportSafetyReminderCounter()
        end
        dictationSafetyReminderSignal:fire()
    end
})

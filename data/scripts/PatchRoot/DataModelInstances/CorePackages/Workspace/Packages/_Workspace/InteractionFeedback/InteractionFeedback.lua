-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local InteractionFeedbackContext = require(script.InteractionFeedbackContext)
local useTriggerFeedback = require(script.useTriggerFeedback)
local FeedbackManagerInjectionContextProvider = require(script.FeedbackManagerInjectionContextProvider)
return {
    InteractionFeedbackContext = InteractionFeedbackContext,
    useTriggerFeedback = useTriggerFeedback,
    withTriggerFeedback = require(script.withTriggerFeedback),
    FeedbackManagerInjectionContextProvider = FeedbackManagerInjectionContextProvider,
    ["jest.config"] = script["jest.config"]
}

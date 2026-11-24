-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InteractionFeedbackParent = script:FindFirstAncestor("InteractionFeedback").Parent
local FeedbackManagerInjectionContext = require(InteractionFeedbackParent.UIBlox).Core.Control.FeedbackManagerInjectionContext
local React = require(InteractionFeedbackParent.React)
local useTriggerFeedback = require(script.Parent.useTriggerFeedback)

local function FeedbackManagerInjectionContextProvider(arg1)
    local value = useTriggerFeedback()
    return React.createElement(FeedbackManagerInjectionContext.Provider, { value = value }, arg1.children)
end

return FeedbackManagerInjectionContextProvider

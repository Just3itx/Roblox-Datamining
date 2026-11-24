-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InteractionFeedbackParent = script:FindFirstAncestor("InteractionFeedback").Parent
local Cryo = require(InteractionFeedbackParent.Cryo)
local React = require(InteractionFeedbackParent.React)

local useTriggerFeedback = require(script.Parent.useTriggerFeedback)

local function withTriggerFeedback(arg1)
    return function(arg2)
        local triggerFeedback = useTriggerFeedback()

        local var2 = Cryo.Dictionary.join(arg2, { triggerFeedback = triggerFeedback })

        return React.createElement(arg1, var2)
    end
end

return withTriggerFeedback

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionAppParent = script:FindFirstAncestor("CancelSubscriptionApp").Parent
local React = require(CancelSubscriptionAppParent.React)

local CancelUserSubscriptionRequestPrompt = require(script.Parent.CancelUserSubscriptionRequestPrompt)
local useCancelUserSubscriptionRequestPromptProps = require(script.Parent.useCancelUserSubscriptionRequestPromptProps)

local function CancelUserSubscriptionRequestContainer()
    local var1 = useCancelUserSubscriptionRequestPromptProps()
    return React.createElement(CancelUserSubscriptionRequestPrompt, var1)
end

return CancelUserSubscriptionRequestContainer

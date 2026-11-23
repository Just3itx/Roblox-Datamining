-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionAppParent = script:FindFirstAncestor("CancelSubscriptionApp").Parent
local React = require(CancelSubscriptionAppParent.React)
local CancelUserSubscriptionErrorPrompt = require(script.Parent.CancelUserSubscriptionErrorPrompt)

local useCancelUserSubscriptionErrorPromptProps = require(script.Parent.useCancelUserSubscriptionErrorPromptProps)

local function CancelUserSubscriptionErrorContainer()
    local var1 = useCancelUserSubscriptionErrorPromptProps()
    return React.createElement(CancelUserSubscriptionErrorPrompt, var1)
end

return CancelUserSubscriptionErrorContainer

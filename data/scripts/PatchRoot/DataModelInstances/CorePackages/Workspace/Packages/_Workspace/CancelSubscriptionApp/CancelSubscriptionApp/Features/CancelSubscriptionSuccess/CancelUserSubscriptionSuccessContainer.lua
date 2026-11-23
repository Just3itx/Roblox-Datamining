-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T23:10:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CancelSubscriptionAppParent = script:FindFirstAncestor("CancelSubscriptionApp").Parent
local React = require(CancelSubscriptionAppParent.React)

local CancelUserSubscriptionSuccessPrompt = require(script.Parent.CancelUserSubscriptionSuccessPrompt)
local useCancelUserSubscriptionSuccessPromptProps = require(script.Parent.useCancelUserSubscriptionSuccessPromptProps)

local function CancelUserSubscriptionSuccessContainer()
    local var1 = useCancelUserSubscriptionSuccessPromptProps()
    return React.createElement(CancelUserSubscriptionSuccessPrompt, var1)
end

return CancelUserSubscriptionSuccessContainer

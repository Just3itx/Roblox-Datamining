-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chat = game:GetService("Chat")
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent

local React = require(ExpChatParent.React)
local SocialUpsellEventReceiver = require(ExpChatParent.SocialUpsell).SocialUpsellEventReceiver

local function ExpChatEventReceiver()
    local onAgeVerifiedChange = React.useCallback(function()
        if game:GetEngineFeature("ChatReconcileAccess") then
            Chat:ReconcileCommunicationAccess()
        end
    end, {})

    return React.createElement(SocialUpsellEventReceiver, { onAgeVerifiedChange = onAgeVerifiedChange })
end

return ExpChatEventReceiver

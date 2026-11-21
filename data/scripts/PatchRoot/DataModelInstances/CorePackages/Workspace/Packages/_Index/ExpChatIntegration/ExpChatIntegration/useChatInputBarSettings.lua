-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatIntegrationParent = script:FindFirstAncestor("ExpChatIntegration").Parent

local SignalsReact = require(ExpChatIntegrationParent.SignalsReact)

local useChatPlatform = require(script.Parent.useChatPlatform)

local function useChatInputBarSettings()
    local getChatInputBarSettings = useChatPlatform().getChatInputBarSettings
    return SignalsReact.useSignalState(getChatInputBarSettings)
end

return useChatInputBarSettings

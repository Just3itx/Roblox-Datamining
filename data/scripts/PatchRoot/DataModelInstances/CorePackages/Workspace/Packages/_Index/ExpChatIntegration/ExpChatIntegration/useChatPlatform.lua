-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChatIntegrationParent = script:FindFirstAncestor("ExpChatIntegration").Parent

local React = require(ExpChatIntegrationParent.React)

local ChatPlatformContext = require(script.Parent.ChatPlatformContext)

local function useChatPlatform()
    return React.useContext(ChatPlatformContext)
end

return useChatPlatform

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatIntegrationParent = script:FindFirstAncestor("ExpChatIntegration").Parent

local React = require(ExpChatIntegrationParent.React)

local _ChatPlatformTypes = require(script.Parent.ChatPlatformTypes)
local createDefaultChatPlatformValue = require(script.Parent.createDefaultChatPlatformValue)

return React.createContext(createDefaultChatPlatformValue())

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local useChatPlatform = require(script.Parent.useChatPlatform)
local _ChatPlatformContext = require(script.Parent.ChatPlatformContext)

local function useChatWindowSettings()
    return useChatPlatform().chatWindowSettings
end

return useChatWindowSettings

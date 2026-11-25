-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChannelWindowParent = script:FindFirstAncestor("TextChannelWindow").Parent
local SharedFlags = require(TextChannelWindowParent.SharedFlags)

return function()
    return SharedFlags.FFlagExpChatUseChatMuteStore
end

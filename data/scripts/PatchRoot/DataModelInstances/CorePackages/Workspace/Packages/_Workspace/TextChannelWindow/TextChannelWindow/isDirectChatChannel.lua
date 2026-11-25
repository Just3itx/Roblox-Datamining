-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SharedFlags = require(script:FindFirstAncestor("TextChannelWindow").Parent.SharedFlags)
local FFlagExpChatWhisperSetDirectChatRequester = SharedFlags.FFlagExpChatWhisperSetDirectChatRequester
local FFlagExpChatIgnoreWhisperNameForDirectChat = SharedFlags.FFlagExpChatIgnoreWhisperNameForDirectChat

local function isDirectChatChannel(arg1): boolean
    return not (FFlagExpChatWhisperSetDirectChatRequester and FFlagExpChatIgnoreWhisperNameForDirectChat
        or string.sub(arg1.Name, 1, 10) ~= "RBXWhisper")
        or arg1.DirectChatRequester ~= nil
end

return isDirectChatChannel

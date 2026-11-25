-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:30:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChat = script:FindFirstAncestor("VoiceChat")
local SetVoiceChatOptInStatus = require(VoiceChat.OptInStatus.SetVoiceChatOptInStatus)
local VoiceChatParent = VoiceChat.Parent
local Cryo = require(VoiceChatParent.Cryo)

return function(arg1, arg2)
    arg1 = arg1 or {}

    if arg2.type == SetVoiceChatOptInStatus.name then
        arg1 = Cryo.Dictionary.join(arg1, { isUserOptIn = arg2.isUserOptIn })
    end
    return arg1
end

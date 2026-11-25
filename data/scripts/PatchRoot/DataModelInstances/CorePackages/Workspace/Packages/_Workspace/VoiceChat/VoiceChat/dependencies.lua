-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:21:25Z
-- Luau bytecode version: 14 | Luau type version: 3
local VoiceChatParent = script:FindFirstAncestor("VoiceChat").Parent

return {
    SharedFlags = require(VoiceChatParent.SharedFlags),
    LinkingProtocol = require(VoiceChatParent.LinkingProtocol),
    Promise = require(VoiceChatParent.Promise),
    VoiceChatCore = require(VoiceChatParent.VoiceChatCore),
    CrossExperienceVoice = require(VoiceChatParent.CrossExperienceVoice)
}

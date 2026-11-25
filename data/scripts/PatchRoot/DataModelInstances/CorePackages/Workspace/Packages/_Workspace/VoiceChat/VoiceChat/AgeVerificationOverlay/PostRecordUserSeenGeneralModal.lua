-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatParent = script:FindFirstAncestor("VoiceChat").Parent
local Url = require(VoiceChatParent.Http).Url
local HttpService = game:GetService("HttpService")

return function(arg1, modalId: string)
    assert(type(modalId) == "string", "PostRecordUserSeenGeneralModal request expects modalId to be a string")

    local str1 = HttpService:JSONEncode({ modalId = modalId })

    return arg1(string.format("%s/v1/settings/record-user-seen-modal", Url.VOICE_URL), "POST", str1)
end

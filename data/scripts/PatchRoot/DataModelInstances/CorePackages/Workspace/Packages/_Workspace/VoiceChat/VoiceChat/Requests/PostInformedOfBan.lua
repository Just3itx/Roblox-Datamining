-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatParent = script:FindFirstAncestor("VoiceChat").Parent
local Url = require(VoiceChatParent.Http).Url
local HttpService = game:GetService("HttpService")

return function(arg1, informedOfBan: boolean)
    assert(type(informedOfBan) == "boolean", "PostInformedOfBan request expects informedOfBan to be a boolean")

    return arg1(
        string.format("%sv1/moderation/informed-of-ban", Url.VOICE_URL),
        "POST",
        (HttpService:JSONEncode({ informedOfBan = informedOfBan }))
    )
end

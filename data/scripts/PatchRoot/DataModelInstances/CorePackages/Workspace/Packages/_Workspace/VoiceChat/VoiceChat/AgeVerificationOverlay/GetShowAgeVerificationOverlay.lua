-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:21:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatParent = script:FindFirstAncestor("VoiceChat").Parent
local Url = require(VoiceChatParent.Http).Url

return function(arg1, arg2, arg3)
    assert(type(arg3) == "string", "GetShowAgeVerificationOverlay request expects placeId to be a string")
    assert(type(arg2) == "string", "GetShowAgeVerificationOverlay request expects universeId to be a string")

    local format = string.format
    local str1 = "%s/v1/settings/verify/show-age-verification-overlay/%s"
    local voiceUrl = Url.VOICE_URL
    if arg3 ~= "" and arg3 ~= nil then
        arg2 ..= "?placeId=" .. arg3
    end

    return arg1(format(str1, voiceUrl, arg2), "GET")
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatParent = script:FindFirstAncestor("VoiceChat").Parent
local HttpService = game:GetService("HttpService")
local Url = require(VoiceChatParent.Http).Url

return function(arg1, isUserOptIn: boolean, isOptedInThroughUpsell)
    assert(type(isUserOptIn) == "boolean", "UserOptIn request expects isUserOptIn to be a boolean")

    local str1 = string.format("%sv1/settings/user-opt-in/", Url.VOICE_URL)
    local var1

    if isOptedInThroughUpsell ~= nil then
        assert(type(isOptedInThroughUpsell) == "boolean", "UserOptIn request expects isOptedInThroughUpsell to be a boolean")

        var1 = HttpService:JSONEncode({ isUserOptIn = isUserOptIn, isOptedInThroughUpsell = isOptedInThroughUpsell })
    else
        var1 = HttpService:JSONEncode({ isUserOptIn = isUserOptIn })
    end

    return arg1(str1, "POST", { postBody = var1 })
end

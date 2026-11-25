-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T22:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatParent = script:FindFirstAncestor("VoiceChat").Parent
local Url = require(VoiceChatParent.Http).Url

return function(arg1)
    return arg1(string.format("%s/v1/settings/record-user-seen-upsell-modal", Url.VOICE_URL), "POST", { postBody = "{}" })
end

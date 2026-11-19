-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatCore = script:FindFirstAncestor("VoiceChatCore")
local Constants = require(VoiceChatCore.Constants)

return function(arg1, str1: string, str2: string, num1: number?)
    assert(type(str1) == "string", "GetShowPhoneVerificationUpsell request expects universeId to be a string")

    local str3 = string.format(
        "%s/v1/phone-verification/configuration?layerName=%s&experienceId=%s",
        Constants.UPSELL_CARD_URL,
        str2,
        str1
    )

    if num1 and num1 > 0 then
        str3 ..= "&sessionStartTime=" .. num1
    end

    return arg1(str3, "GET")
end

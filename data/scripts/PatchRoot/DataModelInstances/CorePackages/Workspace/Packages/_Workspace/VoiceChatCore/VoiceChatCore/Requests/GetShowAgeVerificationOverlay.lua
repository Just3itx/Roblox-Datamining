-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T17:21:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local VoiceChatCore = script:FindFirstAncestor("VoiceChatCore")
local Constants = require(VoiceChatCore.Constants)

local function createQueryParams(tbl1)
    local str1 = ""
    local num1 = 0
    for value, value2 in tbl1 do
        str1 ..= (if num1 > 0 then "&" else "") .. value .. "=" .. value2
        num1 += 1
    end
    return if num1 == 0 then "" else "?" .. str1
end

return function(arg1, str1: string, placeId: string, bool1: boolean?)
    assert(type(placeId) == "string", "GetShowAgeVerificationOverlay request expects placeId to be a string")
    assert(type(str1) == "string", "GetShowAgeVerificationOverlay request expects universeId to be a string")
    assert(
        type(bool1) == "boolean" or type(bool1) == "nil",
        "GetShowAgeVerificationOverlay request expects hasMicPermissions to be a boolean or nil"
    )

    local tbl1 = ({})
    if bool1 ~= nil then
        tbl1.userHasDisabledMicDevicePermissions = tostring(not bool1)
    end
    if placeId ~= "" and placeId ~= nil then
        tbl1.placeId = placeId
    end

    return arg1(
        string.format(
            "%s/v1/settings/verify/show-age-verification-overlay/%s%s",
            Constants.VOICE_URL,
            str1,
            (createQueryParams(tbl1))
        ),
        "GET"
    )
end

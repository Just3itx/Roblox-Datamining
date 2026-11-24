-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local GetFFlagExpChatEnableVoiceReverseNudge = require(ExpChat.Flags.GetFFlagExpChatEnableVoiceReverseNudge)

return function(arg1, num1: number, str1: string, bool1: boolean)
    if arg1 == "Connecting" then
        return "icons/controls/voice/" .. str1 .. "_0_dark"
    end

    if arg1 == "Muted" or arg1 == "LOCAL_MUTED" then
        return "icons/controls/voice/" .. str1 .. "_off_light"
    end

    if arg1 == "Inactive" or arg1 == "Connecting" then
        return "icons/controls/voice/" .. str1 .. "_0_light"
    end

    local str2

    if arg1 == "Talking" then
        local num2 = math.floor(num1 * 5 + 0.5) * 20
        str2 = "icons/controls/voice/" .. str1 .. "_" .. tostring(num2) .. "_light"

        if GetFFlagExpChatEnableVoiceReverseNudge() then
            return "icons/controls/voice/" .. (if bool1 then "red_" else "") .. str1 .. "_" .. tostring(num2) .. "_light"
        end
    else
        str2 = "icons/controls/voice/" .. str1 .. "_error_light"
    end

    return str2
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T21:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Modules = game:GetService("CoreGui").RobloxGui.Modules
local getFFlagEnableShimmeringIconLegacyChatService = require(Modules.Flags.getFFlagEnableShimmeringIconLegacyChatService)

return function(arg1, num1: number, str1: string): string
    if getFFlagEnableShimmeringIconLegacyChatService() and arg1 == "Connecting" then
        return "icons/controls/voice/" .. str1 .. "_0_dark"
    end

    if arg1 == "Muted" or arg1 == "LOCAL_MUTED" then
        return "icons/controls/voice/" .. str1 .. "_off_light"
    end

    if arg1 == "Inactive" or arg1 == "Connecting" then
        return "icons/controls/voice/" .. str1 .. "_0_light"
    end

    if arg1 ~= "Talking" then
        return "icons/controls/voice/" .. str1 .. "_error_light"
    end

    return "icons/controls/voice/" .. str1 .. "_" .. tostring(math.floor(num1 * 5 + 0.5) * 20) .. "_light"
end

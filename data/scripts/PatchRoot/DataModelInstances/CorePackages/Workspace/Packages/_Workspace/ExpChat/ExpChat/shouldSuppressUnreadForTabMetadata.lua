-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function shouldSuppressUnreadForTabMetadata(str1: string?): boolean
    return not (str1 == nil or str1 == "")
        and (string.sub(str1, 1, 18) == "Roblox.ChatEnabled"
            or string.sub(str1, 1, 14) == "Roblox.Welcome"
            or string.sub(str1, 1, 14) == "Roblox.Summary"
            or string.sub(str1, 1, 22) == "Roblox.Whisper.Welcome")
end

return shouldSuppressUnreadForTabMetadata

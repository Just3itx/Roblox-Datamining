-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isWhitespaceOnly(str1: string): boolean
    return string.find(str1, "%S") == nil
end

return isWhitespaceOnly

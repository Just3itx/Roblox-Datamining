-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T03:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function startsWith(str1: string, str2: string): boolean
    return str1:sub(1, str2:len()) == str2
end

return startsWith

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:50:42Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function endsWith(str1: string, str2: string): boolean
    return str1:sub(-str2:len()) == str2
end

return endsWith

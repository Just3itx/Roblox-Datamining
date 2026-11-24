-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T15:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getCodePointLength(str1: string): number
    if str1 == nil then
        return 0
    end

    return utf8.len(str1) or str1:len()
end

return getCodePointLength

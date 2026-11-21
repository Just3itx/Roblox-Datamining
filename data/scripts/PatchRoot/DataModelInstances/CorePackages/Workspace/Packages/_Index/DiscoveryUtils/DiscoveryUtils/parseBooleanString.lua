-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function parseBooleanString(str1: string?)
    if str1 == nil then
        return nil
    end

    return str1 == "true" or str1 == "True" or str1 == "1"
end

return parseBooleanString

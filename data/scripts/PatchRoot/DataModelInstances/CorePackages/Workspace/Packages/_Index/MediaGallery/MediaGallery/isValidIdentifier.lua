-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:51:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isValidIdentifier(str1: string?): boolean
    return not (str1 == nil or str1 == "") and str1 ~= "0"
end

return isValidIdentifier

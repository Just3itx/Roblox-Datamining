-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T07:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isFullyFilteredText(str1: string, str2: string): boolean
    return not (str2 == str1) and not (string.find(str2, "#", 1, true) == nil) and string.find(str2, "[^#%s]") == nil
end

return isFullyFilteredText

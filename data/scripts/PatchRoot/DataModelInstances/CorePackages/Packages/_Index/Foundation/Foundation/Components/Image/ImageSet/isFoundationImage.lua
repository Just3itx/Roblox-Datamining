-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isFoundationImage(str1: string?): boolean
    return not (str1 == nil or str1 == "") and str1:match("^%w+://.*$") == nil
end

return isFoundationImage

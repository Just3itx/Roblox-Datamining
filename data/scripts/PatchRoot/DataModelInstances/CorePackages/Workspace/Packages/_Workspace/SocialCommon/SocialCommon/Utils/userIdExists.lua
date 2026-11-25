-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(str1: string): boolean
    return not (str1 == nil or str1 == "") and tonumber(str1) > 0
end

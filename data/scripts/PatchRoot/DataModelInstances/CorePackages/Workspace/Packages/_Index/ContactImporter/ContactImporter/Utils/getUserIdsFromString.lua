-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T08:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(str1: string)
    return string.gmatch(str1 or "", "([^,]+)")
end

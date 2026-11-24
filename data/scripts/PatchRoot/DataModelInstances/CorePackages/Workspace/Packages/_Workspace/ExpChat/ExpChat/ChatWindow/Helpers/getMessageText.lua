-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(bool1: boolean?, str1: string?, str2: string?): string
    return if str1 == nil or str1 == "" then str2 or "" elseif bool1 then str1 or "" else str2 or ""
end

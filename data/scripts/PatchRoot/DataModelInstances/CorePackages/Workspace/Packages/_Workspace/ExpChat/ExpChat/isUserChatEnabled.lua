-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T09:01:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(str1: string): boolean
    return string.sub(str1, 1, 7) == "Enabled" or str1 == "AllUsers"
end

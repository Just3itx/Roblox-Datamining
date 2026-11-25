-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(str1: string)
    return (str1:gsub("+", " "):gsub("%%(%x%x)", function(arg1): string
        return string.char(tonumber(arg1, 16))
    end))
end

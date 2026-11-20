-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1): boolean
    local str1 = type(arg1)

    return str1 == "function" or str1 == "table" and type(arg1.render) == "function"
end

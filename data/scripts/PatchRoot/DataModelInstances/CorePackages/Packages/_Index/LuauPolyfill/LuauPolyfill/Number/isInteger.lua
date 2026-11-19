-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1): boolean
    return type(arg1) == "number" and arg1 ~= math.huge and arg1 == math.floor(arg1)
end

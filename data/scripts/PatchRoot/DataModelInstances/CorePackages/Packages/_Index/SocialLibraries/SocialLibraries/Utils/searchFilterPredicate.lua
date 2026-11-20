-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2): boolean
    return not (arg1 and arg1 ~= "") or string.find(string.lower(arg2), string.lower(arg1), 1, true) ~= nil
end

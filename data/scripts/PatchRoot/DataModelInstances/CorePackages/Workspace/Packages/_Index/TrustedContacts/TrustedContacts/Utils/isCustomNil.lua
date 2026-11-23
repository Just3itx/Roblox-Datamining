-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:10:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1): boolean
    return arg1 == nil or arg1 == "" or arg1 == -1 or typeof(arg1) == "table" and next(arg1) == nil
end

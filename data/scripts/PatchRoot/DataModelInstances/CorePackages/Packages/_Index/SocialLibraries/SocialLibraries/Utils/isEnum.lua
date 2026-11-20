-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1): boolean
    return not not (type(arg1) == "userdata" and arg1.rawValue)
end

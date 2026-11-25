-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1): boolean
    return not not (type(arg1) == "userdata" and arg1.rawValue)
end

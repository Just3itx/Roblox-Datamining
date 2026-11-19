-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:10:45Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
return function(arg1, arg2, arg3): boolean
    return not not (arg1 and arg2 and arg3 and arg3 ~= "" and arg1[arg3] and arg2[arg3] and arg1[arg3] == arg2[arg3])
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-18T23:06:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
return function(arg1, arg2): boolean
    assert(type(arg1) == "number", "throttle must be a number")
    assert(type(arg2) == "number", "userId must be a number")

    return arg2 % 100 + 1 <= arg1
end

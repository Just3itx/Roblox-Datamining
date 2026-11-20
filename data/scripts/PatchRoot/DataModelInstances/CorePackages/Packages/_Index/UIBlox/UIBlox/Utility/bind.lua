-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:40:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1, arg2)
    return function(arg3, ...)
        if arg3 == arg2 then
            return arg1(arg2, ...)
        end
        return arg1(arg2, arg3, ...)
    end
end

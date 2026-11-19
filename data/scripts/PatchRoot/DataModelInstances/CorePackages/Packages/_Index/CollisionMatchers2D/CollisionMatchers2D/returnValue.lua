-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:11:08Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
return function(pass, arg1, arg2)
    return {
        pass = pass,
        message = pass and arg1 or arg2 or arg1
    }
end

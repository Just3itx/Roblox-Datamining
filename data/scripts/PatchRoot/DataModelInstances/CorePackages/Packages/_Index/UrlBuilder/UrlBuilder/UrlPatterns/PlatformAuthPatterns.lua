-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(arg1)
    return {
        account = function(str1: string)
            return arg1.fromString("auth:v1/" .. str1 .. "/account")
        end,
        connect = function(str1: string)
            return arg1.fromString("auth:v1/" .. str1 .. "/connect")
        end,
        disconnect = function(str1: string)
            return arg1.fromString("auth:v1/" .. str1 .. "/disconnect")
        end,
        login = function(str1: string)
            return arg1.fromString("auth:v1/" .. str1 .. "/login")
        end,
        signup = function(str1: string)
            return arg1.fromString("auth:v1/" .. str1 .. "/signup")
        end
    }
end

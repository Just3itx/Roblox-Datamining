-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Types)

return function(arg1, func1: (...any) -> (...any)): (string) -> string
    return function(str1: string): string
        if arg1 then
            arg1:info(func1(str1))
        end

        return str1
    end
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:10:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Types)

return function(arg1, func1: (...any) -> (...any)): (T) -> T
    return function<T>(arg2: T): T
        if arg1 then
            arg1:info(func1(arg2))
        end

        return arg2
    end
end

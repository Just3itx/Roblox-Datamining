-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:41:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local get = nil

return {
    register = function(func1: (...any) -> (...any))
        get = func1
        return function()
            if get == func1 then
                get = nil
            end
        end
    end,
    get = function()
        return get
    end
}

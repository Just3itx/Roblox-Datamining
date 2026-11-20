-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local createSignal = require(script.Parent.createSignal)

local function createReadableSignal(arg1)
    local var1, var2 = createSignal()

    local getValue = arg1

    local function fire(arg2)
        getValue = arg2
        var2(arg2)
    end

    return {
        subscribe = function(_, func1: (...any) -> (...any))
            return var1:subscribe(func1)
        end,
        getValue = function(_)
            return getValue
        end
    }, fire
end

return createReadableSignal

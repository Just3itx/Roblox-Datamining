-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T09:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local symbols = require(script.Parent.symbols)
local Spy = require(script.Parent.Spy)

return function(arg1)
    if type(arg1) == "function" then
        local var1 = Spy.lookup(arg1)
        if var1 then
            return var1[symbols.Calls]
        end
        error("Calling getCalls on a non-spy function")
    end

    local var1 = rawget(arg1, symbols.Calls)

    if var1 == nil then
        var1 = getmetatable(arg1)[symbols.Calls]
    end

    if var1 == nil then
        error("Calling getCalls on a non-mock")
    end

    return var1
end

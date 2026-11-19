-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T11:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local prettyPrint = require(script.Parent.prettyPrint)
local module = {
    outputFunction = print
}

function module.middleware(arg1, arg2)
    return function(arg3)
        local var1 = arg1(arg3)

        module.outputFunction(
            ("Action dispatched: %s\nState changed to: %s"):format(prettyPrint(arg3), prettyPrint(arg2:getState()))
        )

        return var1
    end
end

return module

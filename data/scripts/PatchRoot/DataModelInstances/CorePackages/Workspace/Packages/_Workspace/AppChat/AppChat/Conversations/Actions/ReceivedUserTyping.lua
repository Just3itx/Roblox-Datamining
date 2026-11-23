-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local SetUserTyping = require(script.Parent.SetUserTyping)

local num1 = 0

return function(arg1, arg2)
    return function(arg3)
        spawn(function()
            num1 += 1
            local var1 = num1

            arg3:dispatch(SetUserTyping(arg1, arg2, true))

            wait(8)

            if num1 == var1 then
                arg3:dispatch(SetUserTyping(arg1, arg2, false))
            end
        end)
    end
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T16:01:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Parent.Types)

return function(arg1)
    return function<T>(arg2, arg3: T)
        local var1 = arg1[arg2]
        assert(var1, "Invalid eventName used: " .. tostring(arg2) .. " called")

        return var1, arg3
    end
end

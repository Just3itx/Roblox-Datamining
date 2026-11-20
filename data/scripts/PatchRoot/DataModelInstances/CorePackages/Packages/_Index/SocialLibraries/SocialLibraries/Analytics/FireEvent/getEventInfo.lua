-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:40:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _Types = require(script.Parent.Types)

return function(arg1)
    return function(arg2)
        local var1 = arg1[arg2]
        assert(var1, "Invalid eventName used: " .. tostring(arg2) .. " called")

        return var1
    end
end

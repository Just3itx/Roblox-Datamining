-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local function instant(arg1)
    return {
        step = function()
            return { value = arg1, complete = true }
        end,
        startingValue = arg1
    }
end

return instant

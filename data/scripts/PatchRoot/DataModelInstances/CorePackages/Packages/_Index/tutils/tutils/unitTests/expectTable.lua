-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:10:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local shallowEqual = require(script.Parent.Parent.shallowEqual)
local toString = require(script.Parent.Parent.toString)

local function expectTable(arg1)
    return {
        toEqual = function(arg2)
            assert(shallowEqual(arg1, arg2), string.format("expected: %s\ninstead got: %s", toString(arg2), toString(arg1)))
        end
    }
end

return expectTable

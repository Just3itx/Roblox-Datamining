-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:01:05Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local reduce = require(scriptParent.reduce)

local function sum(tbl1)
    return reduce(tbl1, function(num1: number, arg1): number
        return num1 + arg1
    end, 0)
end

return sum

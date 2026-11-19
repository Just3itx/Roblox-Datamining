-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T05:41:17Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local Array = require(scriptParentParentParentParent.LuauPolyfill).Array

local module = {}

function module.filterInPlace(tbl1: {nil}, func1: (...any) -> (...any), arg1): {nil}
    local num1 = 1
    Array.forEach(tbl1, function(arg2, arg3)
        if func1(arg2, arg3, tbl1) then
            tbl1[num1] = arg2
            num1 += 1
        end
    end, arg1)

    tbl1[num1] = nil
    return tbl1
end
return module

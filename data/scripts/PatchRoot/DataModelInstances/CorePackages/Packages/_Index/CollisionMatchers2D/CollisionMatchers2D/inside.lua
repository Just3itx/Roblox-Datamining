-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local toRect = require(script.Parent.toRect)
local returnValue = require(script.Parent.returnValue)

local function isPointInside(arg1, arg2): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.X >= arg2.Min.X and arg1.X <= arg2.Max.X and arg1.Y >= arg2.Min.Y and arg1.Y <= arg2.Max.Y
end

local function inside(arg1, arg2)
    local var1 = toRect(arg1)
    local var2 = toRect(arg2)
    return returnValue(
        isPointInside(var1.Min, var2) and isPointInside(var1.Max, var2),
        "Is inside the element",
        "Is not inside the element"
    )
end

return inside

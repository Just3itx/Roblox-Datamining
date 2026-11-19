-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:11:04Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local toRect = require(script.Parent.toRect)
local returnValue = require(script.Parent.returnValue)

local function intersect(arg1, arg2)
    local var1 = toRect(arg1)
    local var2 = toRect(arg2)

    local var3 = returnValue
    local var4 = var1.Min.X - var2.Min.X
    local bool1

    if math.abs(var4) * 2 < var1.Width + var2.Width then
        bool1 = math.abs(var1.Min.Y - var2.Min.Y) * 2 < var1.Height + var2.Height
    else
        bool1 = false
    end

    return var3(bool1, "Intersects the element", "Does not intersect the element")
end

return intersect

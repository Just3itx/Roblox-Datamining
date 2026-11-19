-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:10:55Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local toRect = require(script.Parent.toRect)
local returnValue = require(script.Parent.returnValue)

local function alignedVertically(arg1, arg2, verticalAlignment)
    local var1 = toRect(arg1)
    local var2 = toRect(arg2)

    if verticalAlignment == Enum.VerticalAlignment.Top then
        return returnValue(var1.Min.Y == var2.Min.Y, "", "")
    elseif verticalAlignment == Enum.VerticalAlignment.Center then
        local var3 = (var1.Min + var1.Max) / 2
        local var4 = (var2.Min + var2.Max) / 2
        return returnValue(var3.Y == var4.Y, "", "")
    elseif verticalAlignment == Enum.VerticalAlignment.Bottom then
        return returnValue(var1.Max.Y == var2.Max.Y, "", "")
    else
        return returnValue(false, "Invalid VerticalAlignment!")
    end
end
return alignedVertically

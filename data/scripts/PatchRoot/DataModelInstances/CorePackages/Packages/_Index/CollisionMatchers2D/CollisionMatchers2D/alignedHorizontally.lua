-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:10:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local toRect = require(script.Parent.toRect)
local returnValue = require(script.Parent.returnValue)

local function alignedHorizontally(arg1, arg2, horizontalAlignment)
    local var1 = toRect(arg1)
    local var2 = toRect(arg2)

    if horizontalAlignment == Enum.HorizontalAlignment.Left then
        return returnValue(var1.Min.X == var2.Min.X, "", "")
    elseif horizontalAlignment == Enum.HorizontalAlignment.Center then
        local var3 = (var1.Min + var1.Max) / 2
        local var4 = (var2.Min + var2.Max) / 2
        return returnValue(var3.X == var4.X, "", "")
    elseif horizontalAlignment == Enum.HorizontalAlignment.Right then
        return returnValue(var1.Max.X == var2.Max.X, "", "")
    else
        return returnValue(false, "Invalid horizontal alignment!")
    end
end
return alignedHorizontally

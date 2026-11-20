-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T02:50:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local toRect = require(script.Parent.toRect)
local returnValue = require(script.Parent.returnValue)

local function above(arg1, arg2, num1: number)
    local var1 = toRect(arg1)
    local var2 = toRect(arg2)

    local var3 = -(var1.Max - var2.Min)
    if not num1 then
        return returnValue(var3.Y >= 0, "Was above the element", "Was below the element")
    end

    if typeof(num1) == "number" then
        num1 = NumberRange.new(num1)
    end

    return returnValue(
        num1.Min <= var3.Y and num1.Max >= var3.Y,
        "Was within range",
        "Was not within range ( " .. tostring(num1) .. ")"
    )
end

return above

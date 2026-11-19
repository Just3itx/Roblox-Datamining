-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T06:10:56Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local toRect = require(script.Parent.toRect)
local returnValue = require(script.Parent.returnValue)

local function below(arg1, arg2, arg3)
    local var1 = toRect(arg1)
    local var2 = toRect(arg2)

    local var3 = var1.Min - var2.Max
    if not arg3 then
        return returnValue(var3.Y >= 0, "Was below the element", "Was above the element")
    end

    if typeof(arg3) == "number" then
        arg3 = NumberRange.new(arg3)
    end

    return returnValue(
        arg3.Min <= var3.Y and arg3.Max >= var3.Y,
        "Was within range",
        "Was not within range ( " .. tostring(arg3) .. ")"
    )
end

return below

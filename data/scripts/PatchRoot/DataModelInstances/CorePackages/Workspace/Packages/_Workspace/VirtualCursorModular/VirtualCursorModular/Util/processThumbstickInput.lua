-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Properties = require(scriptParentParent.Properties)

local function processThumbstickInput(vector2: Vector2): Vector2
    local x, var1

    if vector2.Magnitude >= Properties.ThumbstickDeadzone then
        local num1 = math.atan2(vector2.Y, vector2.X)
        local num2 = math.abs(math.cos(num1) * Properties.ThumbstickDeadzone)
        local num3 = math.abs(math.sin(num1) * Properties.ThumbstickDeadzone)

        x = math.max(math.abs(vector2.X) - num2, 0) / (1 - num2) * math.sign(vector2.X)
        var1 = math.max(math.abs(vector2.Y) - num3, 0) / (1 - num3) * math.sign(vector2.Y)
    else
        x = 0
        var1 = 0
    end

    return Vector2.new(x, -var1)
end

return processThumbstickInput

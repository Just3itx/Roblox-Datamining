-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.getTouchLineAngleDegrees(tbl1)
    if #tbl1 < 2 then
        return nil
    end

    local var1 = tbl1[2] - tbl1[1]
    return math.deg(math.atan2(var1.Y, var1.X))
end

function module.getTouchRotationStepDegrees(num1: number, num2: number): number
    return (num2 - num1 + 90) % 180 - 90
end

function module.touchGestureStartsOnOverlay(tbl1, vector2: Vector2, vector2_2: Vector2)
    if #tbl1 < 2 then
        return false
    end

    local var1 = (tbl1[1] + tbl1[2]) / 2

    if var1.X >= vector2.X - 64 and var1.X <= vector2.X + vector2_2.X + 64 and var1.Y >= vector2.Y - 64 then
        return var1.Y <= vector2.Y + vector2_2.Y + 64
    end

    return false
end

return module

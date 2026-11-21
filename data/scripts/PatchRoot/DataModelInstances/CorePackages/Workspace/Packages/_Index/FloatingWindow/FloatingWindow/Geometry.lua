-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:30:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.hasPositiveSize(vector2: Vector2): boolean
    return vector2.X > 0 and vector2.Y > 0
end

function module.resolveCenter(uDim2: UDim2, vector2: Vector2): Vector2
    return Vector2.new(uDim2.X.Scale * vector2.X + uDim2.X.Offset, uDim2.Y.Scale * vector2.Y + uDim2.Y.Offset)
end

local function clampAxis(num1: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    if num3 <= num2 then
        return (num2 + num3) / 2
    end
    return math.clamp(num1, num2, num3)
end

function module.clampCenter(vector2: Vector2, vector2_2: Vector2, vector2_3: Vector2): Vector2
    local var1 = vector2_3 / 2
    return Vector2.new(clampAxis(vector2.X, var1.X, vector2_2.X - var1.X), (clampAxis(vector2.Y, var1.Y, vector2_2.Y - var1.Y)))
end

return module

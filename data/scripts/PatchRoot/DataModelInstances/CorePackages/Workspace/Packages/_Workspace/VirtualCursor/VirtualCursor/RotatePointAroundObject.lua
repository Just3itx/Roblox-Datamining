-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function RotatePointAroundObject(vector2: Vector2, arg1)
    local var1 = arg1.AbsolutePosition + arg1.AbsoluteSize / 2
    return Vector2.new(
        math.cos(math.rad(arg1.AbsoluteRotation)) * (vector2 - var1).Magnitude + var1.X,
        math.sin(math.rad(arg1.AbsoluteRotation)) * (vector2 - var1).Magnitude + var1.Y
    )
end

return RotatePointAroundObject

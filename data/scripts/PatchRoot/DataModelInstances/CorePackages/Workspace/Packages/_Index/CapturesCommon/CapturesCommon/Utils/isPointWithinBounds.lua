-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isPointWithinBounds(vector2: Vector2, vector2_2: Vector2, vector2_3: Vector2): boolean
    local vector2X = vector2.X
    local vector22X = vector2_2.X
    local var1 = vector2_2.X + vector2_3.X
    return math.clamp(vector2X, vector22X, var1) == vector2.X
        and math.clamp(vector2.Y, vector2_2.Y, vector2_2.Y + vector2_3.Y) == vector2.Y
end

return isPointWithinBounds

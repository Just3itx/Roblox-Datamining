-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getScale(vector2: Vector2, vector2_2: Vector2, scaleType)
    if vector2.X == 0 or vector2.Y == 0 or vector2_2.X == 0 or vector2_2.Y == 0 then
        return 1
    end

    local var1 = vector2.X / vector2.Y
    local var2 = vector2_2.X / vector2_2.Y

    return (if scaleType == Enum.ScaleType.Fit == (var1 < var2) then vector2.X else vector2.Y * var2) / 1280
end

return getScale

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    isPointInsideBounds = function(vector2: Vector2, vector2_2: Vector2, vector2_3: Vector2): boolean
        return vector2.X >= vector2_2.X
            and vector2.X <= vector2_2.X + vector2_3.X
            and vector2.Y >= vector2_2.Y
            and vector2.Y <= vector2_2.Y + vector2_3.Y
    end,
    getInputPosition = function(arg1): Vector2
        return Vector2.new(arg1.Position.X, arg1.Position.Y)
    end,
    isPressInput = function(arg1): boolean
        return arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch
    end
}

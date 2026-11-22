-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isPointOverTrashTarget(vector2: Vector2, vector2_2: Vector2, vector2_3: Vector2, vector2_4: Vector2, num1: number): boolean
    local var1 = vector2 - vector2_2

    if var1.X >= vector2_3.X - num1 and var1.X <= vector2_3.X + vector2_4.X + num1 and var1.Y >= vector2_3.Y - num1 then
        return var1.Y <= vector2_3.Y + vector2_4.Y + num1
    end

    return false
end

return isPointOverTrashTarget

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T13:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getZoomedSizeAndOffset(vector2: Vector2, num1: number, vector2_2: Vector2?)
    local var1 = if vector2_2 then vector2_2.X else 0.5
    local var2 = if vector2_2 then vector2_2.Y else 0.5
    local x = if num1 == 0 then vector2.X else vector2.X / num1
    local y = if num1 == 0 then vector2.Y else vector2.Y / num1
    return {
        offset = Vector2.new((vector2.X - x) * var1, (vector2.Y - y) * var2),
        size = Vector2.new(x, y)
    }
end

return getZoomedSizeAndOffset

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function calculateIntersectionRatio(vector2: Vector2, vector2_2: Vector2, tbl1)
    local var1 = vector2_2.X * vector2_2.Y
    if var1 <= 0 then
        return 0
    end

    local var2 = vector2 + vector2_2

    local num1 = math.max(0, tbl1.min.X - vector2.X) + math.max(0, var2.X - tbl1.max.X)
    local num2 = math.max(0, tbl1.min.Y - vector2.Y) + math.max(0, var2.Y - tbl1.max.Y)

    local var3 = vector2_2.X - num1
    local var4 = vector2_2.Y - num2
    return if var3 <= 0 or var4 <= 0 then 0 else var3 * var4 / var1
end

return calculateIntersectionRatio

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getFitSize(vector2: Vector2, vector2_2: Vector2): UDim2
    if vector2.X == 0 or vector2.Y == 0 or vector2_2.X == 0 or vector2_2.Y == 0 then
        return UDim2.fromScale(1, 1)
    end

    local var1 = vector2.X / vector2.Y
    local var2 = vector2_2.X / vector2_2.Y

    if var1 < var2 then
        return UDim2.fromScale(1, var1 / var2)
    end
    return UDim2.fromScale(var2 / var1, 1)
end

return getFitSize

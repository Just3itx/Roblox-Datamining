-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function clampAxis(num1: number, num2: number, num3: number, num4: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    if num3 <= 0 or num4 <= 0 then
        return num1
    end

    local num5 = num2 + num4 / 2
    local num6 = num2 + num3 - num4 / 2

    if num6 < num5 then
        return num2 + num3 / 2
    end

    return math.clamp(num1, num5, num6)
end

local function clampOverlayPosition(uDim2: UDim2, vector2: Vector2, vector2_2: Vector2, vector2_3: Vector2?, vector2_4: Vector2?): UDim2 | UDim2
    if vector2.X <= 0 or vector2.Y <= 0 then
        return uDim2
    end

    local var1 = vector2_3 or Vector2.zero
    local var2 = vector2_4 or vector2
    local var3 = uDim2.X.Scale * vector2.X + uDim2.X.Offset
    local var4 = uDim2.Y.Scale * vector2.Y + uDim2.Y.Offset
    local num1 = clampAxis(var3, var1.X, var2.X, vector2_2.X)
    local num2 = clampAxis(var4, var1.Y, var2.Y, vector2_2.Y)

    return UDim2.fromScale(num1 / vector2.X, num2 / vector2.Y)
end

return clampOverlayPosition

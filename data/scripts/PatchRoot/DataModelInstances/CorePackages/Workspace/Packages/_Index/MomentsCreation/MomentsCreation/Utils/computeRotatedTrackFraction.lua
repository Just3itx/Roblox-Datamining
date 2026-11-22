-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function computeRotatedTrackFraction(vector2: Vector2, vector2_2: Vector2, num1: number, num2: number): number
    if num1 <= 0 then
        return 0
    end
    local num3 = math.rad(num2)
    local vector2_3 = Vector2.new(math.cos(num3), math.sin(num3))
    return math.clamp((vector2 - vector2_2):Dot(vector2_3) / num1 + 0.5, 0, 1)
end

return computeRotatedTrackFraction

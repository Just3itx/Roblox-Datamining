-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:51:07Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local function calculateSliderFraction(vector2: Vector2, arg1, bool1: boolean): number
    local absolutePosition = arg1.AbsolutePosition
    local absoluteSize = arg1.AbsoluteSize
    local var1 = absolutePosition + absoluteSize * 0.5
    local num1 = math.rad(arg1.AbsoluteRotation)
    local vector2_2 = if bool1 then Vector2.new(math.sin(num1), -math.cos(num1)) else Vector2.new(math.cos(num1), math.sin(num1))
    local var2 = if bool1 then absoluteSize.Y else absoluteSize.X
    return math.clamp((vector2 - var1):Dot(vector2_2) / var2 + 0.5, 0, 1)
end

return calculateSliderFraction

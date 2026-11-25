-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return function(vector2: Vector2, num1: number, arg1): boolean
    local var1 = 0.5 * arg1.AbsoluteSize
    local var2 = vector2 - (arg1.AbsolutePosition + var1)

    local magnitude = var2.Magnitude
    local num2 = math.atan2(var2.Y, var2.X) - math.rad(arg1.AbsoluteRotation)
    local var3 = magnitude * Vector2.new(math.cos(num2), math.sin(num2))

    return -var1.X <= var3.X - num1 and var1.X >= var3.X + num1 and -var1.Y <= var3.Y - num1 and var1.Y >= var3.Y + num1
end

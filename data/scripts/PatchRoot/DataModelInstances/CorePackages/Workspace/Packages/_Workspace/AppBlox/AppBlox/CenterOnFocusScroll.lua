-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T06:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
return {
    getRevealOnlyCanvasY = function(num1: number, num2: number, vector2: Vector2, num3: number, num4: number)
        local num5 = num3 + num4
        if num3 <= num1 and num1 + num2 <= num5 then
            return nil
        end
        local var1 = vector2.Y + (num1 - num3) - (num4 - num2) / 2
        return if math.abs(var1 - vector2.Y) < 1 then nil else var1
    end
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function tileVisibilityFraction(num1: number, num2: number, num3: number, num4: number, num5: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 < 1 or num4 <= 0 or num3 <= 0 then
        return 0
    end

    local num6 = (num1 - 1) * (num4 + num5)
    return math.max(0, math.min(num6 + num4, num2 + num3) - math.max(num6, num2)) / num4
end

local function verticalVisibilityFraction(num1: number, num2: number, num3: number, num4: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    if num2 <= 0 or num4 <= 0 then
        return 0
    end

    return math.max(0, math.min(num1 + num2, num3 + num4) - math.max(num1, num3)) / num2
end

return {
    MIN_VISIBLE_FRACTION = 0.7,
    tileVisibilityFraction = tileVisibilityFraction,
    verticalVisibilityFraction = verticalVisibilityFraction,
    isAtLeast70PercentVerticallyVisible = function(num1: number, num2: number, num3: number, num4: number): boolean
        return verticalVisibilityFraction(num1, num2, num3, num4) >= 0.7
    end,
    isAtLeast70PercentVisible = function(num1: number, num2: number, num3: number, num4: number, num5: number): boolean
        return tileVisibilityFraction(num1, num2, num3, num4, num5) >= 0.7
    end
}

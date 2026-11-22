-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:00:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function clamp(num1: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return math.max(num2, math.min(num3, num1))
end

local function lerp(num1: number, num2: number, num3: number): number -- Luacid: unused: defined but never referenced
    return num1 + (num2 - num1) * num3
end

local function easeOutQuint(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    return 1 - (1 - num1) ^ 5
end

local function easeOutQuad(num1: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return 1 - (1 - num1) ^ 2
end

local function easeInQuad(num1: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return num1 * num1
end

local function popScale(num1: number) -- Luacid: unused: defined but never referenced
    if num1 <= 0 then
        return 0
    end

    if num1 < 0.15 then
        return easeOutQuad(num1 / 0.15) * 1.15 + 0
    end

    if num1 < 0.35 then
        return (num1 - 0.15) / 0.19999999999999998 * -0.1499999999999999 + 1.15
    end

    return 1
end

local function fadeTransparency(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 <= 0.55 then
        return 0
    end
    return clamp(easeInQuad((num1 - 0.55) / 0.44999999999999996), 0, 1)
end

return {
    DURATION = 0.8,
    MAX_REACH = 110,
    REACH_MIN_FACTOR = 0.7,
    REACH_RANGE = 0.3,
    GRAVITY = 170,
    X_STRETCH = 1.4,
    Y_SQUASH_UP = 0.6,
    Y_STRETCH_DOWN = 1.5,
    ANGLE_JITTER = 0.5,
    SPIN_MIN = 90,
    SPIN_RANGE = 110,
    SIZE_MIN = 0.85,
    SIZE_RANGE = 0.3,
    MIN_PARTICLES = 12,
    MAX_PARTICLES = 16,
    FADE_START = 0.55,
    OVERSHOOT = 1.15,
    solveParticle = function(num1: number, tbl1)
        local num2 = clamp(num1, 0, 1)
        local var1 = tbl1.reach * easeOutQuint(num2)
        local num3 = num2 * 170 * num2
        local var2 = math.sin(tbl1.angle) * var1

        local num4 = if var2 >= 0 then 1.5 else 0.6
        return {
            x = math.cos(tbl1.angle) * var1 * 1.4,
            y = var2 * num4 + num3,
            rotation = tbl1.spin * num2,
            scale = tbl1.sizeScale * (if num2 <= 0 then 0 elseif num2 < 0.15 then easeOutQuad(num2 / 0.15) * 1.15 + 0 elseif num2 < 0.35 then (num2 - 0.15) / 0.19999999999999998 * -0.1499999999999999 + 1.15 else 1),
            transparency = fadeTransparency(num2)
        }
    end
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _types = require(script.Parent.types)

local function easeOutBounce(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 < 4 / 11 then
        return num1 * 7.5625 * num1
    end

    if num1 < 8 / 11 then
        return (num1 - 6 / 11) * 7.5625 * (num1 - 6 / 11) + 0.75
    end

    if num1 < 10 / 11 then
        return (num1 - 9 / 11) * 7.5625 * (num1 - 9 / 11) + 0.9375
    end

    return (num1 - 21 / 22) * 7.5625 * (num1 - 21 / 22) + 0.984375
end

local function evaluateBezier(num1: number, num2: number, num3: number): number -- Luacid: Inlined by compiler; 3 call sites recovered
    local num4 = 1 - num1
    local num5 = num4 * num4
    local num6 = num1 * num1

    return num5 * 3 * num1 * num2 + num4 * 3 * num6 * num3 + num1 * num6
end

local function cubicBezier(num1: number, arg1)
    assert(typeof(arg1) == "table", "Expected values to be a table")
    assert(#arg1 == 4, "Expected values to have 4 elements")

    local var1, var2, var3, var4 = table.unpack(arg1)

    assert(var1 >= 0 and var1 <= 1, "x1 must be between 0 and 1")
    assert(var3 >= 0 and var3 <= 1, "x2 must be between 0 and 1")

    if num1 <= 0 then
        return 0
    end
    if num1 >= 1 then
        return 1
    end

    local num2 = 0
    local num3 = 1

    local num4 = 0

    for _ = 1, 10 do
        num4 += 1
        local num5 = (num2 + num3) / 2
        local num6 = evaluateBezier(num5, var1, var3)

        if math.abs(num6 - num1) < 0.0001 then
            return (evaluateBezier(num5, var2, var4))
        end

        if num6 < num1 then
            num2 = num5
        else
            num3 = num5
        end
    end

    return (evaluateBezier((num2 + num3) / 2, var2, var4))
end

local tbl1 = {}

tbl1[Enum.EasingStyle.Linear] = function(num1: number, _): number -- name: linear
    return num1
end

tbl1[Enum.EasingStyle.Quad] = function(num1: number, _): number -- name: quad
    return num1 * num1
end

tbl1[Enum.EasingStyle.Cubic] = function(num1: number, _): number -- name: cubic
    return num1 * num1 * num1
end

tbl1[Enum.EasingStyle.Quart] = function(num1: number, _): number -- name: quart
    return num1 * num1 * num1 * num1
end

tbl1[Enum.EasingStyle.Quint] = function(num1: number, _): number -- name: quint
    return num1 * num1 * num1 * num1 * num1
end

tbl1[Enum.EasingStyle.Exponential] = function(num1: number, _): number -- name: exponential
    if num1 == 0 then
        return 0
    end

    return math.pow(2, (num1 - 1) * 10)
end

tbl1[Enum.EasingStyle.Sine] = function(num1: number, _): number -- name: sine
    return 1 - math.cos(num1 * math.pi / 2)
end

tbl1[Enum.EasingStyle.Back] = function(num1: number, _): number -- name: back
    return num1 * 2.70158 * num1 * num1 - num1 * 1.70158 * num1
end

tbl1[Enum.EasingStyle.Bounce] = function(num1: number, _): number -- name: bounce
    return 1 - easeOutBounce(1 - num1)
end

tbl1[Enum.EasingStyle.Elastic] = function(num1: number, _): number -- name: elastic
    if num1 == 0 then
        return 0
    elseif num1 == 1 then
        return 1
    end

    return -math.pow(2, num1 * 10 - 10) * math.sin((num1 * 10 - 10.75) * math.rad(120))
end

tbl1[Enum.EasingStyle.Circular] = function(num1: number, _): number -- name: circular
    return -(math.sqrt(1 - num1 * num1) - 1)
end

local function ease(goal: number, arg1)
    local var1 = if arg1 and arg1.duration then arg1.duration else 1
    local var2 = if arg1 and arg1.easingStyle then arg1.easingStyle else Enum.EasingStyle.Linear
    local var3 = if typeof(var2) == "EnumItem" or typeof(var2) == "string" then tbl1[var2] else cubicBezier

    return {
        step = function(arg2, num1: number)
            local var4 = if arg2.initialValue ~= nil then arg2.initialValue else arg2.value or 0
            local var5 = (arg2.elapsed or 0) + num1

            if arg2.goal and goal ~= arg2.goal then
                var4 = arg2.value
                var5 = 0
            end

            local num2 = math.min(var5 / var1, 1)
            local var6 = var3(num2, var2)

            local var7 = var4 + (goal - var4) * var6
            local complete = var1 <= var5 or var4 == goal

            if complete then
                var7 = goal

                var4 = goal
                var5 = 0
            end

            return {
                initialValue = var4,
                goal = goal,
                value = var7,
                elapsed = var5,
                complete = complete
            }
        end,
        startingValue = if arg1 then arg1.startingValue else nil
    }
end

return ease

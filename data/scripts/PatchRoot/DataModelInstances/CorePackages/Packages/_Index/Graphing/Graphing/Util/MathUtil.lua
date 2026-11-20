-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.lerp(num1: number, num2: number, num3: number): number
    return num2 * num3 + num1 * (1 - num3)
end

function module.inverseLerp(num1: number, num2: number, num3: number): number
    if num2 - num1 == 0 then
        return 0
    end

    return (num3 - num1) / (num2 - num1)
end

function module.signedPow(num1: number, num2: number): number
    return math.pow(math.abs(num1), num2) * math.sign(num1)
end

function module.log(num1: number, num2: number): number
    if num1 == 10 then
        return math.log10(num2)
    end

    return math.log(num2) / math.log(num1)
end

function module.roundToNearest(num1: number, num2: number): number
    return math.round(num1 / num2) * num2
end

return module

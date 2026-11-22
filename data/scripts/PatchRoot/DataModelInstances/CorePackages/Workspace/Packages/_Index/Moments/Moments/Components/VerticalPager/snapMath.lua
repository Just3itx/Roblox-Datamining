-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.advanceCriticalDampedSpring(num1: number, num2: number, num3: number, num4: number, num5: number): (number, number)
    local num6 = math.pi * 2 * num5
    local num7 = num1 - num3
    local num8 = num6 * num4
    local num9 = math.exp(-num8)
    local num10 = num2 + num6 * num7

    local num11 = (num7 + num10 * num4) * num9
    local num12 = (num2 - num10 * num8) * num9

    return num3 + num11, num12
end

function module.offsetForIndex(num1: number, num2: number): number
    return (num1 - 1) * num2
end

function module.clampIndex(num1: number, num2: number): number
    if num2 <= 0 then
        return 1
    end
    return math.clamp(num1, 1, num2)
end

function module.projectSnapOffset(num1: number, num2: number, num3: number): number
    return num1 - num2 * num3
end

function module.resolveSnapIndex(num1: number, num2: number, num3: number, num4: number, num5: number)
    if num4 <= 0 or num3 <= 0 then
        return 1
    end

    local num6 = num1 / num3
    local var1 = module.projectSnapOffset(num1, num2, num5) - num1
    local num7 = num3 * 0.5
    local num8 = if num7 < var1 then math.floor(num6) + 2 elseif var1 < -num7 then math.ceil(num6) else math.round(num6) + 1
    return module.clampIndex(num8, num4)
end

function module.getVisibleWindow(num1: number, num2: number, num3: number)
    if num3 <= 0 then
        return { startIndex = 1, endIndex = 0 }
    end

    local var1 = module.clampIndex(num1, num3)
    return {
        startIndex = math.max(1, var1 - num2),
        endIndex = math.min(num3, var1 + num2)
    }
end

function module.reindexAfterRemoval(num1: number, num2: number, num3: number)
    if num3 <= 0 then
        return 1
    elseif num2 < num1 then
        return module.clampIndex(num1 - 1, num3)
    end
    return module.clampIndex(num1, num3)
end

function module.neighborForRemoval(num1: number, num2: number): number
    return if num1 < num2 then num1 + 1 else num1 - 1
end

function module.nearestIndexForOffset(num1: number, num2: number, num3: number)
    if num3 <= 0 then
        return 1
    end
    if num2 <= 0 then
        return 1
    end
    return module.clampIndex(math.round(num1 / num2) + 1, num3)
end

function module.resolveSettleIndex(num1: number, num2: number, num3: number, num4: number, num5: number, num6: number?)
    if num4 <= 0 or num3 <= 0 then
        return module.clampIndex(num1, num4)
    end

    local var1 = (num2 - module.offsetForIndex(num1, num3)) / num3

    if num5 < var1 then
        local num7 = math.max(1, math.round(var1))
        if num6 ~= nil then
            num7 = math.min(num7, num6)
        end
        num1 += num7
    elseif var1 < -num5 then
        local num7 = math.min(-1, math.round(var1))
        if num6 ~= nil then
            num7 = math.max(num7, -num6)
        end
        num1 += num7
    end

    return module.clampIndex(num1, num4)
end

return module

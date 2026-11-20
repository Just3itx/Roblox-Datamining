-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:30:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local assign = require(script.Parent.assign)

local abs = math.abs
local exp = math.exp
local sin = math.sin
local cos = math.cos
local sqrt = math.sqrt

local function step(arg1, arg2, arg3)
    local __dampingRatio = arg1.__dampingRatio
    local var1 = arg1.__frequency * 2 * math.pi
    local __goalPosition = arg1.__goalPosition
    local __restingVelocityLimit = arg1.__restingVelocityLimit
    local __restingPositionLimit = arg1.__restingPositionLimit

    local value = arg2.value
    local velocity = arg2.velocity or 0

    local var2 = value - __goalPosition
    local var3 = exp(-arg3 * __dampingRatio * var1)
    local __goalPosition2, var4

    if __dampingRatio == 1 then
        __goalPosition2 = (velocity * arg3 + var2 * (var1 * arg3 + 1)) * var3 + __goalPosition
        var4 = (velocity - var1 * arg3 * (var2 * var1 + velocity)) * var3
    elseif __dampingRatio < 1 then
        local var5 = sqrt(1 - __dampingRatio * __dampingRatio)

        local var6 = cos(var1 * var5 * arg3)
        local var7 = sin(var1 * var5 * arg3)
        local var8

        if var5 > 0.0001 then
            var8 = var7 / var5
        else
            local var9 = arg3 * var1
            var8 = var9 + (var9 * var9 * (var5 * var5) * (var5 * var5) / 20 - var5 * var5) * (var9 * var9 * var9) / 6
        end

        local var9

        if var1 * var5 > 0.0001 then
            var9 = var7 / (var1 * var5)
        else
            local var10 = var1 * var5
            var9 = arg3 + (arg3 * arg3 * (var10 * var10) * (var10 * var10) / 20 - var10 * var10) * (arg3 * arg3 * arg3) / 6
        end

        __goalPosition2 = (var2 * (var6 + __dampingRatio * var8) + velocity * var9) * var3 + __goalPosition
        var4 = (velocity * (var6 - var8 * __dampingRatio) - var2 * (var8 * var1)) * var3
    else
        local var5 = sqrt(__dampingRatio * __dampingRatio - 1)

        local var6 = -var1 * (__dampingRatio - var5)
        local var7 = -var1 * (__dampingRatio + var5)

        local var8 = (velocity - var6 * var2) / (2 * var1 * var5)
        local var9 = (var2 - var8) * exp(var6 * arg3)
        local var10 = var8 * exp(var7 * arg3)

        __goalPosition2 = var9 + var10 + __goalPosition
        var4 = var6 * var9 + var7 * var10
    end

    local var5 = abs(__goalPosition2 - arg1.__goalPosition)
    local complete = abs(var4) < __restingVelocityLimit and var5 < __restingPositionLimit

    if complete then
        __goalPosition2 = arg1.__goalPosition
        var4 = 0
    end

    return { value = __goalPosition2, velocity = var4, complete = complete }
end

local function spring(num1: number, arg1)
    assert(typeof(num1) == "number")

    local tbl1 = {
        dampingRatio = 1,
        frequency = 1,
        restingVelocityLimit = 0.001,
        restingPositionLimit = 0.01
    }

    if arg1 ~= nil then
        assert(typeof(arg1) == "table")
        assign(tbl1, arg1)
    end

    local dampingRatio = tbl1.dampingRatio
    local frequency = tbl1.frequency
    local restingVelocityLimit = tbl1.restingVelocityLimit
    local restingPositionLimit = tbl1.restingPositionLimit

    assert(typeof(dampingRatio) == "number")
    assert(typeof(frequency) == "number")
    assert(typeof(restingVelocityLimit) == "number")
    assert(typeof(restingPositionLimit) == "number")

    assert(restingVelocityLimit >= 0, "Expected restingVelocityLimit >= 0")
    assert(restingPositionLimit >= 0, "Expected restingPositionLimit >= 0")

    return {
        __dampingRatio = dampingRatio,
        __frequency = frequency,
        __restingVelocityLimit = restingVelocityLimit,
        __restingPositionLimit = restingPositionLimit,
        __goalPosition = num1,
        step = step
    }
end
return spring

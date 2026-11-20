-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local assign = require(scriptParentParent.Collections).Object.assign

local _types = require(script.Parent.types)

local abs = math.abs
local exp = math.exp
local sin = math.sin
local cos = math.cos
local sqrt = math.sqrt

local function translateParameters(damping: number, stiffness: number, mass: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return damping / (sqrt(mass * stiffness) * 2), sqrt(stiffness / mass) / 2 / math.pi
end

local function spring(num1: number, arg1)
    local tbl1 = {
        dampingRatio = 1,
        frequency = 1,
        restingVelocityLimit = 0.001,
        restingPositionLimit = 0.01
    }

    if arg1 ~= nil then
        assign(tbl1, arg1)
    end

    local restingVelocityLimit = tbl1.restingVelocityLimit
    local restingPositionLimit = tbl1.restingPositionLimit

    local damping = tbl1.damping
    local stiffness = tbl1.stiffness
    local mass = tbl1.mass
    local dampingRatio, frequency

    if typeof(damping) == "number" and typeof(stiffness) == "number" and typeof(mass) == "number" then
        dampingRatio, frequency = translateParameters(damping, stiffness, mass)
    else
        dampingRatio = tbl1.dampingRatio
        frequency = tbl1.frequency
    end

    local var1 = frequency * 2 * math.pi

    assert(restingVelocityLimit >= 0, "Expected restingVelocityLimit >= 0")
    assert(restingPositionLimit >= 0, "Expected restingPositionLimit >= 0")

    return {
        step = function(arg2, num2: number)
            local value = arg2.value
            local velocity = arg2.velocity or 0

            local var2 = value - num1
            local var3 = exp(-num2 * dampingRatio * var1)
            local var4, var5

            if dampingRatio == 1 then
                var4 = (velocity * num2 + var2 * (var1 * num2 + 1)) * var3 + num1
                var5 = (velocity - var1 * num2 * (var2 * var1 + velocity)) * var3
            elseif dampingRatio < 1 then
                local var6 = sqrt(1 - dampingRatio * dampingRatio)

                local var7 = cos(var1 * var6 * num2)
                local var8 = sin(var1 * var6 * num2)
                local var9

                if var6 > 0.0001 then
                    var9 = var8 / var6
                else
                    local var10 = num2 * var1
                    var9 = var10 + (var10 * var10 * (var6 * var6) * (var6 * var6) / 20 - var6 * var6) * (var10 * var10 * var10) / 6
                end

                local var10

                if var1 * var6 > 0.0001 then
                    var10 = var8 / (var1 * var6)
                else
                    local var11 = var1 * var6
                    var10 = num2 + (num2 * num2 * (var11 * var11) * (var11 * var11) / 20 - var11 * var11) * (num2 * num2 * num2) / 6
                end

                var4 = (var2 * (var7 + dampingRatio * var9) + velocity * var10) * var3 + num1
                var5 = (velocity * (var7 - var9 * dampingRatio) - var2 * (var9 * var1)) * var3
            else
                local var6 = sqrt(dampingRatio * dampingRatio - 1)

                local var7 = -var1 * (dampingRatio - var6)
                local var8 = -var1 * (dampingRatio + var6)

                local var9 = (velocity - var7 * var2) / (2 * var1 * var6)
                local var10 = (var2 - var9) * exp(var7 * num2)
                local var11 = var9 * exp(var8 * num2)

                var4 = var10 + var11 + num1
                var5 = var7 * var10 + var8 * var11
            end

            local var6 = abs(var4 - num1)
            local complete = abs(var5) < restingVelocityLimit and var6 < restingPositionLimit

            if complete then
                var4 = num1
                var5 = 0
            end

            return { value = var4, velocity = var5, complete = complete }
        end,
        startingValue = if arg1 then arg1.startingValue else nil
    }
end

return spring

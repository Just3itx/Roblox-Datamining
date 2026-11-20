-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T20:30:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local defaults = table.freeze({ jumpDistance = math.huge, frequency = 2.5, approachDistance = 1, landingDistance = 1 })

local tbl1 = { defaults = defaults }

function tbl1.isAtRest(num1: number, num2: number, num3: number): boolean
    return math.abs(num2 - num1) < 0.5 and math.abs(num3) < 10
end

local function isFar(jumpDistance: number, num1: number, num2: number): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return math.abs(num1) > jumpDistance * num2
end

local function assertPositive(num1: number?, str1: string, str2: string, bool1: boolean?) -- Luacid: unused: defined but never referenced
    assert(
        num1 == nil or type(num1) == "number" and num1 > 0 and (bool1 or num1 < math.huge),
        `{str2}: {str1} must be a positive number`
    )
end

local function assertNonNegative(num1: number?, str1: string, str2: string) -- Luacid: unused: defined but never referenced
    assert(
        num1 == nil or type(num1) == "number" and num1 >= 0 and num1 < math.huge,
        `{str2}: {str1} must be a finite non-negative number`
    )
end

function tbl1.validate(tbl2, str1: string)
    if tbl2 == nil then
        return
    end
    local jumpDistance = tbl2.jumpDistance
    assert(
        jumpDistance == nil or type(jumpDistance) == "number" and jumpDistance > 0,
        `{str1}: jumpDistance must be a positive number`
    )

    local frequency = tbl2.frequency
    assert(
        frequency == nil or type(frequency) == "number" and frequency > 0 and frequency < math.huge,
        `{str1}: frequency must be a positive number`
    )

    local cruiseSpeed = tbl2.cruiseSpeed
    assert(
        cruiseSpeed == nil or type(cruiseSpeed) == "number" and cruiseSpeed > 0 and cruiseSpeed < math.huge,
        `{str1}: cruiseSpeed must be a positive number`
    )

    local approachDistance = tbl2.approachDistance
    assert(
        approachDistance == nil
            or type(approachDistance) == "number" and approachDistance >= 0 and approachDistance < math.huge,
        `{str1}: approachDistance must be a finite non-negative number`
    )

    local landingDistance = tbl2.landingDistance
    assert(
        landingDistance == nil or type(landingDistance) == "number" and landingDistance >= 0 and landingDistance < math.huge,
        `{str1}: landingDistance must be a finite non-negative number`
    )
end

function tbl1.resolve(tbl2, tbl3)
    local tbl4 = tbl2 or {}
    local tbl5 = tbl3 or {}
    local frequency = tbl4.frequency or tbl5.frequency or 2.5
    return (table.freeze({
        jumpDistance = tbl4.jumpDistance or tbl5.jumpDistance or defaults.jumpDistance,
        frequency = frequency,
        approachDistance = tbl4.approachDistance or tbl5.approachDistance or defaults.approachDistance,
        cruiseSpeed = tbl4.cruiseSpeed or tbl5.cruiseSpeed or math.pi * 2 * frequency,
        landingDistance = tbl4.landingDistance or tbl5.landingDistance or defaults.landingDistance
    }))
end

function tbl1.start(num1: number, num2: number, num3: number, velocity: number, profile)
    return {
        phase = if isFar(profile.jumpDistance, num2 - num1, num3) then "approach" else "land",
        velocity = velocity,
        approached = 0,
        profile = profile,
        angularFrequency = math.pi * 2 * profile.frequency
    }
end

local function land(tbl2, num1: number, num2: number, num3: number) -- Luacid: Inlined by compiler; 1 call site recovered
    local angularFrequency = tbl2.angularFrequency
    local num4 = num1 - num2
    local velocity = tbl2.velocity
    local var2 = velocity + angularFrequency * num4
    local num5 = math.exp(-angularFrequency * num3)
    tbl2.velocity = (velocity - angularFrequency * var2 * num3) * num5
    return num2 + (num4 + var2 * num3) * num5
end

local function approach(tbl2, num1: number, num2: number, num3: number, num4: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    local angularFrequency = tbl2.angularFrequency
    local var2 = num2 * tbl2.profile.cruiseSpeed * num3
    local velocity = tbl2.velocity
    local num5 = math.exp(angularFrequency * -2 * num4)
    tbl2.velocity = var2 + (velocity - var2) * num5
    local var3 = var2 * num4 + (velocity - var2) * (1 - num5) / (angularFrequency * 2)
    tbl2.approached += math.abs(var3)
    return num1 + var3
end

function tbl1.step(tbl2, num1: number, num2: number, num3: number, num4: number)
    assert(num4 >= 0 and num4 < math.huge, "ScrollMotion: dt must be a finite non-negative number")
    local num5 = num2 - num1
    local profile = tbl2.profile
    if tbl2.phase == "approach" then
        if not isFar(profile.jumpDistance, num5, num3) then
            tbl2.phase = "land"
        else
            if not (tbl2.approached >= profile.approachDistance * num3) then
                return approach(tbl2, num1, math.sign(num5), num3, num4), false
            end

            num1 = num2 - math.sign(num5) * math.min(math.abs(num5), math.max(profile.landingDistance * num3, math.abs(tbl2.velocity) / tbl2.angularFrequency))
            tbl2.phase = "land"
        end
    end

    local var2 = land(tbl2, num1, num2, num4)

    if not tbl1.isAtRest(var2, num2, tbl2.velocity) then
        return var2, false
    end

    tbl2.velocity = 0
    return num2, true
end

return table.freeze(tbl1)

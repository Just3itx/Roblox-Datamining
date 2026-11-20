-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function wrap01(num1: number): number -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 < 0 then
        return 0
    end

    if num1 > 1 then
        return num1 - math.floor(num1)
    end

    return num1
end

local function catmull(num1: number, num2: number, num3: number, num4: number, num5: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    local num6 = num5 * num5
    local num7 = num6 * num5
    return (num2 * 2 + (-num1 + num3) * num5 + (num1 * 2 - num2 * 5 + num3 * 4 - num4) * num6 + (-num1 + num2 * 3 - num3 * 3 + num4) * num7) * 0.5
end

local function wrappedKey<T>(tbl1, num1: number): T -- Luacid: Inlined by compiler; 2 call sites recovered
    local num2 = #tbl1
    return tbl1[(num1 - 1) % num2 + 1]
end

local function sampleSegment(tbl1, num1: number, num2: number, num3: number): (number, number)
    local num4 = #tbl1
    local var1 = if num4 >= 3 then wrappedKey(tbl1, num1 - 1) else tbl1[num1]
    local var2 = tbl1[num1]
    local var3 = tbl1[num2]
    local var4 = if num4 >= 3 then wrappedKey(tbl1, num2 + 1) else tbl1[num2]
    return catmull(var1.yawDegrees, var2.yawDegrees, var3.yawDegrees, var4.yawDegrees, num3), (catmull(var1.pitchDegrees, var2.pitchDegrees, var3.pitchDegrees, var4.pitchDegrees, num3))
end

local function sampleKeys(tbl1, num1: number)
    if #tbl1 == 0 then
        return 0, 0
    elseif #tbl1 == 1 then
        return tbl1[1].yawDegrees, tbl1[1].pitchDegrees
    else
        local num2 = wrap01(num1)
        local var1 = tbl1[1]
        local var2 = tbl1[#tbl1]
        if num2 <= var1.alpha then
            return var1.yawDegrees, var1.pitchDegrees
        elseif var2.alpha <= num2 then
            local var3 = 1 - var2.alpha
            if var3 <= 0 then
                return var2.yawDegrees, var2.pitchDegrees
            end
            return sampleSegment(tbl1, #tbl1, 1, (num2 - var2.alpha) / var3)
        else
            for i = 1, #tbl1 - 1 do
                local var3 = tbl1[i]
                local var4 = tbl1[i + 1]
                if num2 <= var4.alpha then
                    local var5 = var4.alpha - var3.alpha
                    local var6 = if var5 > 0 then (num2 - var3.alpha) / var5 else 0
                    return sampleSegment(tbl1, i, i + 1, var6)
                end
            end
            return var2.yawDegrees, var2.pitchDegrees
        end
    end
end

local function cframeAroundLookAt(target: vector, z: number, num1: number, num2: number): CFrame
    local var1 = (CFrame.Angles(0, math.rad(num1), 0) * CFrame.Angles(-math.rad(num2), 0, 0)):VectorToWorldSpace(Vector3.new(0, 0, z))

    return CFrame.lookAt(target + var1, target)
end

local tbl1 = {
    { alpha = 0, yawDegrees = 0, pitchDegrees = 0 },
    { alpha = 0.35, yawDegrees = 8, pitchDegrees = 4 },
    { alpha = 0.7, yawDegrees = -6, pitchDegrees = 2 },
    { alpha = 1, yawDegrees = 0, pitchDegrees = 0 }
}

local tbl2 = {
    { alpha = 0, yawDegrees = 0, pitchDegrees = 12 },
    { alpha = 1, yawDegrees = 360, pitchDegrees = 12 }
}

local tbl3 = {{ alpha = 0, yawDegrees = 0, pitchDegrees = 0 }}

local tbl4 = { static = tbl3, subtle = tbl1, closeup = tbl1, fullOrbit = tbl2 }

return {
    eval = function(target: vector, num1: number, tbl5, num2: number): CFrame
        local var1, var2 = sampleKeys(tbl5, num2)
        return cframeAroundLookAt(target, num1, var1, var2)
    end,
    cframeAroundLookAt = cframeAroundLookAt,
    sampleKeys = sampleKeys,
    resolve = function(str1: string?)
        return if str1 == "static" or str1 == "subtle" or str1 == "closeup" or str1 == "fullOrbit" then tbl4[str1] else tbl1
    end,
    framingFor = function(str1: string?): string
        return if str1 == "closeup" then "face" else "standing"
    end,
    EMOTE_ORBIT = tbl1,
    FULL_ORBIT = tbl2,
    STATIC = tbl3
}

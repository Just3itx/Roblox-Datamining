-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

local function isNaN(num1: number): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
    return num1 ~= num1
end

function module.estimateVelocity(tbl1)
    local num1 = #tbl1
    if num1 < 2 then
        return 0
    end
    local var1 = tbl1[1]
    local var2 = tbl1[num1]
    local var3 = var2.time - var1.time

    if var3 <= 0 or isNaN(var3) then
        return 0
    end
    local var4 = (var2.position - var1.position) / var3
    return if isNaN(var4) then 0 else var4
end

function module.planTargets(num1: number, num2: number, tbl1, tbl2)
    local granularity = tbl2.granularity

    if isNaN(num1) or granularity <= 0 or #tbl2.bands == 0 or tbl2.maxSamples <= 0 then
        return {}
    end

    local num3 = if isNaN(num2) then 0 else num2

    local var1 = tbl2.maxLeadFraction * (tbl1.max - tbl1.min)
    local num4 = math.round((num1 + math.clamp(num3 * tbl2.predictionLead, -var1, var1)) / granularity)

    local function strideForDistance(num5: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        for _, band in tbl2.bands do
            if num5 <= band.radius + 1e-9 then
                return band.stride
            end
        end
        return nil
    end

    local num5 = math.floor(tbl2.bands[#tbl2.bands].radius / granularity + 1e-9)

    local result = {}
    local tbl3 = ({})
    local function consider(num6: number)
        if #result >= tbl2.maxSamples then
            return
        end
        local var2 = strideForDistance(math.abs(num6) * granularity)
        if var2 == nil or num6 % var2 ~= 0 then
            return
        end
        local var3 = (num4 + num6) * granularity
        if var3 < tbl1.min or tbl1.max < var3 or tbl3[var3] then
            return
        end
        tbl3[var3] = true
        table.insert(result, var3)
    end

    if not (#result >= tbl2.maxSamples) then
        local var2 = strideForDistance(granularity * 0)
        if var2 ~= nil and 0 % var2 == 0 then
            local var3 = (num4 + 0) * granularity
            if not (var3 < tbl1.min or tbl1.max < var3 or tbl3[var3]) then
                tbl3[var3] = true
                table.insert(result, var3)
            end
        end
    end
    for i = 1, num5 do
        if #result >= tbl2.maxSamples then
            break
        end

        consider(i)
        consider(-i)
    end

    table.sort(result)
    return result
end

function module.diff(tbl1, tbl2)
    local tbl3 = ({})
    local fetch = {}
    for _, value in tbl1 do
        tbl3[value] = true
        if not tbl2[value] then
            table.insert(fetch, value)
        end
    end

    local evict = {}
    for value in tbl2 do
        if not tbl3[value] then
            table.insert(evict, value)
        end
    end
    table.sort(evict)

    return { fetch = fetch, evict = evict }
end

function module.selectFrameTime(num1: number, tbl1)
    local var1 = nil
    local huge = math.huge
    for _, value in tbl1 do
        local num2 = math.abs(value - num1)
        if num2 < huge then
            var1 = value
            huge = num2
        end
    end

    return var1
end

module.defaultConfig = {
    granularity = 0.2,
    bands = {
        { radius = 1, stride = 1 },
        { radius = 3, stride = 3 },
        { radius = 8, stride = 8 }
    },
    predictionLead = 0.4,
    maxLeadFraction = 0.2,
    maxSamples = 40
}

return module

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:01:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AnalyticsMetricChart = script:FindFirstAncestor("AnalyticsMetricChart")

local _MetricChartTypes = require(AnalyticsMetricChart.Components.MetricChart.MetricChartTypes)

local tbl1 = {
    points = {},
    minX = 0,
    maxX = 1,
    minY = 0,
    maxY = 1,
    yTicks = {}
}

local function niceNum(num1: number, bool1: boolean): number -- Luacid: Inlined by compiler; 1 call site recovered
    if num1 <= 0 then
        return 1
    end
    local num2 = math.floor(math.log(num1, 10))
    local num3 = num1 / 10 ^ num2

    return (if bool1 then if num3 < 1.5 then 1 elseif num3 < 3 then 2 elseif num3 < 7 then 5 else 10 elseif num3 <= 1 then 1 elseif num3 <= 2 then 2 elseif num3 <= 5 then 5 else 10) * 10 ^ num2
end

local function computeYAxis(num1: number, num2: number)
    if num2 == num1 then
        local num3 = if num1 == 0 then 1 else math.abs(num1) * 0.5
        return num1 - num3, num1 + num3, { num1 }
    end

    local num3 = niceNum((num2 - num1) / 2, true)
    local num4 = math.floor(num1 / num3) * num3
    local num5 = math.ceil(num2 / num3) * num3

    if num5 - num4 < num3 * 2 then
        num5 = num4 + num3 * 2
    end

    return num4, num5, { num4, (num4 + num5) / 2, num5 }
end

local function deriveChartAxes(tbl2)
    if tbl2 == nil or #tbl2 == 0 then
        return tbl1
    end

    local points = ({})
    local value = tbl2[1].value
    local value2 = tbl2[1].value
    for value3, value4 in tbl2 do
        points[value3] = Vector2.new(value3 - 1, value4.value)
        value = math.min(value, value4.value)
        value2 = math.max(value2, value4.value)
    end

    local num1 = #tbl2
    local num2, num3, yTicks = computeYAxis(value, value2)

    local num4 = (num3 - num2) * 0.1

    return {
        points = points,
        minX = 0,
        maxX = math.max(num1 - 1, 1),
        minY = num2 - num4,
        maxY = num3 + num4,
        yTicks = yTicks
    }
end

return deriveChartAxes

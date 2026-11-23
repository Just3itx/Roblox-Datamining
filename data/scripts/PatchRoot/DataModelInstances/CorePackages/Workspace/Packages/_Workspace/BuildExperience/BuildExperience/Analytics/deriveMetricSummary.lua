-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:41:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local MetricGranularity = require(BuildExperienceParent.DataHydration.CreatorAnalytics).MetricGranularity
local fillMetricSeriesGaps = require(BuildExperience.Analytics.fillMetricSeriesGaps)

local tbl1 = { hasData = false, latest = nil, trendPct = 0, priorValue = nil }

local function deriveSimpleSummary(tbl2)
    local var1 = table.clone(tbl2)
    table.sort(var1, function(arg1, arg2): boolean
        return arg1.time < arg2.time
    end)

    local value = var1[1].value
    local value2 = var1[#var1].value

    return {
        hasData = true,
        latest = value2,
        trendPct = if value == nil or value == 0 then 0 else (value2 - value) / value,
        priorValue = nil
    }
end

local function averageRange(tbl2, num1: number, num2: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    local num3 = num2 - num1 + 1
    if num3 < 1 then
        return 0
    end
    local num4 = 0
    for i = num1, num2 do
        num4 += tbl2[i].value
    end
    return num4 / num3
end

local function deriveMetricSummary(arg1, tbl2)
    local dataPoints = if arg1 == nil then nil else arg1.dataPoints

    if dataPoints == nil or #dataPoints == 0 then
        return tbl1
    end

    if tbl2 == nil or arg1 ~= nil and arg1.granularity ~= MetricGranularity.OneDay then
        return (deriveSimpleSummary(dataPoints))
    end

    local var1 = fillMetricSeriesGaps(arg1, { lookbackSeconds = tbl2.lookbackSeconds * 2, endUnix = tbl2.endUnix })
    local var2 = if var1 == nil then dataPoints else var1.dataPoints
    local num1 = #var2
    local num2 = math.floor(num1 / 2)
    if num2 < 1 then
        return (deriveSimpleSummary(dataPoints))
    end

    local priorValue = averageRange(var2, 1, num2)
    local latest = averageRange(var2, num1 - num2 + 1, num1)

    return {
        hasData = true,
        latest = latest,
        trendPct = if priorValue == 0 then 0 else (latest - priorValue) / priorValue,
        priorValue = priorValue
    }
end

return deriveMetricSummary

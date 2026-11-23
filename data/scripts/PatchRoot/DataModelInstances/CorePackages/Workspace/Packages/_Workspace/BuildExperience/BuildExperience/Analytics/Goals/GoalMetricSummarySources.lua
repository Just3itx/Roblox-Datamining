-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local deriveMetricSummary = require(BuildExperience.Analytics.deriveMetricSummary)
local _GoalTypes = require(BuildExperience.Analytics.Goals.GoalTypes)

local MetricGranularity = CreatorAnalytics.MetricGranularity

local function retentionRatio(arg1, durationSeconds: number, unixTimestamp: number, unixTimestamp2: number)
    local var1 = nil
    local var2 = nil
    for _, value in arg1.values or {} do
        local var3 = value.breakdownValues[1]
        if var3 == nil or var3.dimension ~= "SessionTimeBucket" then
            continue
        end

        local var4 = tonumber(var3.value)
        if var4 ~= 0 and var4 ~= durationSeconds then
            continue
        end

        for _, dataPoint in value.dataPoints do
            local dateTime = DateTime.fromIsoDate(dataPoint.time)
            if dateTime == nil or dateTime.UnixTimestamp <= unixTimestamp or unixTimestamp2 < dateTime.UnixTimestamp then
                continue
            end

            if var4 == 0 then
                var1 = (var1 or 0) + dataPoint.value
            end
            if var4 == durationSeconds then
                var2 = (var2 or 0) + dataPoint.value
            end
        end
    end
    return if var1 == nil or var1 <= 0 or var2 == nil then nil else var2 / var1
end

return {
    summary = function(tbl1)
        return {
            query = {
                metric = tbl1.metric,
                lookbackWindows = 2,
                endOffsetDays = tbl1.endOffsetDays,
                filters = tbl1.filters
            },
            derive = function(arg1, arg2)
                local var1 = deriveMetricSummary(arg1, arg2)

                if not var1.hasData or var1.latest == nil then
                    return nil
                end

                return {
                    kind = "number",
                    value = var1.latest,
                    trendPct = var1.trendPct,
                    priorValue = var1.priorValue
                }
            end
        }
    end,
    topBreakdown = function(tbl1)
        local dimension = tbl1.dimension

        return {
            query = {
                metric = tbl1.metric,
                granularity = MetricGranularity.None,
                lookbackWindows = 1,
                filters = tbl1.filters,
                breakdowns = {{
                    dimensions = { dimension }
                }}
            },
            derive = function(arg1, _): {breakdown: any, kind: string, metric: any}?
                local var1 = nil
                local huge = -math.huge

                for _, value in arg1.values or {} do
                    for _, value2 in value.breakdownValues do
                        if value2.dimension ~= dimension then
                            continue
                        end

                        local num1 = 0
                        for _, dataPoint in value.dataPoints do
                            num1 += dataPoint.value
                        end

                        if huge <= num1 then
                            var1 = value2
                            huge = num1
                        end

                        break
                    end
                end

                return if var1 == nil then nil else {
                    kind = "breakdown",
                    metric = tbl1.metric,
                    breakdown = var1
                }
            end
        }
    end,
    firstSessionRetention = function(tbl1)
        local durationSeconds = tbl1.durationSeconds

        return {
            query = {
                metric = CreatorAnalytics.MetricId.TotalSessionsEndedInBucket,
                granularity = MetricGranularity.OneDay,
                lookbackWindows = 2,
                breakdowns = {{
                    dimensions = { "SessionTimeBucket" }
                }},
                filters = {{
                    dimension = "SessionTimeBucket",
                    operation = "Equals",
                    values = { "0", tostring(durationSeconds) }
                }}
            },
            derive = function(arg1, arg2): {kind: string, priorValue: any, trendPct: number, value: any}?
                local unixTimestamp = arg2.endUnix - arg2.lookbackSeconds
                local value = retentionRatio(arg1, durationSeconds, unixTimestamp, arg2.endUnix)
                if value == nil then
                    return nil
                end

                local priorValue = retentionRatio(arg1, durationSeconds, unixTimestamp - arg2.lookbackSeconds, unixTimestamp)
                return {
                    kind = "number",
                    value = value,
                    priorValue = priorValue,
                    trendPct = if priorValue == nil or not (priorValue > 0) then nil else (value - priorValue) / priorValue
                }
            end
        }
    end
}

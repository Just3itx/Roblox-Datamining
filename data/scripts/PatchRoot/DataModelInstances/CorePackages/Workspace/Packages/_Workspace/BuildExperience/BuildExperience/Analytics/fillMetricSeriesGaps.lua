-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:41:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local MetricGranularity = require(BuildExperienceParent.DataHydration.CreatorAnalytics).MetricGranularity

local function toIsoDay(unixTimestamp: number): string -- Luacid: Inlined by compiler; 1 call site recovered
    return DateTime.fromUnixTimestamp(unixTimestamp):ToIsoDate()
end

local function fillMetricSeriesGaps(arg1, tbl1)
    if arg1 == nil or tbl1 == nil or arg1.granularity ~= MetricGranularity.OneDay then
        return arg1
    end

    local var1 = tbl1.endUnix - tbl1.endUnix % 86400
    local var2 = var1 - tbl1.lookbackSeconds + 86400
    if var1 < var2 or (var1 - var2) / 86400 + 1 > 2000 then
        return arg1
    end

    local tbl2 = {}
    for _, dataPoint in arg1.dataPoints do
        local dateTime = DateTime.fromIsoDate(dataPoint.time)
        if dateTime ~= nil then
            tbl2[dateTime.UnixTimestamp - dateTime.UnixTimestamp % 86400] = dataPoint
        end
    end

    local dataPoints = {}

    while var2 <= var1 do
        local tbl4 = tbl2[var2]
        if tbl4 == nil then
            tbl4 = {
                time = toIsoDay(var2),
                value = 0
            }
        end

        table.insert(dataPoints, tbl4)
        var2 += 86400
    end

    return {
        dataPoints = dataPoints,
        granularity = arg1.granularity
    }
end

return fillMetricSeriesGaps

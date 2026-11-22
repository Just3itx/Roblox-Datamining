-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local _AnalyticsMetricChart = require(MomentsParent.AnalyticsMetricChart)
local _CreatorAnalytics = require(MomentsParent.DataHydration.CreatorAnalytics)

local function toRfc3339(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return (os.date("!%Y-%m-%dT%H:%M:%SZ", num1))
end

local function metricSeriesToChartPoints(arg1, tbl1)
    local tbl2 = ({})
    if arg1 ~= nil then
        for _, dataPoint in arg1.dataPoints do
            local dateTime = DateTime.fromIsoDate(dataPoint.time)
            if dateTime ~= nil and type(dataPoint.value) == "number" then
                local var1 = math.floor(dateTime.UnixTimestamp / tbl1.bucketSeconds) * tbl1.bucketSeconds
                tbl2[var1] = (tbl2[var1] or 0) + dataPoint.value
            end
        end
    end

    local var1 = math.floor(tbl1.startUnix / tbl1.bucketSeconds) * tbl1.bucketSeconds
    local num1 = 0
    local points = {}
    local bool1 = false

    while var1 < tbl1.endUnix do
        local var2 = tbl2[var1]
        if var2 == nil then
            var2 = 0
        else
            bool1 = true
        end

        num1 += var2
        table.insert(points, { time = toRfc3339(var1), value = var2 })
        var1 += tbl1.bucketSeconds
    end
    return { points = points, total = num1, hasData = bool1 }
end

return metricSeriesToChartPoints

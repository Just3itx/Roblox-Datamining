-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:40:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Promise = require(DataHydrationParent.Promise)
local _HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local FFlagBuildExperienceAnalyticsBreakdowns = require(DataHydration.CreatorAnalytics.FFlagBuildExperienceAnalyticsBreakdowns)

local pollAnalyticsOperation = require(script.Parent.pollAnalyticsOperation)
local CreatorAnalyticsStoreTypes = require(script.Parent.CreatorAnalyticsStoreTypes)

local MetricGranularity = CreatorAnalyticsStoreTypes.MetricGranularity
local FilterOperation = CreatorAnalyticsStoreTypes.FilterOperation

local tbl1 = {
    [MetricGranularity.OneMinute] = "METRIC_GRANULARITY_ONE_MINUTE",
    [MetricGranularity.HalfHour] = "METRIC_GRANULARITY_HALF_HOUR",
    [MetricGranularity.OneHour] = "METRIC_GRANULARITY_ONE_HOUR",
    [MetricGranularity.OneDay] = "METRIC_GRANULARITY_ONE_DAY",
    [MetricGranularity.OneWeek] = "METRIC_GRANULARITY_ONE_WEEK",
    [MetricGranularity.OneMonth] = "METRIC_GRANULARITY_ONE_MONTH",
    [MetricGranularity.None] = "METRIC_GRANULARITY_NONE"
}

local tbl2 = {
    [FilterOperation.Contains] = "FILTER_OPERATION_CONTAINS",
    [FilterOperation.NotContains] = "FILTER_OPERATION_NOT_CONTAINS",
    [FilterOperation.GreaterThan] = "FILTER_OPERATION_GT",
    [FilterOperation.GreaterThanOrEqual] = "FILTER_OPERATION_GTE",
    [FilterOperation.LessThan] = "FILTER_OPERATION_LT",
    [FilterOperation.LessThanOrEqual] = "FILTER_OPERATION_LTE",
    [FilterOperation.Match] = "FILTER_OPERATION_MATCH",
    [FilterOperation.Equals] = "FILTER_OPERATION_EQUALS",
    [FilterOperation.NotEqual] = "FILTER_OPERATION_NOT_EQUAL"
}

local function toRfc3339(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    return (os.date("!%Y-%m-%dT%H:%M:%SZ", num1))
end

local function toSeries(tbl3, granularity, bool1: boolean)
    if tbl3.queryResult == nil then
        error({ errorMessage = "analytics metric response missing queryResult" })
    end
    local values = tbl3.queryResult.values
    local var1 = if values == nil then nil else values[1]
    local dataPoints = if var1 == nil then nil else var1.dataPoints
    local tbl4

    if bool1 then
        tbl4 = {}
        if values ~= nil then
            for _, value in values do
                table.insert(tbl4, { breakdownValues = value.breakdownValue or {}, dataPoints = value.dataPoints or {} })
            end
        end
    else
        tbl4 = nil
    end

    return {
        dataPoints = dataPoints or {},
        granularity = granularity,
        values = tbl4
    }
end

local function fetchResourceMetric(arg1, tbl3)
    local tbl4 = tbl3 or {}
    local var1 = tbl4.baseUrl or UrlBase.APIS

    local bool1 = arg1.resourceType ~= nil
    local resourceType = if bool1 then arg1.resourceType else "RESOURCE_TYPE_UNIVERSE"
    local resourceId = if bool1 then arg1.resourceId else tostring(arg1.universeId)
    local filters = arg1.filters
    local breakdowns = arg1.breakdowns
    local var3 = if tbl4.includeAdvancedFields ~= nil then tbl4.includeAdvancedFields else bool1 or FFlagBuildExperienceAnalyticsBreakdowns
    local dateTime = DateTime.fromIsoDate(arg1.endTime)
    if dateTime == nil then
        return Promise.reject({ errorMessage = "invalid endTime for analytics metric query: " .. tostring(arg1.endTime) })
    end

    local unixTimestamp = dateTime.UnixTimestamp
    local query = {
        resourceType = resourceType,
        resourceId = resourceId,
        metric = arg1.metric,
        granularity = tbl1[arg1.granularity] or arg1.granularity,
        startTime = toRfc3339(unixTimestamp - arg1.lookbackSeconds),
        endTime = toRfc3339(unixTimestamp + 86400)
    }

    if var3 then
        if filters ~= nil and #filters > 0 then
            local tbl5 = {}
            for _, filter in filters do
                table.insert(
                    tbl5,
                    {
                        dimension = filter.dimension,
                        values = filter.values,
                        operation = tbl2[filter.operation] or filter.operation
                    }
                )
            end

            query.filter = tbl5
        end

        if breakdowns ~= nil and #breakdowns > 0 then
            local tbl5 = {}
            for _, breakdown in breakdowns do
                table.insert(tbl5, { dimensions = breakdown.dimensions })
            end
            query.breakdown = tbl5
        end
    end

    local url = var1 .. "/analytics-query-gateway/v1/metrics/resource/" .. resourceType .. "/id/" .. resourceId

    return pollAnalyticsOperation({
        network = tbl4.network,
        url = url,
        body = { query = query },
        analyticsKey = tbl4.analyticsKey
            or (if bool1 then "data-hydration.resource-analytics-metric" else "build-experience.experience-analytics-metric"),
        mapResult = function(tbl6)
            return (toSeries(tbl6, arg1.granularity, var3))
        end,
        timeoutMessage = "analytics metric query did not complete after polling",
        delay = tbl4.delay
    })
end

return fetchResourceMetric

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:30Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Cryo = require(DataHydrationParent.Cryo)
local _HttpClient = require(DataHydrationParent.HttpClient)

local FFlagBuildExperienceAnalyticsBreakdowns = require(DataHydration.CreatorAnalytics.FFlagBuildExperienceAnalyticsBreakdowns)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local fetchResourceMetric = require(script.Parent.fetchResourceMetric)
local fetchMetricMetadata = require(script.Parent.fetchMetricMetadata)
local CreatorAnalyticsStoreTypes = require(script.Parent.CreatorAnalyticsStoreTypes)

local function encodeFilters(tbl1)
    local result = {}

    for _, value in (Cryo.List.sort(tbl1, function(arg1, arg2): boolean
        if arg1.dimension == arg2.dimension then
            return arg1.operation < arg2.operation
        end

        return arg1.dimension < arg2.dimension
    end)) do
        table.insert(result, { value.dimension, Cryo.List.sort(value.values), value.operation })
    end

    return result
end

local function decodeFilters(tbl1)
    local result = {}
    for _, value in tbl1 do
        table.insert(result, { dimension = value[1], values = value[2], operation = value[3] })
    end

    return result
end

local function encodeBreakdowns(tbl1)
    local result = {}
    for _, value in tbl1 do
        table.insert(result, { value.dimensions })
    end

    return result
end

local function decodeBreakdowns(tbl1)
    local result = {}
    for _, value in tbl1 do
        table.insert(result, { dimensions = value[1] })
    end

    return result
end

local function paramsKey(tbl1): string
    local input = {
        tbl1.resourceType,
        tbl1.resourceId,
        tbl1.metric,
        tbl1.granularity,
        tbl1.lookbackSeconds,
        tbl1.endTime,
        encodeFilters(tbl1.filters or {}),
        encodeBreakdowns(tbl1.breakdowns or {}),
        tbl1.includeAdvancedFields,
        tbl1.analyticsKey
    }

    return HttpService:JSONEncode(input)
end

local function paramsFromKey(input: string)
    local var1 = HttpService:JSONDecode(input)
    return {
        resourceType = var1[1],
        resourceId = var1[2],
        metric = var1[3],
        granularity = var1[4],
        lookbackSeconds = var1[5],
        endTime = var1[6],
        filters = if var1[7] then decodeFilters(var1[7]) else nil,
        breakdowns = if var1[8] then decodeBreakdowns(var1[8]) else nil,
        includeAdvancedFields = var1[9],
        analyticsKey = var1[10]
    }
end

local function toCachedUniverseMetricParams(arg1)
    return {
        resourceType = CreatorAnalyticsStoreTypes.ResourceType.Universe,
        resourceId = tostring(arg1.universeId),
        metric = arg1.metric,
        granularity = arg1.granularity,
        lookbackSeconds = arg1.lookbackSeconds,
        endTime = arg1.endTime,
        filters = if FFlagBuildExperienceAnalyticsBreakdowns then arg1.filters else nil,
        breakdowns = if FFlagBuildExperienceAnalyticsBreakdowns then arg1.breakdowns else nil,
        includeAdvancedFields = FFlagBuildExperienceAnalyticsBreakdowns,
        analyticsKey = "build-experience.experience-analytics-metric"
    }
end

local function toCachedResourceMetricParams(arg1)
    return {
        resourceType = arg1.resourceType,
        resourceId = arg1.resourceId,
        metric = arg1.metric,
        granularity = arg1.granularity,
        lookbackSeconds = arg1.lookbackSeconds,
        endTime = arg1.endTime,
        filters = arg1.filters,
        breakdowns = arg1.breakdowns,
        includeAdvancedFields = true,
        analyticsKey = "data-hydration.resource-analytics-metric"
    }
end

local function metricsKey(tbl1): string
    local input = table.clone(tbl1)
    table.sort(input)
    return HttpService:JSONEncode(input)
end

local function createCreatorAnalyticsStore(tbl1)
    local tbl2 = tbl1 or {}

    local tbl3 = ({})
    local function trackPoll<T>(arg1: T): T -- Luacid: Inlined by compiler; 2 call sites recovered
        tbl3[arg1] = true
        arg1:finally(function()
            tbl3[arg1] = nil
        end)
        return arg1
    end

    local cache = createDataCache(tbl2.seriesTtlSeconds or 86400, tbl2.failedTtlSeconds)
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        fetchFn = function(str1: string, _)
            local tbl4 = paramsFromKey(str1)
            return trackPoll(
                (fetchResourceMetric(tbl4, {
                    network = tbl2.network,
                    baseUrl = tbl2.baseUrl,
                    delay = tbl2.delay,
                    includeAdvancedFields = tbl4.includeAdvancedFields,
                    analyticsKey = tbl4.analyticsKey
                }))
            )
        end
    })
    local function getAndFetchResourceMetric(arg1)
        return (dataResolver.getAndFetchItem(paramsKey((toCachedResourceMetricParams(arg1)))))
    end

    local function getAndFetchMetric(arg1)
        return (dataResolver.getAndFetchItem(paramsKey((toCachedUniverseMetricParams(arg1)))))
    end

    local function refetchResourceMetric(arg1)
        dataResolver.fetchItem(paramsKey((toCachedResourceMetricParams(arg1))))
    end

    local function refetchMetric(arg1)
        dataResolver.fetchItem(paramsKey((toCachedUniverseMetricParams(arg1))))
    end

    local dataCache = createDataCache(tbl2.metadataTtlSeconds or 600, tbl2.failedTtlSeconds)
    local dataResolver2 = createDataResolver({
        cache = dataCache,
        supportsMultiGet = false,
        fetchFn = function(input: string, _)
            return trackPoll(
                (fetchMetricMetadata(
                    HttpService:JSONDecode(input),
                    {
                        network = tbl2.network,
                        baseUrl = tbl2.baseUrl,
                        delay = tbl2.delay
                    }
                ))
            )
        end
    })

    return {
        getAndFetchResourceMetric = getAndFetchResourceMetric,
        refetchResourceMetric = refetchResourceMetric,
        getAndFetchMetric = getAndFetchMetric,
        refetchMetric = refetchMetric,
        getAndFetchMetricMetadata = function(tbl4)
            return (dataResolver2.getAndFetchItem(metricsKey(tbl4)))
        end,
        dispose = function()
            local tbl4 = {}
            for value in tbl3 do
                table.insert(tbl4, value)
            end
            tbl3 = {}
            for _, value in tbl4 do
                value:cancel()
            end
            dataResolver.dispose()
            dataResolver2.dispose()
        end
    }
end
return createCreatorAnalyticsStore

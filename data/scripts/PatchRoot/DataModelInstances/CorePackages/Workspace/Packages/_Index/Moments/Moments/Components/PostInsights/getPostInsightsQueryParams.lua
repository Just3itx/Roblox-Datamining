-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local CreatorAnalytics = require(MomentsParent.DataHydration.CreatorAnalytics)
local _MomentsTypes = require(MomentsParent.MomentsTypes)

local _metricSeriesToChartPoints = require(script.Parent.metricSeriesToChartPoints)

local var1 = table.freeze({
    views = "MomentsLifetimeVideoViews",
    watchTime = "MomentsLifetimeWatchTime",
    watchTimeNoReplay = "MomentsLifetimeWatchTimeNoReplay",
    joins = "MomentsLifetimeJoins"
})

local function toRfc3339(num1: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return (os.date("!%Y-%m-%dT%H:%M:%SZ", num1))
end

local function floorTo(num1: number, num2: number): number -- Luacid: Inlined by compiler; 3 call sites recovered
    return math.floor(num1 / num2) * num2
end

local function getPostInsightsQueryParams(arg1, num1: number): {lifetime: number, views: number, window: number}?
    local recommendationMetadata = arg1.recommendationMetadata
    local feedItemId = if recommendationMetadata == nil then nil else recommendationMetadata.feedItemId

    if feedItemId == nil or feedItemId == "" or arg1.creatorId == nil then
        return nil
    end

    local endUnix = floorTo(num1, 3600)
    local endTime = toRfc3339(endUnix)
    local isoDate = if arg1.createdAt == nil then nil else DateTime.fromIsoDate(arg1.createdAt)
    local unixTimestamp = if isoDate == nil then nil else isoDate.UnixTimestamp
    local tbl1

    if unixTimestamp ~= nil and num1 - unixTimestamp < 259200 then
        local startUnix = math.min(floorTo(unixTimestamp, 3600), endUnix - 3600)
        tbl1 = {
            granularity = CreatorAnalytics.MetricGranularity.OneHour,
            bucketSeconds = 3600,
            startUnix = startUnix,
            endUnix = endUnix
        }
    else
        local num3 = math.ceil((endUnix - 2592000) / 86400) * 86400
        if unixTimestamp ~= nil then
            num3 = math.max(num3, (floorTo(unixTimestamp, 86400)))
        end
        tbl1 = {
            granularity = CreatorAnalytics.MetricGranularity.OneDay,
            bucketSeconds = 86400,
            startUnix = num3,
            endUnix = endUnix
        }
    end

    local filters = {{
        dimension = "FeedItem",
        values = { feedItemId },
        operation = CreatorAnalytics.FilterOperation.Equals
    }}

    local function query(metric: string, granularity, lookbackSeconds: number) -- Luacid: Inlined by compiler; 5 call sites recovered
        return {
            resourceType = CreatorAnalytics.ResourceType.Creator,
            resourceId = tostring(arg1.creatorId),
            metric = metric,
            granularity = granularity,
            lookbackSeconds = lookbackSeconds,
            endTime = endTime,
            filters = filters
        }
    end

    local none = CreatorAnalytics.MetricGranularity.None

    local tbl3 = { views = 0, window = 0, lifetime = 0 }
    local granularity = tbl1.granularity
    local lookbackSeconds = endUnix - tbl1.startUnix
    tbl3.views = query("MomentsVideoViews", granularity, lookbackSeconds)
    tbl3.window = tbl1
    local lifetime = { views = 0, watchTime = 0, watchTimeNoReplay = 0, joins = 0 }
    local views = var1.views
    lifetime.views = query(views, none, 2588400)
    local watchTime = var1.watchTime
    lifetime.watchTime = query(watchTime, none, 2588400)
    local watchTimeNoReplay = var1.watchTimeNoReplay
    lifetime.watchTimeNoReplay = query(watchTimeNoReplay, none, 2588400)
    local joins = var1.joins
    lifetime.joins = query(joins, none, 2588400)
    tbl3.lifetime = lifetime
    return tbl3
end

return getPostInsightsQueryParams

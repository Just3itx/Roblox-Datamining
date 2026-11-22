-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local CreatorAnalytics = require(MomentsParent.DataHydration.CreatorAnalytics)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local getPostInsightsQueryParams = require(script.Parent.getPostInsightsQueryParams)
local metricSeriesToChartPoints = require(script.Parent.metricSeriesToChartPoints)

local DataStatus = CreatorAnalytics.DataStatus
local getCreatorAnalyticsStore = CreatorAnalytics.getCreatorAnalyticsStore

local tbl1 = {
    views = "lifetime_views",
    watchTime = "lifetime_watch_time",
    watchTimeNoReplay = "lifetime_watch_time_no_replay",
    joins = "lifetime_joins"
}

local function seriesTotal(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1 == nil then
        return nil
    end
    local num1 = 0
    for _, dataPoint in arg1.dataPoints do
        num1 += dataPoint.value
    end
    return num1
end

local function combineStatus(tbl2)
    local ready = DataStatus.Ready
    for _, value in tbl2 do
        if value == DataStatus.Failed then
            return DataStatus.Failed
        end

        if value == DataStatus.NotReady then
            ready = DataStatus.NotReady
        end
    end
    return ready
end

local function usePostInsightsAnalytics(arg1, num1: number?, num2: number?)
    local params = React.useMemo(function()
        return getPostInsightsQueryParams(arg1, num1 or os.time())
    end, { arg1.momentId, arg1.createdAt or false, num1 or false })

    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg2)
            if params == nil then
                return {
                    params = params,
                    viewsStatus = DataStatus.Failed,
                    views = nil,
                    lifetimeStatus = DataStatus.Failed,
                    lifetime = {},
                    lifetimeStatuses = {}
                }
            end
            local creatorAnalyticsStore = getCreatorAnalyticsStore(arg2)
            local andFetchResourceMetric = creatorAnalyticsStore.getAndFetchResourceMetric(params.views)
            local lifetime = ({})
            local lifetimeStatuses = ({})
            local tbl4 = {}
            for value, value2 in params.lifetime do
                local andFetchResourceMetric2 = creatorAnalyticsStore.getAndFetchResourceMetric(value2)
                lifetime[value] = andFetchResourceMetric2.data(arg2)
                lifetimeStatuses[value] = andFetchResourceMetric2.status(arg2)
                table.insert(tbl4, andFetchResourceMetric2.status(arg2))
            end
            return {
                params = params,
                viewsStatus = andFetchResourceMetric.status(arg2),
                views = andFetchResourceMetric.data(arg2),
                lifetimeStatus = combineStatus(tbl4),
                lifetime = lifetime,
                lifetimeStatuses = lifetimeStatuses
            }
        end)
    end, { params })
    local views = SignalsReact.useSignalState(var2)

    local current = React.useRef({ params = params, views = nil, lifetimeTotals = {}, lifetimeFailed = {} }).current
    if current.params ~= params then
        current.params = params
        current.views = nil
        current.lifetimeTotals = {}
        current.lifetimeFailed = {}
    end
    if views.params == params then
        if views.viewsStatus == DataStatus.Ready then
            current.views = views
        end
        for value, value2 in views.lifetimeStatuses do
            if value2 == DataStatus.Ready then
                current.lifetimeTotals[value] = seriesTotal(views.lifetime[value])
            elseif value2 == DataStatus.Failed then
                current.lifetimeFailed[value] = true
            end
        end
    end

    local var4 = if views.viewsStatus == DataStatus.Ready or current.views == nil then views else current.views
    local lifetimeTotals = current.lifetimeTotals

    local function lifetimeQueryStatus(str1: string) -- Luacid: Inlined by compiler; 4 call sites recovered
        if lifetimeTotals[str1] == nil then
            if current.lifetimeFailed[str1] then
                return DataStatus.Failed
            end

            return views.lifetimeStatuses[str1] or DataStatus.Failed
        end

        return DataStatus.Ready
    end

    local bool1 = not (params == nil
        or lifetimeTotals.views == nil
        or lifetimeTotals.watchTime == nil
        or lifetimeTotals.watchTimeNoReplay == nil)
        and lifetimeTotals.joins ~= nil
    local num3 = num2 or 600
    React.useEffect(function()
        if params == nil then
            return
        end

        local var5 = nil
        local function scheduleRefresh() -- Luacid: Inlined by compiler; 1 call site recovered
            var5 = task.delay(num3, function()
                local creatorAnalyticsStore = getCreatorAnalyticsStore(false)
                creatorAnalyticsStore.refetchResourceMetric(params.views)
                for _, value in params.lifetime do
                    creatorAnalyticsStore.refetchResourceMetric(value)
                end
                scheduleRefresh()
            end)
        end

        scheduleRefresh()

        return function()
            if var5 ~= nil then
                task.cancel(var5)
            end
        end
    end, { params, num3 })

    local viewsSeries = React.useMemo(function()
        if params == nil or var4.viewsStatus ~= DataStatus.Ready then
            return nil
        end
        return metricSeriesToChartPoints(var4.views, params.window)
    end, { params, var4.viewsStatus, var4.views })

    local var6 = React.useRef({ params = nil, queries = {}, inFlight = {} })

    React.useEffect(function()
        if params == nil then
            return
        end
        local current2 = var6.current
        if current2.params ~= params then
            current2.params = params
            current2.queries = {}
            current2.inFlight = {}
        end
        local function reportOnce(str1: string, arg2)
            if current2.queries[str1] then
                return
            end

            if arg2 == DataStatus.NotReady then
                if current2.inFlight[str1] == nil then
                    current2.inFlight[str1] = os.clock()
                end

                return
            end

            local var7 = current2.inFlight[str1]
            if var7 == nil then
                return
            end
            local var8 = if arg2 == DataStatus.Ready then "success" elseif arg2 == DataStatus.Failed then "failed" else nil

            if var8 == nil then
                return
            end
            current2.queries[str1] = true
            MomentsCommon.Analytics.reportMomentsPostInsightsRequest(str1, var8)
            local num4 = math.round((os.clock() - var7) * 1000)
            MomentsCommon.Analytics.reportMomentsPostInsightsRequestLatency(str1, var8, num4)
        end
        reportOnce("views", views.viewsStatus)
        for value, value2 in tbl1 do
            reportOnce(value2, views.lifetimeStatuses[value])
        end
    end, { params, views })

    return {
        viewsStatus = var4.viewsStatus,
        viewsSeries = viewsSeries,
        window = if params == nil then nil else params.window,
        lifetimeStatus = if bool1 then DataStatus.Ready else views.lifetimeStatus,
        lifetimeViews = lifetimeTotals.views,
        lifetimeViewsStatus = lifetimeQueryStatus("views"),
        lifetimeWatchTimeSeconds = lifetimeTotals.watchTime,
        lifetimeWatchTimeStatus = lifetimeQueryStatus("watchTime"),
        lifetimeWatchTimeNoReplaySeconds = lifetimeTotals.watchTimeNoReplay,
        lifetimeWatchTimeNoReplayStatus = lifetimeQueryStatus("watchTimeNoReplay"),
        lifetimeJoins = lifetimeTotals.joins,
        lifetimeJoinsStatus = lifetimeQueryStatus("joins")
    }
end

return usePostInsightsAnalytics

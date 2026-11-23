-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local getCreatorAnalyticsStore = require(BuildExperienceParent.DataHydration.CreatorAnalytics).getCreatorAnalyticsStore

local DataStatus = require(BuildExperienceParent.DataHydration.CreatorAnalytics).DataStatus
local _AnalyticsMetric = require(BuildExperience.Analytics.AnalyticsMetric)
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local getMetricQueryParams = require(BuildExperience.Analytics.getMetricQueryParams)
local deriveMetricSummary = require(BuildExperience.Analytics.deriveMetricSummary)

local FFlagBuildAnalyticsCreatorHubWindowFix = require(BuildExperience.Flags.FFlagBuildAnalyticsCreatorHubWindowFix)

local function useExperienceMetricSeries(num1: number, arg1, arg2, isoDate: string?, num2: number?)
    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg3)
            if isoDate == nil then
                return {
                    series = nil,
                    status = DataStatus.NotReady
                }
            end
            local metricQueryParams = getMetricQueryParams(num1, arg1, arg2, isoDate)
            local var1 = getCreatorAnalyticsStore(arg3).getAndFetchMetric(metricQueryParams)
            return {
                series = var1.data(arg3),
                status = var1.status(arg3)
            }
        end)
    end, {
        num1,
        arg1,
        arg2,
        isoDate
    })

    local var2 = SignalsReact.useSignalState(var1)

    local num3 = num2 or 600
    React.useEffect(function()
        if not FFlagBuildAnalyticsCreatorHubWindowFix then
            return
        end
        if isoDate == nil then
            return
        end
        local metricQueryParams = getMetricQueryParams(num1, arg1, arg2, isoDate)
        local var3 = nil
        local function scheduleRefresh() -- Luacid: Inlined by compiler; 1 call site recovered
            var3 = task.delay(num3, function()
                getCreatorAnalyticsStore(false).refetchMetric(metricQueryParams)
                scheduleRefresh()
            end)
        end

        scheduleRefresh()

        return function()
            if var3 ~= nil then
                task.cancel(var3)
            end
        end
    end, {
        num1,
        arg1,
        arg2,
        isoDate,
        num3
    })
    local var3 = React.useMemo(function()
        local var3 = nil
        if isoDate ~= nil then
            local dateTime = DateTime.fromIsoDate(isoDate)
            var3 = dateTime ~= nil and {
                lookbackSeconds = arg2.lookbackSeconds,
                endUnix = dateTime.UnixTimestamp
            } or var3
        end

        return deriveMetricSummary(var2.series, var3)
    end, { var2.series, arg2, isoDate })

    return {
        series = var2.series,
        status = var2.status,
        hasData = var3.hasData,
        latest = var3.latest,
        trendPct = var3.trendPct,
        priorValue = var3.priorValue
    }
end

return useExperienceMetricSeries

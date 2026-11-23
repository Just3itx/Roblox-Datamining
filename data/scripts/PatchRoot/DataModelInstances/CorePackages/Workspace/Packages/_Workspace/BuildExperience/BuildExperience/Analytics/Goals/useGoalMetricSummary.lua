-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Signals = require(BuildExperienceParent.Signals)
local SignalsReact = require(BuildExperienceParent.SignalsReact)

local CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local getCreatorAnalyticsStore = CreatorAnalytics.getCreatorAnalyticsStore
local DataStatus = CreatorAnalytics.DataStatus
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local _GoalTypes = require(BuildExperience.Analytics.Goals.GoalTypes)
local FFlagBuildAnalyticsGoals = require(BuildExperience.Flags.FFlagBuildAnalyticsGoals)

local function toParams(universeId: number, query, arg1, isoDate: string)
    local endOffsetDays = query.endOffsetDays
    if endOffsetDays ~= nil then
        local dateTime = DateTime.fromIsoDate(isoDate)
        if dateTime ~= nil then
            isoDate = os.date("!%Y-%m-%dT%H:%M:%SZ", dateTime.UnixTimestamp - endOffsetDays * 86400)
        end
    end

    local var1 = arg1.lookbackSeconds * (query.lookbackWindows or 1)
    if FFlagBuildAnalyticsGoals and query.metric == CreatorAnalytics.MetricId.TotalSessionsEndedInBucket then
        var1 -= 86400
    end
    return {
        universeId = universeId,
        metric = query.metric,
        granularity = query.granularity or arg1.granularity,
        lookbackSeconds = var1,
        endTime = isoDate,
        filters = query.filters,
        breakdowns = query.breakdowns
    }
end

local function useGoalMetricSummary(universeId: number, arg1, arg2, isoDate: string?)
    local query = arg1.query

    local var1 = React.useMemo(function()
        return Signals.createComputed(function(arg3)
            if isoDate == nil then
                return {
                    series = nil,
                    status = DataStatus.NotReady
                }
            end
            local var1 = getCreatorAnalyticsStore(arg3).getAndFetchMetric((toParams(universeId, query, arg2, isoDate)))
            return {
                series = var1.data(arg3),
                status = var1.status(arg3)
            }
        end)
    end, {
        universeId,
        query,
        arg2,
        isoDate
    })
    local var2 = SignalsReact.useSignalState(var1)

    local value = React.useMemo(function()
        if var2.series == nil or isoDate == nil then
            return nil
        end

        local dateTime = DateTime.fromIsoDate(isoDate)
        if not dateTime then
            return nil
        end

        return arg1.derive(
            var2.series,
            {
                lookbackSeconds = arg2.lookbackSeconds,
                endUnix = dateTime.UnixTimestamp - (query.endOffsetDays or 0) * 86400
            }
        )
    end, {
        var2.series,
        arg1,
        query,
        arg2,
        isoDate
    })
    return {
        status = var2.status,
        value = value
    }
end

return useGoalMetricSummary

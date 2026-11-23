-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local LocalizationService = game:GetService("LocalizationService")

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)
local Localization = require(BuildExperienceParent.Localization)
local NumberLocalization = Localization.NumberLocalization
local useLocalization = Localization.Hooks.useLocalization

local IconName = Foundation.Enums.IconName

local DataStatus = require(BuildExperienceParent.DataHydration.CreatorAnalytics).DataStatus
local AnalyticsKeys = require(BuildExperience.Analytics.AnalyticsKeys)
local AnalyticsMetric = require(BuildExperience.Analytics.AnalyticsMetric)
local AnalyticsUnit = require(BuildExperience.Analytics.AnalyticsUnit)
local AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local useMetricMetadata = require(BuildExperience.Analytics.useMetricMetadata)
local useOverviewStats = require(BuildExperience.Analytics.useOverviewStats)
local useInstantStats = require(BuildExperience.Analytics.useInstantStats)
local _StatsCard = require(BuildExperience.Components.Analytics.StatsCard.StatsCard)
local _InstantStatCard = require(script.Parent.InstantStatCard)
local _AnalyticsOverviewView = require(script.Parent.AnalyticsOverviewView)
local metricValueRoundsToZero = require(BuildExperience.Analytics.metricValueRoundsToZero)
local scaleValueToUnit = require(BuildExperience.Analytics.scaleValueToUnit)

local tbl1 = {}
for _, OverviewMetric in AnalyticsMetric.OverviewMetrics do
    table.insert(tbl1, OverviewMetric.id)
end

local noDataPlaceholder = require(BuildExperience.Components.Analytics.noDataPlaceholder)

local function useAnalyticsOverviewViewModel(universeId: number, window, id, metricId, callback: (...any) -> (...any))
    local robloxLocaleId = LocalizationService.RobloxLocaleId

    local var1 = useMetricMetadata(tbl1)
    local var2 = useOverviewStats(universeId, window, var1.latestByMetric)
    local var3 = useInstantStats(universeId)

    local tbl2 = {
        overviewTitle = AnalyticsKeys.ANALYTICS_OVERVIEW_TITLE,
        keyStatsTitle = AnalyticsKeys.ANALYTICS_KEY_STATS_TITLE,
        visits = AnalyticsKeys.ANALYTICS_INSTANT_VISITS,
        players = AnalyticsKeys.ANALYTICS_INSTANT_PLAYERS,
        likes = AnalyticsKeys.ANALYTICS_INSTANT_LIKES,
        [AnalyticsWindow.LastWeek.id] = AnalyticsWindow.LastWeek.labelKey,
        [AnalyticsWindow.LastMonth.id] = AnalyticsWindow.LastMonth.labelKey
    }

    local var4 = table.clone(tbl2)
    for _, overviewMetric in AnalyticsMetric.OverviewMetrics do
        var4[overviewMetric.id] = overviewMetric.titleKey
    end
    local var5 = useLocalization(var4)
    local function copy(str1: string) -- Luacid: Inlined by compiler; 6 call sites recovered
        return var5[str1]
    end
    local function titleFor(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        return var5[arg1.id]
    end

    local statsCards = ({})
    for layoutOrder, overviewMetric in AnalyticsMetric.OverviewMetrics do
        local var6 = var2[overviewMetric.id]
        local statValue = scaleValueToUnit(var6.latest or 0, overviewMetric.unit)
        local bool1 = not (var1.latestByMetric == nil) and var1.latestByMetric[overviewMetric.id] ~= nil
        local isLoading = var1.status == DataStatus.NotReady or var1.status == DataStatus.Ready and bool1 and var6.status == DataStatus.NotReady
        local var8 = if var6.priorValue == nil then nil else scaleValueToUnit(var6.priorValue, overviewMetric.unit)
        local bool3 = var8 == nil or not metricValueRoundsToZero(var8, overviewMetric.unit, nil, robloxLocaleId)
        local deltaValue = if bool3 then var6.trendPct else statValue
        local deltaUnit = if bool3 then AnalyticsUnit.Percent else overviewMetric.unit

        local tbl4 = {
            title = titleFor(overviewMetric),
            statValue = statValue,
            statUnit = overviewMetric.unit,
            statIcon = overviewMetric.icon,
            deltaValue = deltaValue,
            deltaUnit = deltaUnit,
            hasData = var6.hasData,
            isLoading = isLoading,
            isSelected = overviewMetric.id == id,
            onActivated = var6.hasData and function()
                callback(overviewMetric.id)
            end or nil,
            layoutOrder = layoutOrder,
            testId = "stat-" .. overviewMetric.id
        }

        statsCards[layoutOrder] = tbl4
    end

    local label = copy("visits")
    local var6 = copy("players")
    local var7 = copy("likes")

    local instantStats = React.useMemo(function()
        local result = ({})

        for value, value2 in {
            {
                key = "visits",
                label = label,
                icon = IconName.Eye,
                value = var3.visits,
                isLoading = var3.visitsLoading
            },
            {
                key = "players",
                label = var6,
                icon = IconName.ThreePeople,
                value = var3.players,
                isLoading = var3.playersLoading
            },
            {
                key = "likes",
                label = var7,
                icon = IconName.ThumbUp,
                value = var3.likes,
                isLoading = var3.likesLoading
            }
        } do
            local tbl4 = {
                label = value2.label,
                valueText = if value2.value ~= nil then NumberLocalization.localize(value2.value, robloxLocaleId) else noDataPlaceholder,
                icon = value2.icon,
                isLoading = value2.isLoading,
                testId = "instant-" .. value2.key
            }
            result[value] = tbl4
        end

        return result
    end, {
        var3,
        robloxLocaleId,
        label,
        var6,
        var7
    })
    local windows = ({})
    for k, window2 in AnalyticsWindow.Windows do
        local tbl5 = {
            id = window2.id,
            label = copy(window2.id)
        }
        windows[k] = tbl5
    end

    local tbl5 = if metricId == nil or AnalyticsMetric.MetricById[metricId] == nil then nil else {
        metricId = metricId,
        universeId = universeId,
        window = window,
        latestAvailableTime = if var1.latestByMetric == nil then nil else var1.latestByMetric[metricId],
        metadataStatus = var1.status
    }
    return {
        overviewTitle = copy("overviewTitle"),
        keyStatsTitle = copy("keyStatsTitle"),
        instantStats = instantStats,
        statsCards = statsCards,
        windows = windows,
        sheet = tbl5
    }
end

return useAnalyticsOverviewViewModel

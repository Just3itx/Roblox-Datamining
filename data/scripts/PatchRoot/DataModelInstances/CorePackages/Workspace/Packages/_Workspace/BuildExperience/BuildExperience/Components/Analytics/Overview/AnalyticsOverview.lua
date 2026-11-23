-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local AnalyticsEventContext = require(BuildExperience.Analytics.AnalyticsEventContext)
local _AnalyticsMetric = require(BuildExperience.Analytics.AnalyticsMetric)
local _AnalyticsPageEvents = require(BuildExperience.Analytics.AnalyticsPageEvents)
local AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local FFlagBuildCheckGamePermissions = require(BuildExperience.Flags.FFlagBuildCheckGamePermissions)
local FFlagBuildExperienceEventContextTelemetry = require(BuildExperience.Flags.FFlagBuildExperienceEventContextTelemetry)
local AnalyticsOverviewView = require(script.Parent.AnalyticsOverviewView)
local useAnalyticsOverviewViewModel = require(script.Parent.useAnalyticsOverviewViewModel)
local useGamePermissions = require(BuildExperience.useGamePermissions)

local function AnalyticsOverview(tbl1)
    local selectedWindowId, onWindowSelected = React.useState(tbl1.initialWindowId or AnalyticsWindow.DEFAULT_WINDOW_ID)
    local var3, var4 = React.useState(nil)

    local initialMetricId = tbl1.initialMetricId or "UniqueUsersWithPlaySessions"
    local window = AnalyticsWindow.WindowById[selectedWindowId] or AnalyticsWindow.LastWeek

    local var6 = useAnalyticsOverviewViewModel(tbl1.universeId, window, initialMetricId, var3, var4)

    local onSheetClose = React.useCallback(function()
        var4(nil)
    end, {})

    local value = if FFlagBuildExperienceEventContextTelemetry then React.useMemo(function()
        return {
            placeId = tbl1.placeId,
            conversationId = tbl1.conversationId
        }
    end, { tbl1.placeId, tbl1.conversationId }) else nil

    local onOpenChat = tbl1.onOpenChat
    if FFlagBuildCheckGamePermissions and not useGamePermissions({ universeId = tbl1.universeId }).canEditOnBuild then
        onOpenChat = nil
    end

    local element = React.createElement(AnalyticsOverviewView, {
        overviewTitle = var6.overviewTitle,
        keyStatsTitle = var6.keyStatsTitle,
        instantStats = var6.instantStats,
        statsCards = var6.statsCards,
        windows = var6.windows,
        selectedWindowId = selectedWindowId,
        onWindowSelected = onWindowSelected,
        universeId = tbl1.universeId,
        window = window,
        sheet = var6.sheet,
        onSheetClose = onSheetClose,
        onOpenChat = onOpenChat,
        layoutOrder = tbl1.layoutOrder,
        testId = tbl1.testId
    })
    if value ~= nil then
        return (React.createElement(AnalyticsEventContext.Provider, { value = value }, element))
    end
    return element
end

return AnalyticsOverview

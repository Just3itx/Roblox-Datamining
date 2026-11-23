-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)

local _CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local useMetricMetadata = require(BuildExperience.Analytics.useMetricMetadata)
local Goals = require(BuildExperience.Analytics.Goals.Goals)
local useGoalMilestones = require(BuildExperience.Analytics.Goals.useGoalMilestones)
local GoalsSectionView = require(script.Parent.GoalsSectionView)
local useGoalLockedActions = require(script.Parent.useGoalLockedActions)
local useGoalClickTelemetry = require(script.Parent.useGoalClickTelemetry)
local useGoalsSectionTelemetry = require(script.Parent.useGoalsSectionTelemetry)
local useGoalsSectionViewModel = require(script.Parent.useGoalsSectionViewModel)
local _GoalTypes = require(BuildExperience.Analytics.Goals.GoalTypes)
local MetricDetailSheet = require(BuildExperience.Components.Analytics.MetricDetailSheet.MetricDetailSheet)

local tbl1 = {}
local tbl2 = {}
for _, Goal in Goals.Goals do
    for _, value in Goal.metricSummaries do
        if not tbl1[value.source.query.metric] then
            tbl1[value.source.query.metric] = true
            table.insert(tbl2, value.source.query.metric)
        end
    end
    if Goal.charts == nil then
        continue
    end

    for _, chart in Goal.charts do
        if not tbl1[chart.id] then
            tbl1[chart.id] = true
            table.insert(tbl2, chart.id)
        end
    end
end

local function GoalsSection(tbl3)
    local testId = tbl3.testId or "GoalsSection"
    local var1 = useMetricMetadata(tbl2)
    local milestones, var3 = useGoalMilestones(tbl3.universeId)

    local var4, var5 = React.useState(nil)
    local onClose = React.useCallback(function()
        var5(nil)
    end, {})
    local universeId = tbl3.universeId
    local id = tbl3.window.id
    local var7 = useGoalClickTelemetry(universeId)
    local onGoalSelected = React.useCallback(function(arg1)
        var7(arg1.id)
        var5(arg1)
    end, { var7 })

    local var9 = useGoalsSectionViewModel({ goals = Goals.Goals, milestones = milestones, onGoalSelected = onGoalSelected })

    local var10 = useGoalLockedActions(tbl3.universeId)
    local tbl4 = ({})
    local bool1 = false
    for k, action in var10.actions do
        tbl4[k] = action.overlay
        bool1 = bool1 or action.isLoading == true
    end
    local var11 = var3 and not bool1
    useGoalsSectionTelemetry(universeId, id, var11, var9)

    local goals = React.createElement(GoalsSectionView, {
        entries = not var11 and {} or var9,
        universeId = tbl3.universeId,
        window = tbl3.window,
        latestByMetric = var1.latestByMetric,
        metadataStatus = var1.status,
        lockedActions = var10.actions,
        layoutOrder = tbl3.layoutOrder,
        testId = testId
    })
    return React.createElement(React.Fragment, nil, {
        Goals = goals,
        ActionOverlays = React.createElement(React.Fragment, nil, tbl4),
        Sheet = if var4 == nil then nil else React.createElement(MetricDetailSheet, {
            metrics = var4.charts,
            titleKey = var4.titleKey,
            universeId = tbl3.universeId,
            window = tbl3.window,
            latestByMetric = var1.latestByMetric,
            metadataStatus = var1.status,
            onClose = onClose,
            onOpenChat = tbl3.onOpenChat,
            testId = `{testId}.Sheet`
        })
    })
end

return GoalsSection

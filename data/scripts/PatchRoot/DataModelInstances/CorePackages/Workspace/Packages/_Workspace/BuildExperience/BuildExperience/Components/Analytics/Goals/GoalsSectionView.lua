-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local View = require(BuildExperienceParent.Foundation).View

local _CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local GoalCard = require(script.Parent.GoalCard)
local _GoalTypes = require(BuildExperience.Analytics.Goals.GoalTypes)
local _useGoalsSectionViewModel = require(script.Parent.useGoalsSectionViewModel)

local function GoalsSectionView(tbl1)
    local testId = tbl1.testId or "GoalsSection"

    local tbl2 = ({})
    for _, value in tbl1.entries do
        local goal = value.goal
        local id = goal.id
        tbl2[id] = React.createElement(GoalCard, {
            onActivated = value.onActivated,
            goal = goal,
            universeId = tbl1.universeId,
            window = tbl1.window,
            latestByMetric = tbl1.latestByMetric,
            metadataStatus = tbl1.metadataStatus,
            isLocked = value.isLocked,
            lockedActions = tbl1.lockedActions,
            layoutOrder = value.layoutOrder,
            testId = `{testId}.{goal.id}`
        })
    end

    return React.createElement(
        View,
        {
            LayoutOrder = tbl1.layoutOrder,
            tag = "col gap-xxlarge size-full-0 auto-y",
            testId = testId
        },
        tbl2
    )
end

return GoalsSectionView

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local React = require(BuildExperienceParent.React)
local Foundation = require(BuildExperienceParent.Foundation)
local useLocalization = require(BuildExperienceParent.Localization).Hooks.useLocalization

local View = Foundation.View
local FoundationText = Foundation.Text

local _CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local _AnalyticsWindow = require(BuildExperience.Analytics.AnalyticsWindow)
local _GoalTypes = require(BuildExperience.Analytics.Goals.GoalTypes)
local GoalLockedContent = require(script.Parent.GoalLockedContent)
local GoalMetricRow = require(script.Parent.GoalMetricRow)

local function GoalCard(tbl1)
    local testId = tbl1.testId or "GoalCard"
    local goal = tbl1.goal

    local tbl2 = {
        title = goal.titleKey
    }

    for _, value in goal.metricSummaries do
        tbl2[value.id] = value.titleKey
    end
    local var1 = useLocalization(tbl2)

    local tbl3 = ({})
    for layoutOrder, summary in goal.metricSummaries do
        local latestAvailableTime = if tbl1.latestByMetric == nil then nil else tbl1.latestByMetric[summary.source.query.metric]
        local id = summary.id
        tbl3[id] = React.createElement(GoalMetricRow, {
            title = var1[summary.id],
            universeId = tbl1.universeId,
            summary = summary,
            window = tbl1.window,
            latestAvailableTime = latestAvailableTime,
            metadataStatus = tbl1.metadataStatus,
            layoutOrder = layoutOrder,
            testId = `{testId}.{summary.id}`
        })
    end

    local createElement = React.createElement
    local var2 = View
    local tbl4 = {
        LayoutOrder = tbl1.layoutOrder,
        tag = "col gap-large size-full-0 auto-y",
        testId = testId
    }
    local tbl5 = {
        Heading = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = var1.title,
            tag = "size-full-0 auto-y text-heading-small text-align-x-left content-emphasis",
            testId = `{testId}.Heading`
        }),
        Card = React.createElement(
            View,
            {
                LayoutOrder = 2,
                onActivated = if tbl1.isLocked then nil else tbl1.onActivated,
                tag = "col gap-large size-full-0 auto-y padding-large stroke-standard stroke-default radius-large",
                testId = `{testId}.Card`
            },
            tbl1.isLocked
                and {
                    Locked = React.createElement(GoalLockedContent, {
                        locked = goal.locked,
                        actionHandlers = tbl1.lockedActions,
                        goalId = goal.id,
                        universeId = tbl1.universeId,
                        testId = `{testId}.Locked`
                    })
                }
                or tbl3
        )
    }
    return createElement(var2, tbl4, tbl5)
end

return GoalCard

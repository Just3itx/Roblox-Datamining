-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:11:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local GoalMetricRowView = require(script.Parent.GoalMetricRowView)
local useGoalMetricRowViewModel = require(script.Parent.useGoalMetricRowViewModel)

local function GoalMetricRow(arg1)
    local var1 = useGoalMetricRowViewModel(arg1)
    return React.createElement(GoalMetricRowView, var1)
end

return GoalMetricRow

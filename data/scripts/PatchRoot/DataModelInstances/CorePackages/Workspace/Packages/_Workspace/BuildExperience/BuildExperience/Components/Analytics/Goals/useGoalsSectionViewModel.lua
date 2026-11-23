-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local BuildExperienceParent = BuildExperience.Parent

local Cryo = require(BuildExperienceParent.Cryo)

local _CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)
local _GoalTypes = require(BuildExperience.Analytics.Goals.GoalTypes)

local function isReached(tbl1, milestones) -- Luacid: Inlined by compiler; 2 call sites recovered
    return tbl1.requiredMilestone == nil or milestones[tbl1.requiredMilestone]
end

local function withReachedMilestoneItems(arg1, milestones)
    local function func1(arg2) -- Luacid: Inlined by compiler; 1 call site recovered
        return (isReached(arg2, milestones))
    end

    local metricSummaries = Cryo.List.filter(arg1.metricSummaries, func1)

    local charts = arg1.charts

    local var1 = if charts == nil then nil else Cryo.List.filter(charts, function(arg2)
        return (func1(arg2))
    end)

    if #metricSummaries == #arg1.metricSummaries and (var1 == nil or charts == nil or #var1 == #charts) then
        return arg1
    end
    return Cryo.Dictionary.join(arg1, { metricSummaries = metricSummaries, charts = var1 })
end

local function useGoalsSectionViewModel(tbl1)
    local result = {}

    local bool1 = false
    for layoutOrder, goal in tbl1.goals do
        local var1 = withReachedMilestoneItems(goal, tbl1.milestones)
        bool1 = bool1 or not tbl1.milestones[var1.unlockMilestone]

        local onGoalSelected = tbl1.onGoalSelected
        local onActivated = onGoalSelected ~= nil and var1.charts ~= nil and #var1.charts > 0 and function()
            onGoalSelected(var1)
        end or nil

        table.insert(result, { goal = var1, isLocked = bool1, layoutOrder = layoutOrder, onActivated = onActivated })
    end

    return result
end

return useGoalsSectionViewModel

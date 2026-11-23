-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local SignalsReact = require(BuildExperienceParent.SignalsReact)

local CreatorAnalytics = require(BuildExperienceParent.DataHydration.CreatorAnalytics)

local tbl1 = {}

local function useGoalMilestones(num1: number)
    local var1 = CreatorAnalytics.getGoalMilestonesStore(false).getAndFetchGoalMilestones(num1)
    local var2 = SignalsReact.useSignalState(var1.data)
    local var3 = SignalsReact.useSignalState(var1.status)
    return var2 or tbl1, var2 ~= nil or var3 == "Failed"
end

return useGoalMilestones

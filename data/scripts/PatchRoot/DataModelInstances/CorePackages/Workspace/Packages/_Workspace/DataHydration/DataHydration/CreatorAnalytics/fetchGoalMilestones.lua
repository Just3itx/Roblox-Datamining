-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local UrlBase = require(DataHydrationParent.UrlBuilder).UrlBase

local FStringBuildAnalyticsGoalMilestonesFeatureName = require(script.Parent.FStringBuildAnalyticsGoalMilestonesFeatureName)
local _GoalMilestonesTypes = require(script.Parent.GoalMilestonesTypes)

local function toMilestones(tbl1, name: string)
    local result = ({})

    for _, value in tbl1.features or {} do
        if value.name ~= name then
            continue
        end

        for value2, value3 in value.values or {} do
            result[value2] = string.lower(value3) == "true"
        end
    end

    return result
end

local function fetchGoalMilestones(num1: number, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.baseUrl or UrlBase.APIS
    local var2 = FStringBuildAnalyticsGoalMilestonesFeatureName

    local var3 = HttpClient.fetch({
        method = "GET",
        url = `{var1}/analytics-features/v1/universes/{num1}/features?featureNames={var2}`,
        analyticsKey = "analytics-features.goal-milestones.get",
        network = tbl2.network,
        decode = function(arg1)
            return (toMilestones(arg1, var2))
        end
    })

    return HttpClient.asPromise(var3)
end

return fetchGoalMilestones

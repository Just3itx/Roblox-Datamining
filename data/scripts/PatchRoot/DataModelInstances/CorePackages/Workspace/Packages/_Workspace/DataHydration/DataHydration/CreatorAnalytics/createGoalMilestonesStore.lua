-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local fetchGoalMilestones = require(script.Parent.fetchGoalMilestones)
local _GoalMilestonesTypes = require(script.Parent.GoalMilestonesTypes)

local function createGoalMilestonesStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local cache = createDataCache(tbl2.ttlSeconds)

    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(str1: string, _)
            return fetchGoalMilestones(tonumber(str1), tbl3)
        end
    })

    return {
        getAndFetchGoalMilestones = function(num1: number)
            return (dataResolver.getAndFetchItem(tostring(num1)))
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createGoalMilestonesStore

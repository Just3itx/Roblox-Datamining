-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)

local fetchCreatorEligibility = require(script.Parent.fetchCreatorEligibility)
local _CreatorEligibilityStoreTypes = require(script.Parent.CreatorEligibilityStoreTypes)

local function createCreatorEligibilityStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return fetchCreatorEligibility.fetchEligibility(num1, tbl3)
    end)

    return {
        getEligibility = singleEntityResolver.get,
        fetchEligibility = singleEntityResolver.fetch,
        getAndFetchEligibility = singleEntityResolver.getAndFetch,
        updateEligibility = singleEntityResolver.update,
        clear = singleEntityResolver.clear,
        dispose = singleEntityResolver.dispose
    }
end

return createCreatorEligibilityStore

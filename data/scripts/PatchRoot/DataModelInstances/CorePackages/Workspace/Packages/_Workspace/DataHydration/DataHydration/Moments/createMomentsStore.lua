-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local _MomentsStoreTypes = require(script.Parent.MomentsStoreTypes)
local fetchMomentsByIds = require(script.Parent.Requests.fetchMomentsByIds)

local function createMomentsStore(arg1)
    local var1 = arg1 or {}

    return {
        getMomentsByIds = function(tbl1, str1: string?)
            return HttpClient.asPromise(fetchMomentsByIds(tbl1, var1.network, str1))
        end
    }
end
return createMomentsStore

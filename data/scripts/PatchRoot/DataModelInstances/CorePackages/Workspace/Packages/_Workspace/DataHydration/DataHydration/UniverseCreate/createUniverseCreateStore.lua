-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:21:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local fetchUniverseCreate = require(script.Parent.fetchUniverseCreate)
local _UniverseCreateStoreTypes = require(script.Parent.UniverseCreateStoreTypes)
local UniverseSearch = require(DataHydration.UniverseSearch)

local function createUniverseCreateStore(tbl1)
    local tbl2 = tbl1 or {}
    local var1 = tbl2.getSearchStore or function()
        return UniverseSearch.getUniverseSearchStore()
    end

    return {
        createUniverse = function(arg1)
            return fetchUniverseCreate(arg1, { network = tbl2.network, baseUrl = tbl2.baseUrl }):andThen(function<T>(arg2: T): T
                var1().invalidateAll()
                return arg2
            end)
        end
    }
end

return createUniverseCreateStore

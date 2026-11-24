-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)

local fetchExperienceGuidelines = require(script.Parent.fetchExperienceGuidelines)
local syncGuidelinesAgeToGameStores = require(script.Parent.syncGuidelinesAgeToGameStores).syncGuidelinesAgeToGameStores
local _ExperienceGuidelinesStoreTypes = require(script.Parent.ExperienceGuidelinesStoreTypes)

local function createExperienceGuidelinesStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return fetchExperienceGuidelines.fetchDetailedGuidelines(num1, tbl3):andThen(function<T>(arg1: T): T
            syncGuidelinesAgeToGameStores(num1, arg1)
            return arg1
        end)
    end)

    return {
        getDetailedGuidelines = singleEntityResolver.get,
        fetchDetailedGuidelines = singleEntityResolver.fetch,
        refreshDetailedGuidelines = function(num1: number)
            return fetchExperienceGuidelines.fetchDetailedGuidelines(num1, tbl3):andThen(function<T>(arg1: T): T
                singleEntityResolver.cache.replaceItem(tostring(num1), arg1)
                syncGuidelinesAgeToGameStores(num1, arg1)
                return arg1
            end)
        end,
        getAndFetchDetailedGuidelines = singleEntityResolver.getAndFetch,
        updateDetailedGuidelines = function(num1: number, arg1)
            singleEntityResolver.update(num1, arg1)
            syncGuidelinesAgeToGameStores(num1, arg1)
        end,
        clear = singleEntityResolver.clear,
        dispose = singleEntityResolver.dispose
    }
end

return createExperienceGuidelinesStore

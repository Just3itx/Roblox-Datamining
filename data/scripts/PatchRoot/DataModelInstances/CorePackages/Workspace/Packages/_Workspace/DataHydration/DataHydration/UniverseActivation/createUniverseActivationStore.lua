-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)

local fetchUniverseActivation = require(script.Parent.fetchUniverseActivation)
local _UniverseActivationStoreTypes = require(script.Parent.UniverseActivationStoreTypes)

local function createUniverseActivationStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return fetchUniverseActivation.fetchEligibility(num1, tbl3)
    end)
    local singleEntityResolver2 = createSingleEntityResolver(function(num1: number)
        return fetchUniverseActivation.fetchAudiences(num1, tbl3)
    end)

    return {
        getEligibility = singleEntityResolver.get,
        fetchEligibility = singleEntityResolver.fetch,
        getAndFetchEligibility = singleEntityResolver.getAndFetch,
        refreshEligibility = function(num1: number)
            return fetchUniverseActivation.fetchEligibility(num1, tbl3):andThen(function<T>(arg1: T): T
                singleEntityResolver.cache.replaceItem(tostring(num1), arg1)
                return arg1
            end)
        end,
        updateEligibility = singleEntityResolver.update,
        activate = function(num1: number, arg1)
            return fetchUniverseActivation.activate(num1, arg1, tbl3):andThen(function<T>(arg2: T): T
                singleEntityResolver.fetch(num1)
                return arg2
            end)
        end,
        deactivate = function(num1: number)
            return fetchUniverseActivation.deactivate(num1, tbl3):andThen(function<T>(arg1: T): T
                singleEntityResolver.fetch(num1)
                return arg1
            end)
        end,
        setAudiences = function(num1: number, tbl4)
            return fetchUniverseActivation.setAudiences(num1, tbl4, tbl3):andThen(function<T>(arg1: T): T
                singleEntityResolver2.update(num1, arg1)
                return arg1
            end)
        end,
        getAudiences = singleEntityResolver2.get,
        fetchAudiences = singleEntityResolver2.fetch,
        getAndFetchAudiences = singleEntityResolver2.getAndFetch,
        clear = function()
            singleEntityResolver.clear()
            singleEntityResolver2.clear()
        end,
        dispose = function()
            singleEntityResolver.dispose()
            singleEntityResolver2.dispose()
        end
    }
end
return createUniverseActivationStore

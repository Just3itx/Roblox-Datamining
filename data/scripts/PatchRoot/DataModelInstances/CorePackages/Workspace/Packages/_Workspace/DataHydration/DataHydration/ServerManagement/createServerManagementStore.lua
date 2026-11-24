-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)

local fetchServerManagement = require(script.Parent.fetchServerManagement)
local _ServerManagementStoreTypes = require(script.Parent.ServerManagementStoreTypes)

local function createServerManagementStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return fetchServerManagement.fetchListRestartStatuses(num1, tbl3)
    end)
    local singleEntityResolver2 = createSingleEntityResolver(function(num1: number)
        return fetchServerManagement.fetchForecastRestart(num1, tbl3)
    end)

    return {
        getRestartStatuses = singleEntityResolver.get,
        fetchRestartStatuses = singleEntityResolver.fetch,
        getAndFetchRestartStatuses = singleEntityResolver.getAndFetch,
        getForecast = singleEntityResolver2.get,
        fetchForecast = singleEntityResolver2.fetch,
        getAndFetchForecast = singleEntityResolver2.getAndFetch,
        launchRestart = function(num1: number, arg1)
            return fetchServerManagement.launchRestart(num1, arg1, tbl3):andThen(function<T>(arg2: T): T
                singleEntityResolver.fetch(num1)
                return arg2
            end)
        end,
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
return createServerManagementStore

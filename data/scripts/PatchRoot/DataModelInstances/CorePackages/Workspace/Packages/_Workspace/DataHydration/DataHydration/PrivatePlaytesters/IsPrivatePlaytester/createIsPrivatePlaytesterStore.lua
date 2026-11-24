-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)

local fetchIsPrivatePlaytester = require(script.Parent.fetchIsPrivatePlaytester)
local _IsPrivatePlaytesterStoreTypes = require(script.Parent.IsPrivatePlaytesterStoreTypes)

local function createIsPrivatePlaytesterStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return fetchIsPrivatePlaytester(num1, tbl3)
    end)

    return {
        get = singleEntityResolver.get,
        fetch = singleEntityResolver.fetch,
        getAndFetch = singleEntityResolver.getAndFetch,
        update = singleEntityResolver.update,
        clear = singleEntityResolver.clear,
        dispose = singleEntityResolver.dispose
    }
end

return createIsPrivatePlaytesterStore

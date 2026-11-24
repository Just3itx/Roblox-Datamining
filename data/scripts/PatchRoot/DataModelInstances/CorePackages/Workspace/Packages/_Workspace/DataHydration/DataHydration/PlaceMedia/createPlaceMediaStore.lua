-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local _HttpClient = require(DataHydrationParent.HttpClient)

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)

local fetchPlaceMedia = require(script.Parent.fetchPlaceMedia)
local _PlaceMediaStoreTypes = require(script.Parent.PlaceMediaStoreTypes)

local function createPlaceMediaStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return fetchPlaceMedia.fetchMedia(num1, tbl3)
    end)

    return {
        getMedia = singleEntityResolver.get,
        fetchMedia = singleEntityResolver.fetch,
        getAndFetchMedia = singleEntityResolver.getAndFetch,
        updateMedia = singleEntityResolver.update,
        clear = singleEntityResolver.clear,
        dispose = singleEntityResolver.dispose
    }
end

return createPlaceMediaStore

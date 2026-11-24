-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Dash = require(DataHydrationParent.Dash)
local _HttpClient = require(DataHydrationParent.HttpClient)

local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local fetchPlaceDetails = require(script.Parent.fetchPlaceDetails)
local _PlaceDetailsStoreTypes = require(script.Parent.PlaceDetailsStoreTypes)

local function createPlaceDetailsStore(tbl1)
    local tbl2 = tbl1 or {}
    local tbl3 = {
        network = tbl2.network,
        baseUrl = tbl2.baseUrl
    }
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        replaceItems = true,
        requestBatchSize = 50,
        queueProcessDelaySec = tbl2.queueProcessDelaySec or 0.05,
        fetchFn = function(tbl4)
            return fetchPlaceDetails(Dash.keys(tbl4), tbl3):andThen(function(tbl5)
                local result = ({})

                for _, value in tbl5 or {} do
                    if not (value and value.placeId) then
                        continue
                    end

                    local str1 = tostring(value.placeId)
                    local tbl6 = {
                        universeId = if value.universeId then tostring(value.universeId) else nil,
                        name = value.name
                    }
                    result[str1] = tbl6
                end

                return result
            end)
        end
    })

    return {
        getPlaceDetails = dataResolver.getCachedItem,
        getAndFetchPlaceDetails = function(str1: string)
            return (dataResolver.getAndFetchItem(str1))
        end,
        updatePlaceDetails = function(str1: string, arg1)
            cache.replaceItems({ [str1] = arg1 })
        end,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createPlaceDetailsStore

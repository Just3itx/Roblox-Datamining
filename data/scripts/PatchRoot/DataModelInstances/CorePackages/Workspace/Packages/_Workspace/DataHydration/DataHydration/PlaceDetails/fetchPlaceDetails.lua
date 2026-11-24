-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local Url = require(DataHydrationParent.Http).Url

local _PlaceDetailsStoreTypes = require(script.Parent.PlaceDetailsStoreTypes)

local fetch = HttpClient.fetch
local asPromise = HttpClient.asPromise

local function placeDetailsUrl(str1: string, tbl1): string -- Luacid: Inlined by compiler; 1 call site recovered
    return ("%sv1/games/multiget-place-details?placeIds=%s"):format(str1, table.concat(tbl1, "&placeIds="))
end

local function fetchPlaceDetails(tbl1, tbl2)
    local tbl3 = tbl2 or {}

    local var1 = fetch({
        network = tbl3.network,
        method = "GET",
        url = placeDetailsUrl(tbl3.baseUrl or Url.GAME_URL, tbl1),
        analyticsKey = "place-details.multiget",
        legacy = true,
        decode = function<T>(arg1: T): T
            return arg1
        end
    })
    return asPromise(var1)
end

return fetchPlaceDetails

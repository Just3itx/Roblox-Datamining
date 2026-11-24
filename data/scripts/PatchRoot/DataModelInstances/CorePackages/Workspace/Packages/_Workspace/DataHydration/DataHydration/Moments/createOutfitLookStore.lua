-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:41:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local createSingleEntityResolver = require(DataHydration.createSingleEntityResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local fetchLookByOutfit = require(script.Parent.Requests.fetchLookByOutfit)

local function createOutfitLookStore(arg1)
    local singleEntityResolver = createSingleEntityResolver(function(num1: number)
        return fetchLookByOutfit(num1, arg1)
    end, {
        resolver = { replaceItems = true }
    })

    return {
        getCachedLookByOutfit = singleEntityResolver.get,
        getAndFetchLookByOutfit = singleEntityResolver.getAndFetch,
        clear = singleEntityResolver.clear,
        dispose = singleEntityResolver.dispose
    }
end

return createOutfitLookStore

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local _ConnectionsPlayedStoreTypes = require(script.Parent.ConnectionsPlayedStoreTypes)

local function createConnectionsPlayedStore()
    local dataCache = createDataCache()

    return {
        getConnectionsPlayed = dataCache.getItem,
        updateItems = dataCache.updateItems,
        clear = dataCache.clear
    }
end

return createConnectionsPlayedStore

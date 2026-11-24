-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local _GameSubscriptionStoreTypes = require(script.Parent.GameSubscriptionStoreTypes)

local function createGameSubscriptionStore()
    local dataCache = createDataCache()

    return {
        getGameSubscriptionInfo = dataCache.getItem,
        updateGameSubscriptionInfo = dataCache.updateItem,
        updateGameSubscriptionInfos = dataCache.updateItems,
        clear = dataCache.clear,
        dispose = dataCache.dispose
    }
end

return createGameSubscriptionStore

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:10:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local _BuyRobuxStoreTypes = require(script.Parent.BuyRobuxStoreTypes)

local function createBuyRobuxStore()
    local dataCache = createDataCache()

    return {
        getInfo = dataCache.getItem,
        updateInfos = dataCache.replaceItems,
        clear = dataCache.clear,
        dispose = dataCache.dispose
    }
end

return createBuyRobuxStore

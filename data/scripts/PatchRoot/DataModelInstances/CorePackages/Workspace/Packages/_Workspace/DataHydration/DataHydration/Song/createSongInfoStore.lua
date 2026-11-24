-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)

local function createSongInfoStore()
    local dataCache = createDataCache()

    return {
        getSongInfo = dataCache.getItem,
        updateSongs = dataCache.updateItems
    }
end

return createSongInfoStore

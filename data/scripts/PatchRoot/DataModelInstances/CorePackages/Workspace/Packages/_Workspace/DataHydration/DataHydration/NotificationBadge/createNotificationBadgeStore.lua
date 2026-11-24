-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Promise = require(DataHydrationParent.Promise)

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _NotificationBadgeStoreTypes = require(script.Parent.NotificationBadgeStoreTypes)
local createDataResolver = require(DataHydration.createDataResolver)

local function createNotificationBadgeStore()
    local cache = createDataCache()

    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(_)
            return Promise.resolve({})
        end
    })

    return {
        getNotificationBadge = dataResolver.getCachedItem,
        getNotificationBadges = dataResolver.getCachedItems,
        updateNotificationBadge = cache.updateItem,
        updateNotificationBadges = cache.updateItems,
        clear = dataResolver.clear,
        dispose = dataResolver.dispose
    }
end

return createNotificationBadgeStore

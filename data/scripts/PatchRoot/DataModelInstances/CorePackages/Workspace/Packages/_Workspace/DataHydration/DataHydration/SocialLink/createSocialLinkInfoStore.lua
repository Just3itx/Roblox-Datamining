-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Promise = require(DataHydrationParent.Promise)

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _SocialLinkInfoStoreTypes = require(script.Parent.SocialLinkInfoStoreTypes)
local createDataResolver = require(DataHydration.createDataResolver)

local function createSocialLinkInfoStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(_)
            return Promise.resolve({})
        end
    })

    return {
        getSocialLinkInfo = dataResolver.getCachedItem,
        getSocialLinkInfos = dataResolver.getCachedItems,
        updateSocialLinkInfo = cache.updateItem,
        updateSocialLinkInfos = cache.updateItems,
        clear = cache.clear,
        dispose = cache.dispose
    }
end

return createSocialLinkInfoStore

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:11:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent
local Promise = require(DataHydrationParent.Promise)

local createDataCache = require(DataHydration.createDataCache)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _CollectibleItemStoreTypes = require(script.Parent.CollectibleItemStoreTypes)
local createDataResolver = require(DataHydration.createDataResolver)

local function normalizeCreator(creator)
    return {
        id = creator.id,
        name = creator.name,
        type = creator.type,
        targetId = if creator.targetId ~= nil then creator.targetId else creator.target_id,
        hasVerifiedBadge = if creator.hasVerifiedBadge ~= nil then creator.hasVerifiedBadge else creator.has_verified_badge
    }
end

local function normalizeExperiences(experiences)
    if not experiences then
        return nil
    end
    local var1 = table.create(#experiences)
    for _, value in experiences do
        table.insert(var1, {
            id = value.id,
            name = value.name,
            detailPageLink = if value.detailPageLink ~= nil then value.detailPageLink else value.detail_page_link
        })
    end

    return var1
end

local function normalizeCollectibleItem(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if not (arg1.creator or arg1.experiences) then
        return arg1
    end
    local var1 = table.clone(arg1)
    if arg1.creator then
        var1.creator = normalizeCreator(arg1.creator)
    end
    if arg1.experiences then
        var1.experiences = normalizeExperiences(arg1.experiences)
    end
    return var1
end

local function createCollectibleItemStore()
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        fetchFn = function(_)
            return Promise.resolve({})
        end
    })

    return {
        getCollectibleItemInfo = dataResolver.getCachedItem,
        getCollectibleItemInfos = dataResolver.getCachedItems,
        getNormalizedCollectibleItemInfo = function(str1: string)
            local cachedItem = dataResolver.getCachedItem(str1)
            return {
                data = function(arg1)
                    local var1 = cachedItem.data(arg1)
                    if var1 then
                        return normalizeCollectibleItem(var1)
                    end

                    return nil
                end,
                status = cachedItem.status
            }
        end,
        updateCollectibleItemInfo = cache.updateItem,
        updateCollectibleItemInfos = cache.updateItems,
        clear = cache.clear,
        dispose = cache.dispose
    }
end

return createCollectibleItemStore

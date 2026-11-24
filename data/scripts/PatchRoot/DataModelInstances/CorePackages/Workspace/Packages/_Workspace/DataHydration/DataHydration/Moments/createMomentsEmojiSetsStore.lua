-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local Promise = require(DataHydrationParent.Promise)
local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local createDataCache = require(DataHydration.createDataCache)
local createDataResolver = require(DataHydration.createDataResolver)
local _DataHydrationTypes = require(DataHydration.DataHydrationTypes)
local _MomentsStoreTypes = require(script.Parent.MomentsStoreTypes)
local getEmojiSets = require(script.Parent.Requests.getEmojiSets)
local decodeEmojiSets = require(script.Parent.Util.decodeEmojiSets)
local resolveMomentsEmojiCatalog = require(script.Parent.Util.resolveMomentsEmojiCatalog)
local validateMomentsEmojiCatalog = require(script.Parent.Util.validateMomentsEmojiCatalog)

local function shouldRefreshCachedEmojiSets(arg1): boolean
    return arg1 == nil
end

local function createMomentsEmojiSetsStore(arg1)
    local var1 = arg1 or {}
    local cache = createDataCache()
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        replaceItems = true,
        fetchFn = function(_: string, _)
            return HttpClient.asPromise(getEmojiSets(var1.network)):andThen(function(arg2)
                if not validateMomentsEmojiCatalog.isValidCachedGetEmojiSetsResponse(arg2) then
                    return Promise.reject("Moments emoji-api returned an invalid or empty catalog")
                end
                return arg2
            end)
        end
    })

    return {
        getAndFetchEmojiSets = function()
            return dataResolver.getAndFetchItem("emoji-sets", shouldRefreshCachedEmojiSets)
        end,
        getEmojis = function(arg2)
            local var2 = dataResolver.getCachedItem("emoji-sets").data(arg2)
            return resolveMomentsEmojiCatalog.resolveMomentsEmojiCatalog(var2).emojis
        end,
        getCachedEmojiCatalog = function(arg2)
            local cachedItem = dataResolver.getCachedItem("emoji-sets")
            local var2 = cachedItem.data(arg2)

            if validateMomentsEmojiCatalog.isValidCachedGetEmojiSetsResponse(var2) then
                return {
                    emojis = decodeEmojiSets.flattenEmojis(var2),
                    source = "cache",
                    status = cachedItem.status(arg2)
                }
            end

            return {
                emojis = {},
                source = "unavailable",
                status = cachedItem.status(arg2)
            }
        end,
        dispose = function()
            dataResolver.dispose()
        end
    }
end
return createMomentsEmojiSetsStore

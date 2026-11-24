-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local HttpClient = require(DataHydrationParent.HttpClient)
local Promise = require(DataHydrationParent.Promise)
local _MomentsTypes = require(DataHydrationParent.MomentsTypes)
local _MomentsStoreTypes = require(script.Parent.MomentsStoreTypes)
local reactToFeedItem = require(script.Parent.Requests.reactToFeedItem)
local reactToFeedItemV2 = require(script.Parent.Requests.reactToFeedItemV2)
local createMomentsEmojiSetsStore = require(script.Parent.createMomentsEmojiSetsStore)
local FFlagMomentsEmojiSetsApi = require(script.Parent.FFlagMomentsEmojiSetsApi)
local FFlagMomentsComments = require(DataHydrationParent.SharedFlags).FFlagMomentsComments

local function createMomentsReactionsStore(arg1)
    local var1 = arg1 or {}

    local function reactToFeedItem2(arg2)
        return HttpClient.asPromise(reactToFeedItem(arg2, var1.network))
    end

    local function reactToFeedItemV2_2(arg2)
        return HttpClient.asPromise(reactToFeedItemV2(arg2, var1.network)):catch(function(arg3)
            warn(`[Moments] Failed to react to feed item (v2): {tostring(arg3)}`)
            return Promise.reject(arg3)
        end)
    end

    if not (FFlagMomentsEmojiSetsApi or FFlagMomentsComments) then
        return { reactToFeedItem = reactToFeedItem2 }
    end

    local momentsEmojiSetsStore = createMomentsEmojiSetsStore(var1)
    local tbl1 = {
        reactToFeedItem = reactToFeedItem2,
        getAndFetchEmojiSets = momentsEmojiSetsStore.getAndFetchEmojiSets
    }
    if FFlagMomentsComments then
        tbl1.getCachedEmojiCatalog = momentsEmojiSetsStore.getCachedEmojiCatalog
    end
    if FFlagMomentsEmojiSetsApi then
        tbl1.reactToFeedItemV2 = reactToFeedItemV2_2

        tbl1.getEmojis = momentsEmojiSetsStore.getEmojis
    end
    return tbl1
end

return createMomentsReactionsStore

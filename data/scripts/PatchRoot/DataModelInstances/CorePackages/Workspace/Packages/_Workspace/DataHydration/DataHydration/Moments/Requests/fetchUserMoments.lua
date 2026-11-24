-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DataHydration = script:FindFirstAncestor("DataHydration")
local DataHydrationParent = DataHydration.Parent

local Http = require(DataHydrationParent.Http)
local HttpClient = require(DataHydrationParent.HttpClient)
local SharedFlags = require(DataHydrationParent.SharedFlags)
local _MomentsStoreTypes = require(DataHydration.Moments.MomentsStoreTypes)
local convertApiMomentsToMomentItems = require(DataHydration.Moments.Util.convertApiMomentsToMomentItems)
local extractCommentsByFeedItemId = require(DataHydration.Moments.Util.extractCommentsByFeedItemId)
local extractReactionsByMomentId = require(DataHydration.Moments.Util.extractReactionsByMomentId)
local extractShareInfoByMomentId = require(DataHydration.Moments.Util.extractShareInfoByMomentId)
local constructApiUrl = require(DataHydration.Moments.Util.constructApiUrl)

local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagMomentsResolvePublishedPostFeedItem = SharedFlags.FFlagMomentsResolvePublishedPostFeedItem

local function collectExcludedMomentIds(arg1)
    local var1 = table.clone(arg1.moderatedMomentIds or {})
    for _, value in arg1.failedMomentIds or {} do
        table.insert(var1, value)
    end
    return var1
end

local function fetchUserMoments(targetUserId: number, paginationContext: string?, network)
    local var1, headers = constructApiUrl("content-captures-api/v2/moments/get-users-moments")
    local url = `{var1}?{Http.Url:makeQueryString({ targetUserId = targetUserId, count = 18, paginationContext = paginationContext })}`

    return HttpClient.fetch({
        method = "GET",
        url = url,
        headers = headers,
        analyticsKey = "moments.get-users-moments",
        network = network,
        decode = function(arg1)
            local items = arg1.items
            local bool1 = not (items == nil) and #items >= 18
            return {
                moments = convertApiMomentsToMomentItems(items),
                nextCursor = if bool1 then arg1.paginationContext or paginationContext else nil,
                reactionsByMomentId = extractReactionsByMomentId(items),
                shareInfoByMomentId = extractShareInfoByMomentId(items),
                commentsByFeedItemId = if FFlagMomentsComments then extractCommentsByFeedItemId(items) else nil,
                excludedMomentIds = if FFlagMomentsResolvePublishedPostFeedItem then collectExcludedMomentIds(arg1) else nil
            }
        end
    })
end

return fetchUserMoments

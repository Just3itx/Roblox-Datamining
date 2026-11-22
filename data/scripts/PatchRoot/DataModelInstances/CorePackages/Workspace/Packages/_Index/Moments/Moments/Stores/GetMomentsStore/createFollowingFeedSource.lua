-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local SharedFlags = require(MomentsParent.SharedFlags)

local _Feed = require(Moments.Components.Feed)
local Analytics = MomentsCommon.Analytics
local RecommendationSource = MomentsCommon.Analytics.RecommendationSource

local MomentsGetMomentsFollowingStore = require(MomentsParent.DataHydration.MomentsGetMomentsFollowingStore)
local MomentsGetPostAssetStore = require(MomentsParent.DataHydration.MomentsGetPostAssetStore)
local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)
local hydrateAvatarMomentFeedItems = require(script.Parent.hydrateAvatarMomentFeedItems)
local shouldShowMomentInFeed = require(script.Parent.shouldShowMomentInFeed)
local reportUnavailableFeedItem = require(script.Parent.reportUnavailableFeedItem)
local GetReactionsStore = require(Moments.Stores.GetReactionsStore)
local GetShareCountsStore = require(Moments.Stores.GetShareCountsStore)
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagMomentsRenderAvatarPostsInFeed = SharedFlags.FFlagMomentsRenderAvatarPostsInFeed
local MomentsGetMomentsCommentsStore = if FFlagMomentsComments then require(MomentsParent.DataHydration.MomentsGetMomentsCommentsStore) else nil

local function createFollowingFeedSource(tbl1)
    local tbl2 = tbl1 or {}
    local var1 = if tbl2.followingStore ~= nil then tbl2.followingStore else MomentsGetMomentsFollowingStore(false)
    local var2 = nil
    if FFlagMomentsComments then
        var2 = tbl2.commentsStore
        if var2 == nil and MomentsGetMomentsCommentsStore ~= nil then
            var2 = MomentsGetMomentsCommentsStore(false)
        end
    end

    return {
        id = "following",
        recommendationSource = RecommendationSource.Following,
        endsWithCaughtUp = true,
        fetchAsync = function(arg1)
            local ownerGeneration = if var2 == nil then nil else var2.getOwnerGeneration(false)
            local var3, var4 = var1.getFollowing(arg1):await()
            if not var3 then
                error(var4)
            end

            GetReactionsStore(false).setBatchReactionCounts(var4.reactionsByMomentId or {})
            GetShareCountsStore(false).setBatchShareCounts(var4.shareInfoByMomentId or {})

            local tbl3 = {}
            for _, moment in var4.moments do
                Analytics.reportMomentsFeedItemsReceived(RecommendationSource.Following)
                if shouldShowMomentInFeed(moment) then
                    table.insert(tbl3, { kind = "moment", moment = moment })
                else
                    reportUnavailableFeedItem(moment, RecommendationSource.Following)
                end
            end

            if FFlagMomentsRenderAvatarPostsInFeed then
                tbl3 = hydrateAvatarMomentFeedItems(tbl3, tbl2.postAssetStore or MomentsGetPostAssetStore(false))
            end

            local commentsByFeedItemId = var4.commentsByFeedItemId
            local var5

            if FFlagMomentsComments and var2 ~= nil and ownerGeneration ~= nil and commentsByFeedItemId ~= nil then
                local var6 = var2

                var5 = function()
                    var6.upsertMomentComments(commentsByFeedItemId, ownerGeneration)
                end
            else
                var5 = nil
            end

            return {
                items = tbl3,
                nextCursor = var4.nextCursor,
                onAccepted = var5
            }
        end
    }
end

return createFollowingFeedSource

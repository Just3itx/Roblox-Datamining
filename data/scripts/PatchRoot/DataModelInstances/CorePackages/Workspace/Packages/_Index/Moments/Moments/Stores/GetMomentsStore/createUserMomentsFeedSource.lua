-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:10Z
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

local MomentsGetMomentsUserStore = require(MomentsParent.DataHydration.MomentsGetMomentsUserStore)
local MomentsGetPostAssetStore = require(MomentsParent.DataHydration.MomentsGetPostAssetStore)
local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)
local createPendingFeedGetter = require(script.Parent.createPendingFeedGetter)
local hydrateAvatarMomentFeedItems = require(script.Parent.hydrateAvatarMomentFeedItems)
local shouldShowMomentInFeed = require(script.Parent.shouldShowMomentInFeed)
local reportUnavailableFeedItem = require(script.Parent.reportUnavailableFeedItem)
local GetReactionsStore = require(Moments.Stores.GetReactionsStore)
local GetShareCountsStore = require(Moments.Stores.GetShareCountsStore)
local GetDeletedMomentsStore = require(Moments.Stores.GetDeletedMomentsStore)
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local FFlagMomentsRemoveDeletedFromProfile = SharedFlags.FFlagMomentsRemoveDeletedFromProfile
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagProfileRenderAvatarMoments = SharedFlags.FFlagProfileRenderAvatarMoments
local MomentsGetMomentsCommentsStore = if FFlagMomentsComments then require(MomentsParent.DataHydration.MomentsGetMomentsCommentsStore) else nil

local function createUserMomentsFeedSource(num1: number, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = if tbl2.userStore ~= nil then tbl2.userStore else MomentsGetMomentsUserStore(false)
    local var2 = nil
    if FFlagMomentsComments then
        var2 = tbl2.commentsStore
        if var2 == nil and MomentsGetMomentsCommentsStore ~= nil then
            var2 = MomentsGetMomentsCommentsStore(false)
        end
    end

    local var3 = if FFlagProfileRenderAvatarMoments then tbl2.postAssetStore or MomentsGetPostAssetStore(false) else nil
    local initialIndex = tbl2.initialIndex

    local module = {
        id = `profile:{num1}`,
        initialMomentId = if FFlagMomentsOptimisticProfilePending then tbl2.initialMomentId else nil,
        getPendingItems = if FFlagMomentsOptimisticProfilePending then createPendingFeedGetter(num1, var1) else nil,
        recommendationSource = RecommendationSource.Profile,
        fetchAsync = 0
    }
    function module.fetchAsync(nextCursor)
        local ownerGeneration = if var2 == nil then nil else var2.getOwnerGeneration(false)
        local var4 = nil
        local items = {}
        local bool1 = nextCursor == nil

        while true do
            local var5, var6 = var1.getUserMoments(num1, nextCursor):await()
            if not var5 then
                error(var6)
            end

            local var7 = FFlagProfileRenderAvatarMoments and {} or nil
            local var8

            if var6.commentsByFeedItemId == nil then
                var8 = var4
            else
                var8 = var4 or {}
                for value, value2 in var6.commentsByFeedItemId do
                    var8[value] = value2
                end
            end
            GetReactionsStore(false).setBatchReactionCounts(var6.reactionsByMomentId or {})
            GetShareCountsStore(false).setBatchShareCounts(var6.shareInfoByMomentId or {})
            local var9 = if FFlagMomentsRemoveDeletedFromProfile or FFlagMomentsOptimisticProfilePending then GetDeletedMomentsStore(false).getDeletedIds(false) else nil

            for _, moment in var6.moments do
                Analytics.reportMomentsFeedItemsReceived(RecommendationSource.Profile)
                local bool2 = not (var9 == nil) and table.find(var9, moment.momentId) ~= nil
                local var10 = shouldShowMomentInFeed(moment)
                if not bool2 and var10 then
                    table.insert(if var7 == nil then items else var7, { kind = "moment", moment = moment })
                elseif bool2 then
                    Analytics.reportMomentsFeedItemFiltered("deleted", RecommendationSource.Profile)
                else
                    reportUnavailableFeedItem(moment, RecommendationSource.Profile)
                end
            end

            if FFlagProfileRenderAvatarMoments and var7 ~= nil then
                if var3 ~= nil then
                    var7 = hydrateAvatarMomentFeedItems(var7, var3)
                end
                for _, value in var7 do
                    table.insert(items, value)
                end
            end
            nextCursor = var6.nextCursor

            if not bool1 or initialIndex == nil or not (#items < initialIndex) or nextCursor == nil then
                local var10

                if FFlagMomentsComments and var2 ~= nil and ownerGeneration ~= nil and var8 ~= nil then
                    local var11 = var2

                    var10 = function()
                        var11.upsertMomentComments(var8, ownerGeneration)
                    end
                else
                    var10 = nil
                end

                return { items = items, nextCursor = nextCursor, onAccepted = var10 }
            end

            var4 = var8
        end
    end

    return module
end

return createUserMomentsFeedSource

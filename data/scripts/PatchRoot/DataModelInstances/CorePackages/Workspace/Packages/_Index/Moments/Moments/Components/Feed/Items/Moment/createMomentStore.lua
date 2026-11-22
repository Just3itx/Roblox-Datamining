-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:10:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local SharedFlags = require(MomentsParent.SharedFlags)
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local FFlagMomentsRenderAvatarPostsInFeed = SharedFlags.FFlagMomentsRenderAvatarPostsInFeed
local Signals = require(MomentsParent.Signals)

local GetReactionsStore = require(Moments.Stores.GetReactionsStore)
local GetShareCountsStore = require(Moments.Stores.GetShareCountsStore)
local _RecommendationContentType = require(Moments.Analytics.RecommendationContentType)
local _createReactionsStore = require(Moments.Stores.GetReactionsStore.createReactionsStore)
local _createShareCountsStore = require(Moments.Stores.GetShareCountsStore.createShareCountsStore)
local ReactionAction = require(Moments.Enums.ReactionAction)
local FFlagMomentsReactToFeedItemV2 = require(Moments.Flags.FFlagMomentsReactToFeedItemV2)
local FFlagMomentsHideZeroCommentCount = require(Moments.Flags.FFlagMomentsHideZeroCommentCount)
local MomentsGetMomentsCommentsStore = if SharedFlags.FFlagMomentsComments then require(MomentsParent.DataHydration.MomentsGetMomentsCommentsStore) else nil
local createSignal = Signals.createSignal
local createComputed = Signals.createComputed

local function createMomentStore(arg1, tbl1)
    local getData = createSignal(arg1)
    local momentId = arg1.momentId

    local tbl2 = tbl1 or {}
    local reactionsStore = if tbl2.reactionsStore ~= nil then tbl2.reactionsStore else GetReactionsStore(false)
    local shareCountsStore = if tbl2.shareCountsStore ~= nil then tbl2.shareCountsStore else GetShareCountsStore(false)
    local var1 = arg1.kind == "experience" or FFlagMomentsRenderAvatarPostsInFeed and arg1.kind == "avatar"
    local commentCount = if arg1.kind == "experience" then arg1.commentCount elseif FFlagMomentsRenderAvatarPostsInFeed and arg1.kind == "avatar" then arg1.commentCount else nil
    local var2, setCommentCount = createSignal(commentCount)
    local var4 = if tbl2.commentsStore ~= nil then tbl2.commentsStore elseif MomentsGetMomentsCommentsStore == nil then nil else MomentsGetMomentsCommentsStore(false)
    local feedItemId = arg1.feedItemId
    local computed

    if var4 == nil or not var1 or feedItemId == nil or feedItemId == "" then
        computed = var2
    else
        local data = var4.getCachedMomentComments(feedItemId).data
        computed = createComputed(function(arg2)
            local var5 = data(arg2)
            if var5 ~= nil and var5.count ~= nil then
                return var5.count
            end
            return var2(arg2)
        end)
    end

    local getCommentCount = if FFlagMomentsHideZeroCommentCount then createComputed(function(arg2)
        local var5 = computed(arg2)
        return if var5 == nil or not (var5 > 0) then nil else var5
    end) else computed

    local getIsModerated, setIsModerated = createSignal(arg1.isModerated == true)

    local getSelectedReaction = reactionsStore.getUserReactionForMoment(momentId)
    local getIsReacted = createComputed(function(arg2): boolean
        return getSelectedReaction(arg2) ~= nil
    end)
    local totalReactionCountForMoment = reactionsStore.getTotalReactionCountForMoment(momentId)
    local getReactionCount = createComputed(function(arg2)
        local var8 = totalReactionCountForMoment(arg2)
        return if var8 > 0 then var8 else nil
    end)

    local getIndividualReactionCounts = reactionsStore.getIndividualReactionCountsForMoment(momentId)

    local shareInfo = shareCountsStore.getShareInfo(momentId)
    local getShareCount = createComputed(function(arg2)
        local shareCount = shareInfo(arg2).shareCount
        return if shareCount > 0 then shareCount else nil
    end)

    local function commitReaction(reactionType)
        if FFlagMomentsOptimisticProfilePending and arg1.isPending then
            return
        end

        local var8 = reactionsStore.reactToFeedItem({
            feedItemId = arg1.feedItemId or momentId,
            entityType = "userCreatedMoment",
            entityId = momentId,
            reactionType = reactionType,
            feedSessionId = arg1.feedSessionId
        })

        if type(var8) == "table" and var8.catch ~= nil then
            var8:catch(function() end)
        end
    end
    local function clearReaction()
        if FFlagMomentsOptimisticProfilePending and arg1.isPending then
            return
        end
        if FFlagMomentsReactToFeedItemV2 then
            local reactionType = getSelectedReaction(false)
            if reactionType ~= nil then
                local var9 = reactionsStore.removeFeedItemReaction({
                    feedItemId = arg1.feedItemId or momentId,
                    entityType = "userCreatedMoment",
                    entityId = momentId,
                    reactionType = reactionType,
                    feedSessionId = arg1.feedSessionId
                })
                if type(var9) == "table" and var9.catch ~= nil then
                    var9:catch(function() end)
                end
                return
            end
        end
        reactionsStore.updateReaction({ action = ReactionAction.Unreact, momentId = momentId })
    end

    local getScrubPosition, setScrubPosition = createSignal(nil)
    local getIsScrubbing = createComputed(function(arg2): boolean
        return getScrubPosition(arg2) ~= nil
    end)

    local getIsReactionPickerOpen, setReactionPickerOpen = createSignal(false)

    return {
        getData = getData,
        getReactionCount = getReactionCount,
        getIndividualReactionCounts = getIndividualReactionCounts,
        getCommentCount = getCommentCount,
        setCommentCount = setCommentCount,
        getShareCount = getShareCount,
        setShareCount = function(num1: number?)
            local var12 = shareInfo(false)
            shareCountsStore.setShareCount(momentId, num1 or 0, var12.hasShared)
        end,
        getSelectedReaction = getSelectedReaction,
        getIsReacted = getIsReacted,
        commitReaction = commitReaction,
        clearReaction = clearReaction,
        getIsModerated = getIsModerated,
        setIsModerated = setIsModerated,
        getIsScrubbing = getIsScrubbing,
        getScrubPosition = getScrubPosition,
        setScrubPosition = setScrubPosition,
        getIsReactionPickerOpen = getIsReactionPickerOpen,
        setReactionPickerOpen = setReactionPickerOpen
    }
end

return createMomentStore

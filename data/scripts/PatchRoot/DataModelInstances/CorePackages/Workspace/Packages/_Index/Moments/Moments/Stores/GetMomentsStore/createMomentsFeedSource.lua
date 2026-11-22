-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _Signals = require(MomentsParent.Signals)
local Promise = require(MomentsParent.Promise)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local MomentsTypes = require(MomentsParent.MomentsTypes)
local SharedFlags = require(MomentsParent.SharedFlags)

local _Feed = require(Moments.Components.Feed)
local Analytics = MomentsCommon.Analytics
local RecommendationSource = MomentsCommon.Analytics.RecommendationSource

local _SignalTracker = require(Moments.SignalTracker)
local MomentsGetMomentsTrendingStore = require(MomentsParent.DataHydration.MomentsGetMomentsTrendingStore)
local MomentsGetPostAssetStore = require(MomentsParent.DataHydration.MomentsGetPostAssetStore)
local _MomentsStoreTypes = require(MomentsParent.DataHydration.MomentsStoreTypes)
local createPendingFeedGetter = require(script.Parent.createPendingFeedGetter)
local MomentsGetMomentsUserStore = require(MomentsParent.DataHydration.MomentsGetMomentsUserStore)
local getLocalUserId = require(Moments.Utils.getLocalUserId)
local fetchMomentsByIds = require(script.Parent.fetchMomentsByIds)
local hydrateAvatarMomentFeedItems = require(script.Parent.hydrateAvatarMomentFeedItems)
local shouldShowMomentInFeed = require(script.Parent.shouldShowMomentInFeed)
local reportUnavailableFeedItem = require(script.Parent.reportUnavailableFeedItem)
local GetDeepLinkStore = require(Moments.Stores.GetDeepLinkStore)
local _createDeepLinkStore = require(Moments.Stores.GetDeepLinkStore.createDeepLinkStore)
local GetReactionsStore = require(Moments.Stores.GetReactionsStore)
local GetShareCountsStore = require(Moments.Stores.GetShareCountsStore)
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local FFlagMomentsModeratedMomentPage = require(Moments.Flags.FFlagMomentsModeratedMomentPage)
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagMomentsRenderAvatarPostsInFeed = SharedFlags.FFlagMomentsRenderAvatarPostsInFeed
local FFlagMomentsCommentDeepLinks = SharedFlags.FFlagMomentsCommentDeepLinks
local MomentsGetMomentsCommentsStore = if FFlagMomentsComments then require(MomentsParent.DataHydration.MomentsGetMomentsCommentsStore) else nil
local MomentStatus = MomentsTypes.Enums.MomentStatus

local function withCommentsSeeding(callback: ((...any) -> (...any))?, arg1, num1: number?, arg2) -- Luacid: unused: defined but never referenced
    return if arg1 == nil or num1 == nil or arg2 == nil then callback else function()
        if callback ~= nil then
            callback()
        end
        arg1.upsertMomentComments(arg2, num1)
    end
end

local function defaultFetchDeepLinkedMoments(str1: string, str2: string?)
    return Promise.resolve():andThen(function()
        return fetchMomentsByIds({ str1 }, str2)
    end)
end

local function mergeCommentsByFeedItemId(arg1, commentsByFeedItemId) -- Luacid: Inlined by compiler; 1 call site recovered
    if commentsByFeedItemId == nil then
        return arg1
    end
    local var1 = arg1 or {}
    for value, value2 in commentsByFeedItemId do
        var1[value] = value2
    end
    return var1
end

local function hasDeepLinkIdentity(arg1, str1: string): boolean -- Luacid: Inlined by compiler; 5 call sites recovered
    if arg1.momentId == str1 then
        return true
    end
    local recommendationMetadata = arg1.recommendationMetadata
    return not (recommendationMetadata == nil) and recommendationMetadata.feedItemId == str1
end

local function findDeepLinkTarget(moments, targetId: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    for _, moment in moments do
        if hasDeepLinkIdentity(moment, targetId) then
            return moment
        end
    end
    return nil
end

local function makeUnavailableMomentItem(targetId: string, moments, moments2)
    local deepLinkTarget = findDeepLinkTarget(moments, targetId) or findDeepLinkTarget(moments2, targetId)

    return {
        kind = "unavailableMoment",
        targetId = targetId,
        isModerated = not (deepLinkTarget == nil or deepLinkTarget.status == MomentStatus.Deleted) and deepLinkTarget.isModerated == true
    }
end

local function loadDeepLinkedMomentsForUnavailableDialog(func1: (...any) -> (...any), deepLinkedMomentId: string, deepLinkedMomentTargetIdType: string?, deepLinkFetchTimeoutSeconds: number): {[any]: any}?
    local var1 = func1(deepLinkedMomentId, deepLinkedMomentTargetIdType):catch(function()
        return nil
    end)
    local var2 = Promise.delay(deepLinkFetchTimeoutSeconds):andThen(function()
        return nil
    end)

    local var3, var4 = Promise.race({ var1, var2 }):await()
    return if var3 and type(var4) == "table" then var4 else nil
end

local function createMomentsFeedSource(arg1, tbl1)
    local tbl2 = tbl1 or {}
    local var1 = if tbl2.trendingStore ~= nil then tbl2.trendingStore else MomentsGetMomentsTrendingStore(false)
    local var2 = nil
    if FFlagMomentsComments then
        var2 = tbl2.commentsStore
        if var2 == nil and MomentsGetMomentsCommentsStore ~= nil then
            var2 = MomentsGetMomentsCommentsStore(false)
        end
    end
    local deepLinkStore = tbl2.deepLinkStore or GetDeepLinkStore()
    local var3 = tbl2.fetchDeepLinkedMoments or defaultFetchDeepLinkedMoments
    local deepLinkFetchTimeoutSeconds = tbl2.deepLinkFetchTimeoutSeconds or 20

    local var4 = nil
    local pendingFeedGetter = nil
    if FFlagMomentsOptimisticProfilePending then
        local localUserId = tbl2.localUserId or getLocalUserId()
        if localUserId ~= nil then
            pendingFeedGetter = createPendingFeedGetter(localUserId, tbl2.userStore or MomentsGetMomentsUserStore(false))
        end
    end

    return {
        id = "trending",
        getPendingItems = pendingFeedGetter,
        recommendationSource = RecommendationSource.Trending,
        fetchAsync = function(arg2)
            local ownerGeneration = if var2 == nil then nil else var2.getOwnerGeneration(false)
            local var5 = arg2 or var4
            local signalTracker = tbl2.signalTracker
            local signalsPayload = if signalTracker then signalTracker:getSignalsPayload() else nil
            local var6, var7 = var1.getTrending(arg1(false), var5, signalsPayload):await()
            if not var6 then
                error(var7)
            end

            local commentsByFeedItemId = var7.commentsByFeedItemId
            local tbl3

            if commentsByFeedItemId == nil then
                tbl3 = nil
            else
                tbl3 = {}
                for value, value2 in commentsByFeedItemId do
                    tbl3[value] = value2
                end
            end

            var4 = var7.nextCursor or var4

            if arg2 == nil then
                GetReactionsStore(false).clear()
                GetShareCountsStore(false).clear()
            end

            GetReactionsStore(false).setBatchReactionCounts(var7.reactionsByMomentId or {})
            GetShareCountsStore(false).setBatchShareCounts(var7.shareInfoByMomentId or {})

            local tbl4 = {}
            local var8 = nil
            local momentId = nil
            local var9 = nil

            if arg2 == nil then
                local deepLinkedMomentId = deepLinkStore.getDeepLinkedMomentId(false)
                local deepLinkedMomentTargetIdType = deepLinkStore.getDeepLinkedMomentTargetIdType(false)
                if deepLinkedMomentId ~= nil then
                    local tbl5 = {}
                    local var10 = nil
                    for _, moment in var7.moments do
                        tbl5[moment.momentId] = true

                        if var10 == nil and hasDeepLinkIdentity(moment, deepLinkedMomentId) then
                            var10 = moment
                        end
                    end

                    local bool1 = false
                    local bool2 = false

                    local feedItemId = nil

                    if var10 ~= nil and shouldShowMomentInFeed(var10) then
                        table.insert(tbl4, { kind = "moment", moment = var10 })
                        momentId = var10.momentId
                        bool1 = true
                        if FFlagMomentsCommentDeepLinks then
                            feedItemId = var10.recommendationMetadata.feedItemId
                        end
                    else
                        local var11 = loadDeepLinkedMomentsForUnavailableDialog(
                            var3,
                            deepLinkedMomentId,
                            deepLinkedMomentTargetIdType,
                            deepLinkFetchTimeoutSeconds
                        )

                        if var11 ~= nil then
                            tbl3 = mergeCommentsByFeedItemId(tbl3, var11.commentsByFeedItemId)
                            if var11.reactionsByMomentId then
                                GetReactionsStore(false).setBatchReactionCounts(var11.reactionsByMomentId)
                            end
                            if var11.shareInfoByMomentId then
                                GetShareCountsStore(false).setBatchShareCounts(var11.shareInfoByMomentId)
                            end

                            for _, moment in var11.moments do
                                local bool3 = hasDeepLinkIdentity(moment, deepLinkedMomentId)

                                if not (shouldShowMomentInFeed(moment) and bool3) then
                                    continue
                                end

                                table.insert(tbl4, { kind = "moment", moment = moment })
                                bool1 = true
                                if FFlagMomentsCommentDeepLinks then
                                    feedItemId = moment.recommendationMetadata.feedItemId
                                end
                            end

                            bool2 = not bool1
                            if FFlagMomentsModeratedMomentPage and bool2 then
                                table.insert(tbl4, (makeUnavailableMomentItem(deepLinkedMomentId, var11.moments, var7.moments)))
                            end
                        end
                    end

                    if bool1 or bool2 then
                        local bool3 = bool2 and not FFlagMomentsModeratedMomentPage

                        var8 = function()
                            if deepLinkStore.getDeepLinkedMomentId(false) ~= deepLinkedMomentId then
                                return
                            end

                            deepLinkStore.setDeepLinkedMomentId(nil)
                            if FFlagMomentsCommentDeepLinks then
                                deepLinkStore.resolvePendingCommentsTarget(deepLinkedMomentId, feedItemId)
                            end
                            if bool3 and tbl2.onDeepLinkedMomentUnavailable ~= nil then
                                tbl2.onDeepLinkedMomentUnavailable()
                            end
                        end
                    end
                end
            end

            local var10

            if FFlagMomentsComments then
                local var11 = var2

                if var11 == nil or ownerGeneration == nil then
                    var10 = var8
                else
                    var10 = tbl3 ~= nil and function()
                        if var8 ~= nil then
                            var8()
                        end
                        var11.upsertMomentComments(tbl3, ownerGeneration)
                    end or var8
                end
            else
                var10 = var8
            end

            local var11 = tbl4[1]
            if FFlagMomentsOptimisticProfilePending and arg2 == nil and var11 ~= nil then
                if var11.kind == "moment" then
                    var9 = var11.moment.momentId
                elseif var11.kind == "unavailableMoment" then
                    var9 = var11.targetId
                end
            end

            for _, moment in var7.moments do
                Analytics.reportMomentsFeedItemsReceived(RecommendationSource.Trending)

                if momentId ~= nil and moment.momentId == momentId then
                    continue
                end

                if shouldShowMomentInFeed(moment) then
                    table.insert(tbl4, { kind = "moment", moment = moment })
                else
                    reportUnavailableFeedItem(moment, RecommendationSource.Trending)
                end
            end

            if FFlagMomentsRenderAvatarPostsInFeed then
                tbl4 = hydrateAvatarMomentFeedItems(tbl4, tbl2.postAssetStore or MomentsGetPostAssetStore(false))
            end

            return {
                items = tbl4,
                initialMomentId = var9,
                nextCursor = var7.nextCursor,
                onAccepted = var10
            }
        end
    }
end

return createMomentsFeedSource

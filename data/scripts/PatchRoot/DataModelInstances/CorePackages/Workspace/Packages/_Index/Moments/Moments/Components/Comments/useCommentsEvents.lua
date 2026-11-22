-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local MomentsGetMomentsCommentsStore = require(MomentsParent.DataHydration.MomentsGetMomentsCommentsStore)
local useRoactService = require(MomentsParent.RobloxAppHooks).useRoactService
local AppAppLifecycleObserverService = require(MomentsParent.RoactServiceTags).AppAppLifecycleObserverService

local useFeedOptional = require(Moments.Components.Feed.FeedContext).useFeedOptional
local makeRecommendationAttribution = require(Moments.Analytics.makeRecommendationAttribution)
local makeCommentCountFields = require(Moments.Analytics.makeCommentCountFields)
local _RecommendationContentType = require(Moments.Analytics.RecommendationContentType)
local FFlagMomentsCommentsCountAnalytics = require(Moments.Flags.FFlagMomentsCommentsCountAnalytics)
local FFlagMomentsRecommendationContentType = require(Moments.Flags.FFlagMomentsRecommendationContentType)
local getCommentsSheetStore = require(script.Parent.Sheet.getCommentsSheetStore)
local createCommentsRecommendationSession = require(script.Parent.createCommentsRecommendationSession)
local createCommentsAnalyticsSession = require(script.Parent.createCommentsAnalyticsSession)
local useCommentCapabilities = require(script.Parent.useCommentCapabilities)
local _createCommentsSheetStore = require(script.Parent.Sheet.createCommentsSheetStore)
local FFlagMomentsCommentDeepLinks = require(MomentsParent.SharedFlags).FFlagMomentsCommentDeepLinks
local GetDeepLinkStore = if FFlagMomentsCommentDeepLinks then require(Moments.Stores.GetDeepLinkStore) else nil

local function useCommentsEvents(arg1, arg2, arg3)
    local var1 = useFeedOptional()
    local var2 = useRoactService(AppAppLifecycleObserverService)
    local commentsSheetStore = getCommentsSheetStore(false)
    local var3 = React.useRef(nil)
    local var4 = React.useRef(nil)
    local isPlaybackActive = not (var1 == nil) and var1.isActiveFeed and var1.isPlaybackActive

    local var5 = React.useMemo(function()
        local get, set = Signals.createSignal(true)
        return { get = get, set = set }
    end, {})

    React.useEffect(function()
        if var2 == nil then
            return
        end

        local connection = var2.OnHide:Connect(function()
            var5.set(false)
        end)
        local connection2 = var2.OnUnhide:Connect(function()
            var5.set(true)
        end)
        return function()
            connection:Disconnect()
            connection2:Disconnect()
        end
    end, { var2, var5 })

    React.useEffect(function()
        return Signals.createEffect(function(arg4)
            local var6 = var5.get(arg4)
            local isOpen = commentsSheetStore.getIsOpen(arg4)
            local openSessionId = commentsSheetStore.getOpenSessionId(arg4)
            local feedItemId = commentsSheetStore.getFeedItemId(false) or ""
            local current = var3.current
            local current2 = var4.current
            local var7 = isPlaybackActive and var6 and isOpen
            if current ~= nil then
                if var7 and commentsSheetStore.getRecommendationSession(feedItemId, openSessionId) == current then
                    current.startView()
                else
                    current.finishView()
                end
            end
            if current2 == nil then
                return
            end

            if var7 and commentsSheetStore.getAnalyticsSession(feedItemId, openSessionId) == current2 then
                current2.startView()
                return
            end

            if not var6 then
                current2.finishView("app_hidden")
                return
            end

            if not isPlaybackActive then
                current2.finishView("navigation_hidden")
            end
        end)
    end, { isPlaybackActive, commentsSheetStore, var5 })

    React.useEffect(function()
        return function()
            if var3.current ~= nil then
                var3.current.finishView()
            end
            if var4.current ~= nil then
                var4.current.finishView("unmounted")
            end
        end
    end, {})

    local canRead = useCommentCapabilities().canRead

    local useCallback = React.useCallback
    local function func1(arg4)
        local feedItemId = if arg1 == nil then nil else arg1.feedItemId

        if feedItemId == nil or feedItemId == "" or not canRead then
            return
        end
        local commentsRecommendationSession = nil
        local recommendationAttribution = makeRecommendationAttribution(arg1, nil, if FFlagMomentsRecommendationContentType then arg3 else nil)

        if var1 ~= nil and recommendationAttribution ~= nil then
            commentsRecommendationSession = createCommentsRecommendationSession(var1.logAction, recommendationAttribution, arg2(false))
        end
        local var6 = MomentsGetMomentsCommentsStore(false)
        local ownerGeneration = var6.getOwnerGeneration(false)
        local bool1 = not (var1 == nil)
            and (var1.recommendationSource == MomentsCommon.Analytics.RecommendationSource.Profile
                or var1.recommendationSource == MomentsCommon.Analytics.RecommendationSource.MyMoments)

        local current = createCommentsAnalyticsSession(feedItemId, if bool1 then "profile" else "watch_tab", function(): boolean
            return var6.getOwnerGeneration(false) == ownerGeneration
        end, nil, nil, nil, FFlagMomentsCommentsCountAnalytics and function()
            return makeCommentCountFields(var6.getCachedMomentComments(feedItemId).data(false))
        end or nil)

        var3.current = commentsRecommendationSession
        var4.current = current
        local open = commentsSheetStore.open

        if not FFlagMomentsCommentDeepLinks then
            arg4 = nil
        end

        open(feedItemId, commentsRecommendationSession, current, arg4)
    end

    local var6 = arg1 or false
    local var7 = var1 or false
    local var8 = if FFlagMomentsRecommendationContentType then arg3 or false else false
    local var9 = useCallback(func1, { var6, var7, commentsSheetStore, arg2, var8, canRead })

    if not FFlagMomentsCommentDeepLinks or GetDeepLinkStore == nil then
        return var9
    end

    local feedItemId = if arg1 == nil then nil else arg1.feedItemId
    local getCurrentItem = if var1 == nil then nil else var1.getCurrentItem

    React.useEffect(function()
        if not isPlaybackActive or not canRead or getCurrentItem == nil or feedItemId == nil or feedItemId == "" then
            return
        end

        local deepLinkStore = GetDeepLinkStore()
        return Signals.createEffect(function(arg4)
            local pendingCommentsTarget = deepLinkStore.getPendingCommentsTarget(arg4)
            if pendingCommentsTarget == nil or pendingCommentsTarget.feedItemId ~= feedItemId then
                return
            end

            local currentItem = getCurrentItem(arg4)
            local feedItemId2 = nil
            if currentItem ~= nil and currentItem.kind == "moment" or currentItem ~= nil and currentItem.kind == "avatarMoment" then
                feedItemId2 = currentItem.moment.recommendationMetadata.feedItemId
            end

            if feedItemId2 ~= feedItemId then
                return
            end
            local var10 = deepLinkStore.takeCommentsTarget(feedItemId)
            if var10 ~= nil then
                var9(var10)
            end
        end)
    end, {
        isPlaybackActive,
        canRead,
        getCurrentItem or false,
        feedItemId or false,
        var9
    })

    return React.useCallback(function()
        var9(nil)
    end, { var9 })
end

return useCommentsEvents

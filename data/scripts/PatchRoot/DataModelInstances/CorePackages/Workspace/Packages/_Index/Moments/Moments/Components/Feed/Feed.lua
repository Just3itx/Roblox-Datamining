-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)
local SharedFlags = require(MomentsParent.SharedFlags)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)

local useLocalization = Localization.Hooks.useLocalization

local Analytics = MomentsCommon.Analytics
local EventNames = Analytics.EventNames
local fireAnalyticsEvent = Analytics.fireAnalyticsEvent
local MomentsSurfaceLoadManager = MomentsCommon.Performance.MomentsSurfaceLoadManager
local FFlagMomentsPostInsightsIxpEnabled = require(Moments.Flags.FFlagMomentsPostInsightsIxpEnabled)
local FFlagMomentsRemoveDeletedFromProfile = SharedFlags.FFlagMomentsRemoveDeletedFromProfile
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local FFlagMomentsRenderAvatarPostsInFeed = SharedFlags.FFlagMomentsRenderAvatarPostsInFeed
local FFlagMomentsFeedMediaLoadAttemptedEvent = MomentsCommon.Flags.FFlagMomentsFeedMediaLoadAttemptedEvent
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagMomentsCommentDeepLinks = SharedFlags.FFlagMomentsCommentDeepLinks
local getCommentsSheetStore = if FFlagMomentsComments then require(Moments.Components.Comments.Sheet.getCommentsSheetStore) else nil
local FFlagMomentsCreatorAnalytics = require(Moments.Flags.FFlagMomentsCreatorAnalytics)
local getPostInsightsPageStore = if FFlagMomentsCreatorAnalytics then require(Moments.Components.PostInsights.getPostInsightsPageStore) else nil
local VerticalPager = require(Moments.Components.VerticalPager)

local _FeedTypes = require(script.Parent.FeedTypes)
local FeedContext = require(script.Parent.FeedContext)
local FeedStateView = require(script.Parent.FeedStateView)
local createFeedStore = require(script.Parent.createFeedStore)
local feedItemRegistry = require(script.Parent.feedItemRegistry)
local feedTelemetry = require(script.Parent.feedTelemetry)
local getFeedScrollLimit = require(script.Parent.getFeedScrollLimit)
local useFeedTelemetry = require(script.Parent.useFeedTelemetry)
local FeedNavigationBar = require(script.Parent.FeedNavigationBar)
local ImmersiveChromeController = require(script.Parent.ImmersiveChromeController)
local DeletionConfirmationDialog = require(script.Parent.DeletionConfirmationDialog)
local GetImmersiveChromeStore = require(Moments.Stores.GetImmersiveChromeStore)
local FFlagMomentsCommentsCloseOnFeedJump = require(Moments.Flags.FFlagMomentsCommentsCloseOnFeedJump)
local GetMomentsCapabilities = MomentsCommon.Stores.GetMomentsCapabilities
local useMomentsSession = require(Moments.Stores.GetMomentsStore.MomentsSessionContext).useMomentsSession
local FFlagMomentsDeleteSnackbar = require(Moments.Flags.FFlagMomentsDeleteSnackbar)
local FFlagMomentsFixDeleteToastCopy = require(Moments.Flags.FFlagMomentsFixDeleteToastCopy)
local GetFFlagMomentsNonInfiniteScroll = MomentsCommon.Flags.GetFFlagMomentsNonInfiniteScroll
local GetToastStore = require(Moments.Stores.GetToastStore)
local GetDeletedMomentsStore = require(Moments.Stores.GetDeletedMomentsStore)
local getExperienceDetailsSheetStore = require(Moments.ExperienceDetailsSheet.Sheet.getExperienceDetailsSheetStore)
local FFlagMomentsParentTimeLimit = MomentsCommon.Flags.FFlagMomentsParentTimeLimit
local deleteMoment = require(Moments.Moderation.deleteMoment)
local logMomentViewBegan = require(Moments.Analytics.logMomentViewBegan)
local FFlagMomentsImpressionPrimaryEntity = require(Moments.Flags.FFlagMomentsImpressionPrimaryEntity)
local useMomentsHost = require(Moments.MomentsHostContext).useMomentsHost
local FFlagMomentsNavigationEvent = require(Moments.Flags.FFlagMomentsNavigationEvent)
local logFeedEndStateReached = require(Moments.Analytics.logFeedEndStateReached)
local makeFeedActionFields = require(Moments.Analytics.makeFeedActionFields)

local MomentMediaCoordinatorProvider = require(script.Parent.Media.MomentMediaCoordinatorProvider)
local SurfaceReadyTracker = require(script.Parent.SurfaceReadyTracker)
local SwipeLatencyTracker = require(script.Parent.SwipeLatencyTracker)

local VerticalPager2 = VerticalPager.VerticalPager

local FeedContext2 = FeedContext.FeedContext

local noopTelemetry = feedTelemetry.createNoopTelemetry()

local tbl1 = {
    deletedTitle = "Feature.Moments.Label.MomentDeletedTitle",
    deletedBody = "Feature.Moments.Label.MomentDeletedBody",
    deletedToast = "Feature.Moments.Label.PostDeleted"
}

local function renderFeedItem(arg1, num1: number)
    local var1 = feedItemRegistry[arg1.kind]
    if var1 ~= nil then
        return (var1.render(arg1, num1))
    end

    return nil
end

local function feedItemKey(arg1, num1: number)
    local var1 = feedItemRegistry[arg1.kind]
    local key = if var1 == nil then nil else var1.getKey(arg1)

    if key ~= nil and key ~= "" then
        return key
    end

    return tostring(num1)
end

local function feedItemDedupeKey(arg1)
    local var1 = feedItemRegistry[arg1.kind]
    if var1 ~= nil then
        return (var1.getKey(arg1))
    end

    return nil
end

local function feedItemAttribution(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = feedItemRegistry[arg1.kind]
    if var1 ~= nil then
        return (var1.getAttribution(arg1))
    end

    return nil
end

local function withLimitReachedHidden(bool1: boolean, pager)
    if not FFlagMomentsParentTimeLimit then
        return pager
    end
    return React.createElement(
        "Frame",
        {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Visible = not bool1,
            ZIndex = 1
        },
        { Pager = pager }
    )
end

local function stringOrNil(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    if arg1 ~= nil then
        return tostring(arg1)
    end

    return nil
end

local function makeMediaLoadEventFields(arg1, source)
    local recommendationMetadata = arg1.recommendationMetadata
    return {
        momentId = arg1.momentId,
        assetId = tostring(arg1.assetId),
        captureType = arg1.metadata.captureType.Name,
        creatorId = tostring(arg1.creatorId),
        itemId = if recommendationMetadata == nil then nil else recommendationMetadata.feedItemId,
        tracingId = if recommendationMetadata == nil then nil else recommendationMetadata.tracingId,
        recommendationSource = source.recommendationSource or "",
        feedSourceId = source.id or "",
        placeId = stringOrNil(arg1.metadata.placeId),
        universeId = stringOrNil(arg1.metadata.universeId)
    }
end

local var1 = nil
local function getLogger() -- Luacid: Inlined by compiler; 2 call sites recovered
    if var1 == nil then
        var1 = require(MomentsParent.Loggers).Logger:new("Moments.Feed")
    end
    return var1
end

local function Feed(tbl2)
    local source = tbl2.source
    local isActiveFeed = tbl2.active == nil or tbl2.active
    local bool1 = if tbl2.playbackActive ~= nil then tbl2.playbackActive else isActiveFeed
    local var3 = tbl2.showNavigationBar == nil or tbl2.showNavigationBar
    local telemetry = tbl2.telemetry or noopTelemetry
    local bool2 = tbl2.trackSurfaceLoad == true
    local var5, var6

    if FFlagMomentsComments and getCommentsSheetStore ~= nil then
        var5 = SignalsReact.useSignalState(getCommentsSheetStore(false).getIsOpen)

        var6 = SignalsReact.useSignalState(getCommentsSheetStore(false).getIsExpanded)
    else
        var5 = false
        var6 = false
    end

    local var7 = isActiveFeed and not var5
    local var8

    if FFlagMomentsCreatorAnalytics and getPostInsightsPageStore ~= nil then
        var8 = SignalsReact.useSignalState(getPostInsightsPageStore(false).getIsOpen)
        if var8 then
            var7 = false
        end
    else
        var8 = false
    end

    local var9 = bool1 and not var6
    if FFlagMomentsCreatorAnalytics and var8 then
        var9 = false
    end

    local immersiveChromeStore = GetImmersiveChromeStore(false)

    local var10 = useLocalization(tbl1)

    local var11 = useMomentsSession()
    local toastStore = GetToastStore(false)
    local var12 = SignalsReact.useSignalState(var11.getPendingDeletion)

    local var13 = React.useMemo(function()
        local feedScrollLimit = getFeedScrollLimit(true, GetFFlagMomentsNonInfiniteScroll(), function()
            return GetMomentsCapabilities(false)
        end)
        return createFeedStore(
            source,
            feedItemDedupeKey,
            bool2,
            feedScrollLimit,
            if FFlagMomentsParentTimeLimit then require(Moments.Stores.GetMomentsUsageStore)(false) else nil
        )
    end, { source, bool2 })

    local var14 = bool1
    React.useEffect(function()
        if FFlagMomentsParentTimeLimit and var14 then
            local var15 = require(Moments.Stores.GetMomentsUsageStore)(false).retainWatching()
            return function()
                var15()
            end
        end
    end, { var14 })

    local var15 = SignalsReact.useSignalState(var13.getStatus)
    local var16 = FFlagMomentsParentTimeLimit and var15 == "LimitReached"
    if var16 then
        bool1 = false
        var9 = false
    end

    React.useEffect(function()
        if not var16 then
            return
        end
        getExperienceDetailsSheetStore(false).close()
        if getCommentsSheetStore ~= nil then
            local commentsSheetStore = getCommentsSheetStore(false)
            if commentsSheetStore.getIsOpen(false) then
                commentsSheetStore.close("navigation_hidden")
            end
        end
        if getPostInsightsPageStore ~= nil then
            getPostInsightsPageStore(false).close()
        end
    end, { var16 })

    React.useEffect(function()
        var13.loadInitial()
        return function()
            var13.dispose()
        end
    end, { var13 })

    if FFlagMomentsCommentsCloseOnFeedJump and getCommentsSheetStore ~= nil then
        React.useEffect(function()
            if not isActiveFeed then
                return
            end

            local commentsSheetStore = getCommentsSheetStore(false)

            local function getCurrentPosition(bool3: boolean)
                local currentItem = var13.pager.getCurrentItem(bool3)
                if currentItem == nil or currentItem.kind == "skeleton" then
                    return nil
                end
                if currentItem.kind ~= "moment" and (not FFlagMomentsRenderAvatarPostsInFeed or currentItem.kind ~= "avatarMoment") then
                    return `kind:{currentItem.kind}`
                end

                local moment = currentItem.moment
                return moment.recommendationMetadata.feedItemId or `moment:{moment.momentId}`
            end
            local currentPosition = getCurrentPosition(false)
            return Signals.createEffect(function(arg1)
                local currentPosition2 = getCurrentPosition(arg1)
                if currentPosition2 == nil or currentPosition2 == currentPosition then
                    return
                end
                local var17 = currentPosition
                currentPosition = currentPosition2
                if var17 ~= nil and commentsSheetStore.getIsOpen(false) and commentsSheetStore.getFeedItemId(false) == var17 then
                    commentsSheetStore.close()
                end
            end)
        end, { isActiveFeed, var13 })
    end

    local controllerRef = React.useRef(nil)
    local onTargetCommittedRef = React.useRef(nil)

    local var19 = React.useRef(nil)
    local analytics = React.useMemo(function()
        local tbl3 = {
            onTargetCommitted = function(num1: number, num2: number, arg1)
                local current = onTargetCommittedRef.current
                if current ~= nil then
                    current(num1, num2, arg1)
                end
            end
        }

        if FFlagMomentsNavigationEvent then
            function tbl3.onUserStep(num1: number, num2: number)
                local current = var19.current
                if current ~= nil then
                    current(num1, num2)
                end
            end
        end
        return tbl3
    end, {})
    local var21 = React.useRef(0)
    local var22 = React.useRef(false)
    local var23 = React.useRef(0)

    local var24 = React.useRef(nil)
    local refresh = React.useCallback(function(arg1)
        if var22.current or DateTime.now().UnixTimestampMillis < var21.current then
            return
        end

        local current = var24.current
        if FFlagMomentsNavigationEvent and arg1 ~= nil and current ~= nil then
            current(arg1)
        end
        var22.current = true
        local var25 = var23
        var25.current += 1
        local current2 = var23.current
        var13.refresh()

        task.spawn(function()
            while var22.current and current2 == var23.current do
                local status = var13.getStatus(false)
                if status == "Loaded" or status == "Empty" then
                    var22.current = false
                    var21.current = DateTime.now().UnixTimestampMillis + 1000

                    return
                end

                if status == "Failed" or FFlagMomentsParentTimeLimit and status == "LimitReached" then
                    var22.current = false
                    return
                end
                task.wait()
            end
        end)
    end, { var13 })

    local prependMoment = React.useCallback(function(moment)
        var13.prependItem({ kind = "moment", moment = moment })
        local current = controllerRef.current
        if current ~= nil then
            current.scrollToIndex(1)
        end
    end, { var13 })

    local var27 = React.useRef(nil)
    local bool3 = useMomentsHost().openAvatarLookTryOn ~= nil
    local recommendationSource = if FFlagMomentsPostInsightsIxpEnabled then source.recommendationSource or false else false

    local onItemBecameActive = React.useCallback(function(arg1)
        if arg1.kind ~= "moment" and (not FFlagMomentsRenderAvatarPostsInFeed or arg1.kind ~= "avatarMoment") then
            return
        end
        local moment = arg1.moment

        if FFlagMomentsPostInsightsIxpEnabled then
            require(Moments.Analytics.logPostInsightsLayerExposure)(moment, source.recommendationSource)
        end
        local current = var27.current
        logMomentViewBegan(
            moment,
            var11.getSessionSource(false),
            if FFlagMomentsNavigationEvent and current ~= nil then current() else nil,
            if FFlagMomentsImpressionPrimaryEntity then bool3 else nil
        )
    end, { var11, bool3, recommendationSource })

    local includeRecommendationDetail = tbl2.telemetry ~= nil
    local var29 = React.useCallback(function(arg1, arg2)
        local makeMomentsNavigationFields = require(Moments.Analytics.makeMomentsNavigationFields)
        fireAnalyticsEvent(
            EventNames.MomentsNavigationEvent,
            makeMomentsNavigationFields({
                feedItemId = arg1.itemId,
                viewId = arg2.viewId,
                durationSeconds = arg2.durationSeconds,
                destinationType = arg2.destination,
                itemPosition = arg2.itemPosition,
                tracingId = arg1.tracingId,
                includeRecommendationDetail = includeRecommendationDetail,
                clientEventTimestampMs = DateTime.now().UnixTimestampMillis
            })
        )
    end, { includeRecommendationDetail })

    local var30 = React.useCallback(function(itemPosition: number)
        logFeedEndStateReached({
            source = var11.getSessionSource(false),
            recommendationSource = source.recommendationSource or "",
            feedSourceId = source.id or "",
            itemPosition = itemPosition
        })
    end, { var11, source })

    local var31 = useFeedTelemetry
    local pager = var13.pager
    local tbl3 = {
        telemetry = telemetry,
        active = isActiveFeed and not var16,
        getAttribution = feedItemAttribution,
        recommendationSource = source.recommendationSource,
        onItemBecameActive = onItemBecameActive,
        onEndStateReached = 0,
        onViewEnded = 0,
        inactiveDestination = 0
    }

    if not GetFFlagMomentsNonInfiniteScroll() and source.endsWithCaughtUp ~= true then
        var30 = nil
    end

    tbl3.onEndStateReached = var30

    if not FFlagMomentsNavigationEvent then
        var29 = nil
    end

    tbl3.onViewEnded = var29
    tbl3.inactiveDestination = if FFlagMomentsNavigationEvent then tbl2.inactiveDestination else nil
    local var32 = var31(pager, tbl3)

    var27.current = var32.getViewId
    var24.current = var32.flushView
    var19.current = var32.noteUserStep

    React.useImperativeHandle(tbl2.controllerRef, function()
        return {
            prependMoment = prependMoment,
            refresh = refresh,
            flushView = var32.flushView
        }
    end, { prependMoment, refresh, var32.flushView })

    local var33 = React.useRef(bool1)
    React.useEffect(function()
        local current = var33.current
        var33.current = bool1
        if not bool1 or current then
            return
        end

        local currentItem = var13.pager.getCurrentItem(false)
        if currentItem ~= nil then
            onItemBecameActive(currentItem)
        end
    end, { bool1, var13, onItemBecameActive })

    local var34 = React.useCallback(function()
        local current = controllerRef.current
        if current ~= nil then
            current.next()
        end
    end, {})
    local onScrollToPrevious = React.useCallback(function()
        local current = controllerRef.current
        if current ~= nil then
            current.previous()
        end
    end, {})

    local var36, var37

    if FFlagMomentsOptimisticProfilePending then
        var36 = SignalsReact.useSignalState(var13.getInitialIndex)
        var37 = SignalsReact.useSignalState(var13.getError)
    else
        var36 = nil
        var37 = nil
    end
    local var38 = SignalsReact.useSignalState(var13.getLoadMoreFailed)
    local var39 = React.useRef({})

    React.useEffect(function()
        return function()
            local var40 = var23
            var40.current += 1
            var22.current = false
            var21.current = 0
        end
    end, { var13 })

    local var40 = React.useRef(false)
    local var41 = React.useRef(false)

    React.useEffect(function()
        if var40.current then
            return
        end

        var40.current = true
        if bool2 then
            MomentsSurfaceLoadManager.renderStarted()
            MomentsSurfaceLoadManager.surfaceMounted()
        end
        fireAnalyticsEvent(EventNames.MomentsFirstUIRenderedTimestamp, {
            value = if bool2 and MomentsSurfaceLoadManager.isSessionActive() then MomentsSurfaceLoadManager.elapsedMs() else DateTime.now().UnixTimestampMillis
        })
    end, {})

    React.useEffect(function()
        if bool2 then
            return
        end
        if not var41.current and (var15 == "Loaded" or var15 == "LoadingMore") then
            var41.current = true
            fireAnalyticsEvent(EventNames.MomentsFirstContentLoadedTimestamp, { value = DateTime.now().UnixTimestampMillis })
        end
    end, { var15 })

    local var42 = React.useRef(nil)

    React.useEffect(function()
        if var15 ~= var42.current then
            if var15 == "Failed" then
                fireAnalyticsEvent(EventNames.FeedLoadFailed, {
                    recommendationSource = source.recommendationSource or "",
                    feedSourceId = source.id or "",
                    failureReason = var13.getError(false) or ""
                })
            elseif var15 == "Empty" then
                fireAnalyticsEvent(
                    EventNames.FeedNoMomentsFetched,
                    {
                        recommendationSource = source.recommendationSource or "",
                        feedSourceId = source.id or ""
                    }
                )
            end
        end

        var42.current = var15
    end, { var15 })

    local var43 = React.useRef(false)

    React.useEffect(function()
        if var38 and not var43.current then
            local var44 = var13.pager.getItems(false)[var13.pager.getCurrentIndex(false)]
            local var45 = if var44 == nil then nil else feedItemAttribution(var44)
            fireAnalyticsEvent(EventNames.FeedLoadMoreFailed, {
                recommendationSource = source.recommendationSource or "",
                feedSourceId = source.id or "",
                itemId = if var45 == nil then nil else var45.itemId,
                tracingId = if var45 == nil then nil else var45.tracingId
            })
        end
        var43.current = var38
    end, { var38 })

    local removeCurrentItem = React.useCallback(function()
        local currentIndex = var13.pager.getCurrentIndex(false)
        local current = controllerRef.current
        if current ~= nil then
            current.removeItem(currentIndex)
        end
    end, { var13 })

    local onConfirm = React.useCallback(function()
        if var12 then
            local momentId = var12.momentId
            local feedItemId = var12.feedItemId
            local feedSessionId = var12.feedSessionId

            if feedItemId == nil or feedItemId == "" then
                var11.clearPendingDeletion()
                return
            end

            task.spawn(function()
                local var45, var46 = deleteMoment(feedItemId):await()
                if not var45 then
                    getLogger():warning("Failed to delete moment {}: {}", momentId, tostring(var46))
                end
            end)
            removeCurrentItem()

            if FFlagMomentsRemoveDeletedFromProfile or FFlagMomentsOptimisticProfilePending then
                GetDeletedMomentsStore(false).markDeleted(momentId)
            end

            local feedActionFields = makeFeedActionFields(momentId, feedItemId, feedSessionId, "delete")
            if feedActionFields then
                fireAnalyticsEvent(EventNames.MomentItemDeleted, feedActionFields)
            end
            if FFlagMomentsDeleteSnackbar then
                toastStore.triggerToast({ title = var10.deletedToast, text = "", variant = "snackbar" })
            elseif FFlagMomentsFixDeleteToastCopy then
                toastStore.triggerToast({ title = var10.deletedToast, text = "" })
            else
                toastStore.triggerToast({ title = var10.deletedTitle, text = var10.deletedBody })
            end
        end
        var11.clearPendingDeletion()
    end, {
        var12,
        var11,
        toastStore,
        var10,
        removeCurrentItem
    })

    local onCancel = React.useCallback(function()
        var11.clearPendingDeletion()
    end, { var11 })

    local var47 = React.useCallback(function(arg1, failureReason: string?)
        local logger = getLogger()
        local momentId = arg1.momentId
        local assetId = arg1.assetId
        logger:debug(
            "Filtering moment after media load failure | momentId: {}, assetId: {}, captureType: {}, failureReason: {}",
            momentId,
            tostring(assetId),
            arg1.metadata.captureType.Name,
            failureReason or "nil"
        )
        local mediaLoadEventFields = makeMediaLoadEventFields(arg1, source)
        if failureReason ~= nil then
            mediaLoadEventFields.failureReason = failureReason
        end
        fireAnalyticsEvent(EventNames.FeedMediaLoadFailed, mediaLoadEventFields)
    end, { source })

    local var48 = React.useCallback(function(momentId: string, str1: string?)
        if var39.current[momentId] then
            return
        end

        for value, value2 in (var13.pager.getItems(false)) do
            if value2.kind ~= "moment" and (not FFlagMomentsRenderAvatarPostsInFeed or value2.kind ~= "avatarMoment")
                or value2.moment.momentId ~= momentId
            then
                continue
            end
            var39.current[momentId] = true
            var47(value2.moment, str1)
            local current = controllerRef.current
            if current ~= nil then
                current.removeItem(value)
                return
            end
            var13.pager.removeItem(value)

            return
        end
    end, { var13, var47 })

    local onMediaItemLoadAttempted = React.useCallback(function(momentId: string)
        Analytics.reportMomentsFeedMediaLoad("attempted", var13.observabilityFeedType)

        if not FFlagMomentsFeedMediaLoadAttemptedEvent then
            return
        end

        for _, value in var13.pager.getItems(false) do
            if value.kind == "moment" and value.moment.momentId == momentId then
                fireAnalyticsEvent(EventNames.FeedMediaLoadAttempted, (makeMediaLoadEventFields(value.moment, source)))
                return
            end
        end
    end, { var13, source })

    local onMediaItemFailed = React.useCallback(function(str1: string, str2: string?)
        Analytics.reportMomentsFeedMediaLoad("failed", var13.observabilityFeedType, str2)
        var48(str1, str2)
    end, { var13, var48 })

    local value = React.useMemo(function()
        local module = {
            getStatus = var13.getStatus,
            isActiveFeed = isActiveFeed,
            isPlaybackActive = bool1,
            getCurrentIndex = if FFlagMomentsRenderAvatarPostsInFeed then var13.pager.getCurrentIndex else nil,
            getCurrentItem = if FFlagMomentsCommentDeepLinks then var13.pager.getCurrentItem else nil,
            recommendationSource = source.recommendationSource,
            logAction = 0,
            flushView = 0,
            getChromeVisible = 0,
            revealChrome = 0,
            removeCurrentItem = 0,
            scrollToNext = 0,
            loadMoreBeyondLimit = 0,
            getCanLoadMoreBeyondLimit = 0,
            caughtUpState = 0
        }

        function module.logAction(arg1, arg2, tbl4)
            return telemetry.logAction(arg1, arg2, tbl4)
        end
        module.flushView = var32.flushView

        module.getChromeVisible = immersiveChromeStore.getChromeVisible
        module.revealChrome = immersiveChromeStore.revealChrome
        module.removeCurrentItem = removeCurrentItem
        module.scrollToNext = var34
        module.loadMoreBeyondLimit = if GetFFlagMomentsNonInfiniteScroll() then var13.loadBeyondLimit else nil
        module.getCanLoadMoreBeyondLimit = var13.getCanLoadMoreBeyondLimit
        module.caughtUpState = tbl2.caughtUpState
        return module
    end, {
        var13,
        isActiveFeed,
        bool1,
        source,
        telemetry,
        var32.flushView,
        immersiveChromeStore,
        removeCurrentItem,
        var34,
        tbl2.caughtUpState
    })

    local var52 = var3 and (var15 == "Loaded" or var15 == "LoadingMore")
    local active = var7 and not (var15 == "Failed") and not (var15 == "Empty") and not var16
    local createElement = React.createElement
    local provider = FeedContext2.Provider
    local tbl4 = { value = value }
    local tbl5 = { Root = 0 }
    local createElement2 = React.createElement
    local str1 = "Frame"
    local tbl6 = {
        AnchorPoint = tbl2.AnchorPoint,
        BackgroundTransparency = 1,
        LayoutOrder = tbl2.LayoutOrder,
        Position = tbl2.Position,
        Size = tbl2.Size or UDim2.fromScale(1, 1),
        ZIndex = tbl2.ZIndex
    }
    local tbl7 = {
        Pager = 0,
        StateOverlay = 0,
        NavBar = 0,
        ImmersiveController = 0,
        SwipeLatency = 0,
        DeletionDialog = 0
    }
    local func1 = withLimitReachedHidden

    local createElement3 = React.createElement
    local var54 = VerticalPager2
    local tbl8 = {
        store = var13.pager,
        renderItem = renderFeedItem,
        keyExtractor = feedItemKey,
        analytics = analytics,
        onEndReached = var13.loadMore,
        active = active,
        controllerRef = controllerRef,
        initialIndex = if FFlagMomentsOptimisticProfilePending then var36 or tbl2.initialIndex else tbl2.initialIndex,
        tuning = tbl2.pager,
        Size = UDim2.fromScale(1, 1),
        ZIndex = 1
    }
    tbl7.Pager = func1(var16, createElement3(var54, tbl8))

    tbl7.StateOverlay = React.createElement(FeedStateView, {
        status = var15,
        loadMoreFailed = var38 or FFlagMomentsOptimisticProfilePending and var37 ~= nil,
        onRetry = var13.retry,
        emptyContent = tbl2.emptyContent,
        emptyState = tbl2.emptyState,
        zIndex = 2
    })

    tbl7.NavBar = if var52 then React.createElement(
        FeedNavigationBar,
        {
            pager = var13.pager,
            active = var7,
            onScrollToNext = var34,
            onScrollToPrevious = onScrollToPrevious,
            zIndex = 3
        }
    ) else nil

    tbl7.ImmersiveController = React.createElement(
        ImmersiveChromeController,
        {
            pager = var13.pager,
            active = isActiveFeed and bool1,
            controllerRef = controllerRef,
            coveringOverlay = var5
        }
    )

    tbl7.SwipeLatency = React.createElement(
        SwipeLatencyTracker,
        {
            pager = var13.pager,
            controllerRef = controllerRef,
            onTargetCommittedRef = onTargetCommittedRef
        }
    )
    tbl7.DeletionDialog = if var12 == nil then nil else React.createElement(DeletionConfirmationDialog, { onCancel = onCancel, onConfirm = onConfirm })
    tbl5.Root = createElement2(str1, tbl6, tbl7)
    local feed = createElement(provider, tbl4, tbl5)

    return React.createElement(
        MomentMediaCoordinatorProvider,
        {
            pager = var13.pager,
            playbackActive = var9,
            createCoordinator = tbl2.createCoordinator,
            onMediaItemLoadAttempted = onMediaItemLoadAttempted,
            onMediaItemFailed = onMediaItemFailed
        },
        bool2 and {
            Feed = feed,
            SurfaceReadyTracker = React.createElement(SurfaceReadyTracker, { pager = var13.pager })
        }
            or feed
    )
end

return Feed

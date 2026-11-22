-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:20:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local ReactUtils = require(MomentsParent.ReactUtils)
local SignalsReact = require(MomentsParent.SignalsReact)

local BuilderIcons = require(MomentsParent.BuilderIcons)
local Foundation = require(MomentsParent.Foundation)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local SharedFlags = require(MomentsParent.SharedFlags)

local View = Foundation.View

local GetMomentsCapabilities = MomentsCommon.Stores.GetMomentsCapabilities
local useSignalBinding = SignalsReact.useSignalBinding
local useSignalState = SignalsReact.useSignalState

local MomentContext = require(script.Parent.Parent.Parent.MomentContext)
local RailItem = require(script.Parent.RailItem)
local ReactionButton = require(script.Parent.ReactionButton)
local ContextualMenu = require(Moments.Components.Feed.ContextualMenu)
local useMomentsSession = require(Moments.Stores.GetMomentsStore.MomentsSessionContext).useMomentsSession
local GetMomentsPreferencesStore = require(Moments.Stores.GetMomentsPreferencesStore)
local useCommentCapabilities = require(Moments.Components.Comments.useCommentCapabilities)
local FFlagMomentsActionRailNarrowWidth = require(Moments.Flags.FFlagMomentsActionRailNarrowWidth)
local FFlagMomentsActionRailSpacing = require(Moments.Flags.FFlagMomentsActionRailSpacing)
local FFlagMomentsCreatorAnalytics = require(Moments.Flags.FFlagMomentsCreatorAnalytics)
local FFlagMomentsRecommendationContentType = require(Moments.Flags.FFlagMomentsRecommendationContentType)
local FFlagMomentsOptimisticProfilePending = SharedFlags.FFlagMomentsOptimisticProfilePending
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local FFlagMomentsCommentsIxpEnabled = SharedFlags.FFlagMomentsCommentsIxpEnabled
local FFlagMomentsReactFeatureGate = SharedFlags.FFlagMomentsReactFeatureGate
local FFlagMomentsServeEDPVideos = SharedFlags.FFlagMomentsServeEDPVideos
local FFlagMomentsEngagementMetricsFeature = MomentsCommon.Flags.FFlagMomentsEngagementMetricsFeature
local useConfiguration = require(Moments.Hooks.useConfiguration)
local useShareMoment = require(Moments.Share.useShareMoment)
local useCommentActionImpression = require(script.Parent.useCommentActionImpression)

local ArrowThickToRight = BuilderIcons.Icon.ArrowThickToRight
local SpeechBubbleAlignLeft = BuilderIcons.Icon.SpeechBubbleAlignLeft

return React.memo(function(tbl1) -- name: ActionRail
    local nextOrder = ReactUtils.createNextOrder()

    local var1 = MomentContext.useMoment()
    local store = var1.store
    local data = store.getData(false)
    local bool1 = data.kind == "ad"
    local var2 = if FFlagMomentsEngagementMetricsFeature then useSignalState(GetMomentsCapabilities(false).getIsEngagementMetricsEnabled) else nil
    local var3 = not FFlagMomentsReactFeatureGate or useSignalState(GetMomentsCapabilities(false).getCanReactToMoments)

    local var4 = useShareMoment(tbl1.moment)

    local animationRatio = var1.animationRatio
    local var5 = useSignalBinding(store.getShareCount)
    local var6 = if FFlagMomentsComments then useSignalBinding(store.getCommentCount) else nil
    local isDisabled = useSignalState(store.getIsModerated)
    local var8 = FFlagMomentsOptimisticProfilePending and data.isPending == true
    local var7 = isDisabled or var8
    local feedItemId = if tbl1.moment == nil or tbl1.moment.recommendationMetadata == nil then nil else tbl1.moment.recommendationMetadata.feedItemId
    local var9 = var7 or feedItemId == nil or feedItemId == ""

    local isFeedMuteEnabled = useConfiguration("feed_mute_enabled", false)
    local isFeedMuteButtonAnalyticsEnabled = useConfiguration("feed_mute_button_analytics_enabled", false)

    local var13 = useMomentsSession()
    local momentsPreferencesStore = GetMomentsPreferencesStore(false)

    local var14 = useSignalState(var13.getHideDetails)
    local comments = if tbl1.moment == nil then nil else tbl1.moment.comments
    local canRead = useCommentCapabilities().canRead
    local bool2 = FFlagMomentsServeEDPVideos

    if bool2 then
        if tbl1.moment == nil then
            bool2 = false
        else
            bool2 = tbl1.moment.entityType == "edpVideo"
        end
    end

    local var15 = canRead and not (var14 or bool1) and not bool2 and (comments == nil or comments.viewerCanRead)
    if FFlagMomentsComments or FFlagMomentsCommentsIxpEnabled then
        useCommentActionImpression(var15 and tbl1.moment ~= nil)
    end
    local isMuted = useSignalState(momentsPreferencesStore.getFeedGlobalMute)
    local playbackVolume = React.useMemo(function()
        return {
            isMuted = isMuted,
            toggle = momentsPreferencesStore.toggleFeedGlobalMute
        }
    end, { isMuted, momentsPreferencesStore.toggleFeedGlobalMute })

    local tbl2 = {}

    if var3 and not (var14 or bool1) then
        tbl2.React = React.createElement(ReactionButton, { animationRatio = animationRatio, isDisabled = var7, LayoutOrder = nextOrder() })
    end

    if FFlagMomentsComments and var15 then
        local createElement = React.createElement
        local var18 = RailItem
        local tbl3 = {
            LayoutOrder = nextOrder(),
            slot = SpeechBubbleAlignLeft,
            count = 0,
            countIsCapped = 0,
            animationRatio = 0,
            isDisabled = 0,
            onActivated = 0,
            testId = "moments-comment-button"
        }

        if FFlagMomentsEngagementMetricsFeature and not var2 then
            var6 = nil
        end

        tbl3.count = var6
        tbl3.countIsCapped = not (comments == nil) and comments.countIsCapped == true
        tbl3.animationRatio = animationRatio
        tbl3.isDisabled = var7
        function tbl3.onActivated()
            if not var7 and feedItemId ~= nil and feedItemId ~= "" and tbl1.onOpenComments ~= nil then
                tbl1.onOpenComments()
            end
        end

        tbl2.Comment = createElement(var18, tbl3)
    end

    if not var14 then
        local createElement = React.createElement
        local var18 = RailItem
        local tbl3 = {
            LayoutOrder = nextOrder(),
            slot = ArrowThickToRight,
            count = 0,
            animationRatio = 0,
            isDisabled = 0,
            onActivated = 0
        }

        if FFlagMomentsEngagementMetricsFeature and not var2 then
            var5 = nil
        end

        tbl3.count = var5
        tbl3.animationRatio = animationRatio
        tbl3.isDisabled = var9
        tbl3.onActivated = var4.onShareActivated
        tbl2.Share = createElement(var18, tbl3)

        local musicButton = require(script.Parent.MusicButton)
        tbl2.Music = React.createElement(
            musicButton,
            {
                LayoutOrder = nextOrder(),
                moment = tbl1.moment,
                animationRatio = animationRatio,
                isDisabled = isDisabled
            }
        )
    end

    if tbl1.moment ~= nil then
        local createElement = React.createElement
        local var18 = ContextualMenu
        local tbl3 = {
            isFeedMuteEnabled = isFeedMuteEnabled,
            isFeedMuteButtonAnalyticsEnabled = isFeedMuteButtonAnalyticsEnabled,
            isDisabled = isDisabled,
            layoutOrder = nextOrder(),
            moment = tbl1.moment,
            contentType = if FFlagMomentsRecommendationContentType then data.contentType else nil,
            momentStore = 0,
            playbackVolume = 0
        }

        if not FFlagMomentsCreatorAnalytics then
            store = nil
        end

        tbl3.momentStore = store
        tbl3.playbackVolume = playbackVolume
        tbl2.ContextualMenu = createElement(var18, tbl3)
    end

    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = FFlagMomentsActionRailNarrowWidth
            and (if FFlagMomentsActionRailSpacing then "col align-x-center gap-large size-1000-0 auto-y" else "col align-x-center size-1000-0 auto-y")
            or (if FFlagMomentsActionRailSpacing then "col align-x-center gap-large size-1200-0 auto-y" else "col size-1200-0 auto-y"),
        testId = if FFlagMomentsActionRailSpacing or FFlagMomentsActionRailNarrowWidth then "moments-action-rail" else nil
    }, tbl2)
end)

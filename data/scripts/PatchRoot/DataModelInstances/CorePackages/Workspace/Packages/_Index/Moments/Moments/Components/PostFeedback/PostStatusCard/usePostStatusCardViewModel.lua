-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local React = require(MomentsParent.React)
local SharedFlags = require(MomentsParent.SharedFlags)
local SignalsReact = require(MomentsParent.SignalsReact)

local ButtonVariant = Foundation.Enums.ButtonVariant
local EventNames = MomentsCommon.Analytics.EventNames
local feedPlaybackSuspension = MomentsCommon.Media.feedPlaybackSuspension
local fireAnalyticsEvent = MomentsCommon.Analytics.fireAnalyticsEvent
local reportModalCovering = MomentsCommon.Media.reportModalCovering
local useDeviceInsets = MomentsCommon.Hooks.useDeviceInsets
local useLocalization = Localization.Hooks.useLocalization
local useSignalState = SignalsReact.useSignalState
local useStatusBarHeight = MomentsCommon.Hooks.useStatusBarHeight
local useTokens = Foundation.Hooks.useTokens
local FFlagEnableArgus = SharedFlags.FFlagEnableArgus

local _PostStatusCardView = require(script.Parent.PostStatusCardView)
local GetPostStatusCardStore = require(Moments.Stores.GetPostStatusCardStore)
local makePostFeedbackEventFields = require(Moments.Analytics.makePostFeedbackEventFields)
local _createPostStatusCardStore = require(Moments.Stores.GetPostStatusCardStore.createPostStatusCardStore)
local createRecommendationTelemetry = require(Moments.Components.Feed.createRecommendationTelemetry)
local _FeedTypes = require(Moments.Components.Feed.FeedTypes)
local makeRecommendationAttribution = require(Moments.Analytics.makeRecommendationAttribution)
local SignalActionType = require(Moments.Enums.SignalActionType)
local useMomentsSession = require(Moments.Stores.GetMomentsStore.MomentsSessionContext).useMomentsSession
local shareMoment = require(Moments.Share.shareMoment)
local useMomentsTabIsVisible = require(Moments.Hooks.useMomentsTabIsVisible)
local usePostStatusCardMotion = require(script.Parent.usePostStatusCardMotion)
local usePostFeedbackStrings = require(Moments.Components.PostFeedback.usePostFeedbackStrings)
local FFlagMomentsFollowingFeed = require(Moments.Flags.FFlagMomentsFollowingFeed)
local FFlagMomentsComments = SharedFlags.FFlagMomentsComments
local getCommentsSheetStore = if FFlagMomentsComments then require(Moments.Components.Comments.Sheet.getCommentsSheetStore) else nil
local FFlagMomentsCreatorAnalytics = require(Moments.Flags.FFlagMomentsCreatorAnalytics)
local getPostInsightsPageStore = if FFlagMomentsCreatorAnalytics then require(Moments.Components.PostInsights.getPostInsightsPageStore) else nil
game:DefineFastInt("MomentsPostStatusLiveDismissSeconds", 5)
game:DefineFastInt("MomentsPostStatusFailedDismissSeconds", 5)

local tbl1 = {
    shareLinkTitle = "Feature.Moments.Label.ShareLinkTitle",
    linkCopied = "Feature.Moments.Label.LinkCopied",
    linkCopyFailed = "Feature.Moments.Label.LinkCopyFailed"
}

local function isShownCardType(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return arg1.cardType == "Live" or arg1.cardType == "UploadFailed"
end

local function getOldestShownCard(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    for i = #tbl2, 1, -1 do
        if isShownCardType(tbl2[i]) then
            return tbl2[i]
        end
    end
    return nil
end

local function getShareFeedItemId(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local publishedMoment = arg1.publishedMoment
    if publishedMoment == nil then
        return nil
    end
    local feedItemId = publishedMoment.recommendationMetadata.feedItemId
    return if feedItemId == nil or feedItemId == "" then nil else feedItemId
end

local function makeMedia(arg1)
    if arg1.cardType ~= "Live" then
        return { kind = "unavailable" }
    end
    local localContent = arg1.localContent
    if localContent == nil then
        return { kind = "momentsIcon" }
    end
    local captureType = arg1.captureType or Enum.CaptureType.Screenshot
    local tbl2 = { kind = "thumbnail", mediaItem = 0 }

    local mediaItem = {
        momentId = arg1.id,
        content = localContent,
        posterContent = 0,
        captureType = 0
    }
    if captureType == Enum.CaptureType.Video then
        localContent = nil
    end

    mediaItem.posterContent = localContent
    mediaItem.captureType = captureType
    tbl2.mediaItem = mediaItem
    return tbl2
end

local function usePostStatusCardViewModel(): {actions: number, body: number, leftInset: number, media: number, rightInset: number, shown: number, title: number, topInset: number}?
    local postStatusCardStore = GetPostStatusCardStore(false)
    local var1 = useSignalState(postStatusCardStore.getCards)
    local var2 = useMomentsTabIsVisible()

    local var3 = useSignalState(reportModalCovering.getCovering)
    local var4 = useSignalState(feedPlaybackSuspension.getSuspended)
    local var5 = if FFlagMomentsComments and getCommentsSheetStore ~= nil then useSignalState(getCommentsSheetStore(false).getIsExpanded) else false
    local var6 = if FFlagMomentsCreatorAnalytics and getPostInsightsPageStore ~= nil then useSignalState(getPostInsightsPageStore(false).getIsOpen) else false
    local var7 = usePostFeedbackStrings()
    local var8 = useLocalization(tbl1)
    local var9 = useTokens()
    local var10 = useStatusBarHeight()
    local var11 = useDeviceInsets()
    local var12 = useMomentsSession()

    local var13 = React.useMemo(function()
        if not FFlagEnableArgus then
            return nil
        end
        return createRecommendationTelemetry({ getMomentsSessionId = var12.getMomentsSessionId })
    end, { var12 })

    local var14 = React.useRef(nil)
    local current = if var2 and not (var3 or var4 or var5 or var6) then getOldestShownCard(var1) else nil
    local id = if current == nil then nil else current.id
    local cardType = if current == nil then nil else current.cardType
    local var15 = usePostStatusCardMotion(id)
    local hide = var15.hide

    React.useEffect(function()
        if id == nil then
            return nil
        end

        local fastInt = if cardType == "Live" then game:GetFastInt("MomentsPostStatusLiveDismissSeconds") else game:GetFastInt("MomentsPostStatusFailedDismissSeconds")

        local var16 = task.delay(fastInt, function()
            var14.current = id
            hide(function()
                postStatusCardStore.dismiss(id)
            end)
        end)
        return function()
            task.cancel(var16)
        end
    end, {
        postStatusCardStore,
        id,
        cardType,
        hide
    })

    local var16 = React.useRef(current)
    var16.current = current
    React.useEffect(function()
        local current = var16.current
        if current == nil or not postStatusCardStore.markShown(current.id) then
            return
        end
        local postFeedbackEventFields = makePostFeedbackEventFields(current)
        postFeedbackEventFields.cardType = current.cardType
        fireAnalyticsEvent(EventNames.MomentPostStatusCardShown, postFeedbackEventFields)
    end, { postStatusCardStore, id })

    local media = React.useMemo(function()
        if current ~= nil then
            return (makeMedia(current))
        end

        return nil
    end, { current })

    if current == nil then
        return nil
    end

    local function close(): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
        if var14.current == current.id then
            return false
        end
        var14.current = current.id
        hide(function()
            postStatusCardStore.dismiss(current.id)
        end)
        return true
    end

    local actions = {}
    local feedItemId = getShareFeedItemId(current)
    local publishedMoment = current.publishedMoment
    if current.cardType == "Live" and publishedMoment ~= nil and feedItemId ~= nil then
        table.insert(actions, {
            text = var7.share,
            variant = ButtonVariant.SoftEmphasis,
            onActivated = function()
                if not close() then
                    return
                end
                fireAnalyticsEvent(EventNames.MomentPostStatusCardShareTapped, makePostFeedbackEventFields(current))
                local recommendationAttribution = makeRecommendationAttribution(publishedMoment.recommendationMetadata, publishedMoment)
                shareMoment({
                    momentId = publishedMoment.momentId,
                    feedItemId = feedItemId,
                    feedSessionId = publishedMoment.recommendationMetadata.tracingId,
                    description = publishedMoment.metadata.description,
                    logAction = var13 ~= nil and recommendationAttribution ~= nil and function(arg1)
                        return var13.logAction(SignalActionType.Share, recommendationAttribution, arg1)
                    end or nil,
                    strings = {
                        linkPreviewTitle = var8.shareLinkTitle,
                        linkCopied = var8.linkCopied,
                        linkCopyFailed = var8.linkCopyFailed
                    }
                })
            end
        })
    end
    table.insert(actions, {
        text = var7.dismiss,
        variant = ButtonVariant.Standard,
        onActivated = function()
            if close() then
                local postFeedbackEventFields = makePostFeedbackEventFields(current)
                postFeedbackEventFields.cardType = current.cardType
                postFeedbackEventFields.dismissMethod = "button"
                fireAnalyticsEvent(EventNames.MomentPostStatusCardDismissed, postFeedbackEventFields)
            end
        end
    })

    local bool1 = current.cardType == "Live"
    return {
        title = if bool1 then var7.liveTitle else var7.failedTitle,
        body = if bool1 then var7.liveBody else var7.failedBody,
        media = media,
        actions = actions,
        shown = var15.shown,
        topInset = var10 + var9.Size.Size_1400 + (if FFlagMomentsFollowingFeed then var9.Size.Size_800 else 0) + var9.Padding.Small,
        leftInset = var11.left,
        rightInset = var11.right
    }
end

return usePostStatusCardViewModel

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")

local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)
local UIBlox = require(MomentsParent.UIBlox)
local UserProfile = require(MomentsParent.DataHydration.UserProfile)

local MomentsGetMomentsCommentsStore = require(MomentsParent.DataHydration.MomentsGetMomentsCommentsStore)
local GetCommentReactionsStore = require(Moments.Stores.GetCommentReactionsStore)
local useMomentGestures = require(Moments.Components.Feed.Items.Moment.Reactions.useMomentGestures)
local usePreferredInput = require(Moments.Hooks.usePreferredInput)
local CommentLongPressTiming = require(script.Parent.CommentLongPressTiming)
local _CommentRowView = require(script.Parent.CommentRowView)
local useCommentActionsMenu = require(script.Parent.useCommentActionsMenu)
local useCommentBodyClamp = require(script.Parent.useCommentBodyClamp)
local useCommentBodyPressFeedback = require(script.Parent.useCommentBodyPressFeedback)
local useCommentBodyToggle = require(script.Parent.useCommentBodyToggle)
local useCommentBodyTranslationFade = require(script.Parent.useCommentBodyTranslationFade)
local useCommentTimestamp = require(script.Parent.useCommentTimestamp)
local _CommentRowTypes = require(script.Parent.Parent.CommentRowTypes)

local FFlagMomentsEngagementMetricsFeature = MomentsCommon.Flags.FFlagMomentsEngagementMetricsFeature
local GetMomentsCapabilities = MomentsCommon.Stores.GetMomentsCapabilities

local FeedbackManagerInjectionContext = UIBlox.Core.Control.FeedbackManagerInjectionContext
local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    info = Signals.createComputed(function(_)
        return nil
    end),
    status = Signals.createComputed(function(_): string
        return "Ready"
    end)
}

local function nonEmpty(str1: string?): string? -- Luacid: Inlined by compiler; 5 call sites recovered
    return if str1 == nil or str1 == "" then nil else str1
end

local function getTranslationToggle(translationState, onToggle: ((...any) -> (...any))?): {isShowingTranslation: boolean, onToggle: (...any) -> (...any)}? -- Luacid: Inlined by compiler; 1 call site recovered
    return if translationState == nil or onToggle == nil then nil else {
        isShowingTranslation = translationState == "Translated",
        onToggle = onToggle
    }
end

local function countForEmote(reactions, emoteId: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    if reactions == nil or emoteId == nil then
        return 0
    end
    for _, count in reactions.counts do
        if count.emoteId == emoteId then
            return count.count
        end
    end
    return 0
end

local function useCommentRowViewModel(tbl2)
    local var1 = React.useMemo(function()
        return MomentsGetMomentsCommentsStore(false).getCachedComment(tbl2.commentId)
    end, { tbl2.commentId })
    local var2 = SignalsReact.useSignalState(var1.data)
    local userId = if var2 == nil or var2.author == nil then nil else var2.author.userId
    local var3 = if userId ~= nil then tonumber(userId) else nil

    if var3 ~= nil and var3 <= 0 then
        var3 = nil
    end

    local var4 = React.useMemo(function()
        if var3 ~= nil then
            return UserProfile.getAndFetchUserInfo(var3)
        end
        return tbl1
    end, { var3 })
    local var5 = SignalsReact.useSignalState(var4.info)
    local var6 = SignalsReact.useSignalState(var4.status)
    local authorLabel = if var2 == nil or var2.author == nil then nil else nonEmpty(var2.author.username)
    local var8 = if var2 == nil or var2.author == nil then nil else nonEmpty(var2.author.displayName)
    local var9 = if var5 == nil then nil else nonEmpty(var5.username)
    local var10 = if var5 == nil then nil else nonEmpty(var5.displayName)
    local label = useLocalization({
        label = if userId == nil then "Feature.Moments.Label.CommentAuthorUnknown" else {
            "Feature.Moments.Label.CommentAuthorFallback",
            userId = userId
        }
    }).label
    local var11 = nonEmpty(tbl2.viewerUsername)
    if var2 == nil or not var2.isAuthoredByViewer then
        var11 = nil
    end

    local var12 = authorLabel or var11 or var8
    local var13 = if tbl2.createdAt ~= "" then tbl2.createdAt elseif var2 == nil then "" else var2.createdAt
    local metadataLabel = useCommentTimestamp(var13)
    local reactions = if var2 == nil then nil else var2.reactions
    local commentReactionsStore = GetCommentReactionsStore(false)
    local var15 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            return commentReactionsStore.getProjection(tbl2.feedItemId, tbl2.commentId, reactions, arg1)
        end)
    end, {
        commentReactionsStore,
        tbl2.feedItemId,
        tbl2.commentId,
        reactions or false
    })

    local var16 = SignalsReact.useSignalState(var15)
    local var17 = SignalsReact.useSignalState(commentReactionsStore.getCooldownUntilMs)
    local reactions2 = var16.reactions
    local thumbsUpEmoteId = tbl2.thumbsUpEmoteId
    local showReactionControl = not (reactions == nil or reactions2 == nil) and thumbsUpEmoteId ~= nil
    local emoteId = if reactions2 == nil or reactions2.userReaction == nil then nil else reactions2.userReaction.emoteId
    local isReactionSelected = not (thumbsUpEmoteId == nil) and emoteId == thumbsUpEmoteId
    local bool3 = not (emoteId == nil) and not isReactionSelected
    local isReactionDisabled = not tbl2.creatorEnabled
        or not tbl2.viewerCanWrite
        or var16.restriction ~= nil
        or DateTime.now().UnixTimestampMillis < var17
        or bool3
    local var18 = countForEmote(reactions2, thumbsUpEmoteId)
    local reactionCountLabel = Localization.abbreviateCount(var18, LocalizationService.RobloxLocaleId) or tostring(var18)
    local isReactionCountHidden = if FFlagMomentsEngagementMetricsFeature then not SignalsReact.useSignalState(GetMomentsCapabilities(false).getIsEngagementMetricsEnabled) else nil
    local bool6 = showReactionControl and not (isReactionDisabled or isReactionSelected)

    local onReactionActivated = React.useCallback(function()
        if not showReactionControl or isReactionDisabled or reactions == nil or thumbsUpEmoteId == nil then
            return
        end
        tbl2.onToggleReaction(tbl2.commentId, thumbsUpEmoteId, reactions, isReactionSelected)
    end, {
        showReactionControl,
        isReactionDisabled,
        reactions,
        thumbsUpEmoteId,
        tbl2.onToggleReaction,
        tbl2.commentId,
        isReactionSelected
    })

    local onDoubleTap = React.useCallback(function()
        if not showReactionControl or isReactionDisabled or isReactionSelected or reactions == nil or thumbsUpEmoteId == nil then
            return
        end
        tbl2.onAddReaction(tbl2.commentId, thumbsUpEmoteId, reactions)
    end, {
        showReactionControl,
        isReactionDisabled,
        isReactionSelected,
        reactions,
        thumbsUpEmoteId,
        tbl2.onAddReaction,
        tbl2.commentId
    })

    local bool7 = usePreferredInput() == Enum.PreferredInput.Touch
    local var22 = React.useContext(FeedbackManagerInjectionContext)
    local var23 = useCommentActionsMenu({
        commentId = tbl2.commentId,
        isAuthoredByViewer = not (var2 == nil) and var2.isAuthoredByViewer,
        authorUserId = if var2 == nil or var3 == nil then nil else tostring(var3),
        onReportComment = tbl2.onReportComment,
        onBlockCommentAuthor = tbl2.onBlockCommentAuthor,
        onDeleteComment = tbl2.onDeleteComment
    })
    local bool8 = #var23.items > 0
    local bool9 = bool7 and bool8
    local bool10 = tbl2.isExpanded == true
    local var24 = useCommentBodyClamp(tbl2.text, bool10)

    local var25 = useCommentBodyToggle(var24, tbl2.onToggleExpanded, tbl2.commentId, bool10, bool6)
    local var26 = useCommentBodyPressFeedback(tbl2.commentId, var25.canToggle)

    local bodyTextStyle = useCommentBodyTranslationFade(tbl2.commentId, tbl2.translationState, var26.textStyle)
    local isGestureSurfaceActive = bool6 or bool9 or var25.isActive

    local var29, var30 = React.useState(nil)
    React.useLayoutEffect(function()
        var30(nil)
    end, { tbl2.commentId })
    local var31 = React.useCallback(function()
        var30(tbl2.commentId)
    end, { tbl2.commentId })
    local var32 = React.useCallback(function()
        var30(nil)
    end, {})
    local openMenu = var23.openMenu
    local var33 = React.useCallback(function()
        var30(nil)
        var22("TileLongPress", "Press")
        openMenu()
    end, { var22, openMenu })

    local var34 = useMomentGestures

    local tbl3 = {
        onTap = var25.onTap,
        onSingleTapConfirmed = var25.onSingleTapConfirmed,
        onDoubleTap = onDoubleTap,
        onLongPress = 0,
        onLongPressStart = 0,
        onLongPressCancel = 0
    }

    if not bool9 then
        var33 = nil
    end

    tbl3.onLongPress = var33
    if not bool9 then
        var31 = nil
    end

    tbl3.onLongPressStart = var31
    if not bool9 then
        var32 = nil
    end

    tbl3.onLongPressCancel = var32
    local var35 = var34(isGestureSurfaceActive, tbl3, nil, {
        scrollingFrameRef = tbl2.scrollingFrameRef,
        cancelWhenInactive = true,
        cancelOnUserScroll = true,
        longPressThreshold = CommentLongPressTiming.HOLD_SECONDS
    })

    local tbl4 = {
        commentId = tbl2.commentId,
        avatarUserId = var3,
        authorLabel = authorLabel or var11 or var9 or var8 or var10 or label,
        isAuthorLoading = var12 == nil and var5 == nil and var6 == "NotReady",
        text = tbl2.text,
        bodyText = var24.bodyText,
        bodyRef = var24.bodyRef,
        bodyMeasureRef = var24.measureRef,
        onBodyAbsoluteSizeChanged = var24.onBodyAbsoluteSizeChanged,
        bodyTextStyle = bodyTextStyle,
        metadataLabel = metadataLabel,
        avatarBackgroundStyle = tbl2.avatarBackgroundStyle,
        gestureRef = var35.ref,
        showReactionControl = showReactionControl,
        isReactionSelected = isReactionSelected,
        isReactionDisabled = isReactionDisabled,
        reactionCountLabel = reactionCountLabel,
        isReactionCountHidden = isReactionCountHidden,
        onReactionActivated = onReactionActivated,
        actionsMenu = if bool8 then {
            items = var23.items,
            isOpen = var23.isOpen,
            anchorRef = if bool7 then var35.ref else nil,
            onButtonActivated = var23.toggleMenu,
            onClose = var23.closeMenu
        } else nil,
        deleteConfirmation = var23.deleteConfirmation,
        translationToggle = getTranslationToggle(tbl2.translationState, tbl2.onToggleTranslation),
        isLongPressCharging = 0,
        isGestureSurfaceActive = 0,
        onContentStateChanged = 0
    }

    if var29 ~= tbl2.commentId then
        bool9 = false
    end

    tbl4.isLongPressCharging = bool9
    tbl4.isGestureSurfaceActive = isGestureSurfaceActive
    tbl4.onContentStateChanged = var26.onStateChanged
    return tbl4
end

return useCommentRowViewModel

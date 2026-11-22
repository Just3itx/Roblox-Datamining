-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)
local Signals = require(MomentsParent.Signals)
local SignalsReact = require(MomentsParent.SignalsReact)
local ViewRecycler = require(MomentsParent.ViewRecycler)
local MomentsCommon = require(MomentsParent.MomentsCommon)
local FFlagMomentsComments = require(MomentsParent.SharedFlags).FFlagMomentsComments
local FFlagMomentsCommentActionsRealtime = require(Moments.Flags.FFlagMomentsCommentActionsRealtime)
local FFlagMomentsCommentTranslation = require(Moments.Flags.FFlagMomentsCommentTranslation)
local FFlagMomentsCommentTranslationShownByDefault = require(Moments.Flags.FFlagMomentsCommentTranslationShownByDefault)
local FFlagMomentsCommentsRevealAfterMeasure = require(Moments.Flags.FFlagMomentsCommentsRevealAfterMeasure)
local FFlagMomentsCommentsScrollToPostedComment = require(Moments.Flags.FFlagMomentsCommentsScrollToPostedComment)
local FFlagMomentsCommentsAttachSheetScroller = require(Moments.Flags.FFlagMomentsCommentsAttachSheetScroller)
local EventNames = MomentsCommon.Analytics.EventNames

local MomentsGetMomentsCommentsStore = require(MomentsParent.DataHydration.MomentsGetMomentsCommentsStore)
local MomentsGetMomentsReactionsStore = require(MomentsParent.DataHydration.MomentsGetMomentsReactionsStore)
local MomentsResolveEmoteId = require(MomentsParent.DataHydration.MomentsResolveEmoteId)
local _MomentsTypes = require(MomentsParent.MomentsTypes)
local GetCommentCollectionStore = require(Moments.Components.Comments.GetCommentCollectionStore)
local CommentCollectionTypes = require(Moments.Components.Comments.GetCommentCollectionStore.CommentCollectionTypes)
local getCommentsListCoordinator = require(script.Parent.Parent.getCommentsListCoordinator)
local getCommentsSheetStore = require(Moments.Components.Comments.Sheet.getCommentsSheetStore)
local useCommentCapabilities = require(Moments.Components.Comments.useCommentCapabilities)
local GetToastStore = require(Moments.Stores.GetToastStore)
local useMomentsHost = require(Moments.MomentsHostContext).useMomentsHost
local ReactionType = require(Moments.Enums.ReactionType)
local buildCommentRows = require(script.Parent.Parent.Rows.buildCommentRows)
local _CommentRowTypes = require(script.Parent.Parent.Rows.CommentRowTypes)
local CommentsListItems = require(script.Parent.CommentsListItems)
local _CommentsListRowContext = require(script.Parent.CommentsListRowContext)
local _CommentsListView = require(script.Parent.CommentsListView)
local createExpandedCommentsStore = require(script.Parent.createExpandedCommentsStore)
local createToggledTranslationsStore = require(script.Parent.createToggledTranslationsStore)
local useCommentsListReveal = require(script.Parent.useCommentsListReveal)

local Players = game:GetService("Players")

local LoadStatus = CommentCollectionTypes.LoadStatus
local useLocalization = Localization.Hooks.useLocalization

local tbl1 = { deleteFailed = "Feature.Moments.Label.CommentDeleteFailed" }

local function showDeleteFailedToast(title: string) -- Luacid: Inlined by compiler; 1 call site recovered
    GetToastStore(false).triggerToast({ title = title, text = "" })
end

local function useCommentsListViewModel(tbl2)
    local deleteFailed = useLocalization(tbl1).deleteFailed
    local localPlayer = Players.LocalPlayer
    local viewerUsername = if localPlayer == nil then "" else localPlayer.Name
    local commentCollectionStore = GetCommentCollectionStore(false)
    local var1 = React.useMemo(function()
        return commentCollectionStore.getState(tbl2.feedItemId)
    end, { commentCollectionStore, tbl2.feedItemId })
    local var2 = SignalsReact.useSignalState(var1)

    local var3 = React.useState(createExpandedCommentsStore)
    local getExpandedCommentIds = var3.getExpandedCommentIds
    local var4 = if FFlagMomentsCommentTranslation then React.useState(createToggledTranslationsStore) else nil
    local getToggledCommentIds = if var4 == nil then nil else var4.getToggledCommentIds

    local var5 = React.useMemo(function()
        local var5 = nil
        return Signals.createComputed(function(arg1)
            local state = var1(arg1)
            local commentRows = buildCommentRows({
                state = state,
                resolveComment = function(arg2)
                    return MomentsGetMomentsCommentsStore(false).getCachedComment(arg2).data(arg1)
                end,
                previousRows = var5,
                expandedCommentIds = getExpandedCommentIds(arg1),
                translation = getToggledCommentIds ~= nil
                    and {
                        showsTranslationByDefault = FFlagMomentsCommentTranslationShownByDefault,
                        toggledCommentIds = getToggledCommentIds(arg1)
                    }
                    or nil
            })

            var5 = commentRows
            return commentRows
        end)
    end, { var1, getExpandedCommentIds, getToggledCommentIds or false })
    local var6 = SignalsReact.useSignalState(var5)
    local var7 = MomentsGetMomentsCommentsStore(false)
    local var8 = React.useMemo(function()
        return var7.getCachedMomentComments(tbl2.feedItemId)
    end, { var7, tbl2.feedItemId })
    local var9 = SignalsReact.useSignalState(var8.data)

    local var10 = MomentsGetMomentsReactionsStore(false)
    local var11 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local getCachedEmojiCatalog = var10.getCachedEmojiCatalog
            if getCachedEmojiCatalog == nil then
                return nil
            end
            local cachedEmojiCatalog = getCachedEmojiCatalog(arg1)
            if cachedEmojiCatalog.source ~= "cache" or cachedEmojiCatalog.status ~= "Ready" then
                return nil
            end
            return MomentsResolveEmoteId.resolveOptionalEmoteIdForReaction(cachedEmojiCatalog.emojis, ReactionType.ThumbsUp)
        end)
    end, { var10 })
    local var12 = SignalsReact.useSignalState(var11)
    if not useCommentCapabilities().canReact then
        var12 = nil
    end
    local var13 = Foundation.Hooks.useTokens()

    local small = var13.Padding.Small

    local size2000 = var13.Size.Size_2000
    local layout = React.useState(function()
        return ViewRecycler.Layout.measured({ estimatedItemLength = size2000 })
    end)

    React.useEffect(function()
        return function()
            layout.destroy()
        end
    end, { layout })

    local loadMoreStatus = var2.loadMoreStatus
    local isReadOnly = tbl2.isReadOnly
    local items = React.useMemo(function()
        local var15 = table.create(#var6 + 2)
        for value, value2 in var6 do
            var15[value] = value2
        end
        if loadMoreStatus == LoadStatus.Loading or loadMoreStatus == LoadStatus.Failed then
            table.insert(var15, CommentsListItems.loadMore(loadMoreStatus))
        end
        if isReadOnly then
            table.insert(var15, CommentsListItems.readOnlyNotice())
        end
        return var15
    end, { var6, loadMoreStatus, isReadOnly })
    local var16 = React.useMemo(function()
        return {
            items = items,
            getItemKey = CommentsListItems.getItemKey
        }
    end, { items })

    local var17 = nil
    local var18 = nil
    if FFlagMomentsCommentsRevealAfterMeasure and FFlagMomentsCommentsAttachSheetScroller then
        local var19 = React.useRef(tbl2.onRevealed)
        var19.current = tbl2.onRevealed
        local var20 = React.useCallback(function()
            local current = var19.current
            if current ~= nil then
                current()
            end
        end, {})

        React.useEffect(function()
            local var21 = task.delay(1, var20)
            return function()
                pcall(task.cancel, var21)
            end
        end, { var20 })

        var18 = var20
    elseif FFlagMomentsCommentsRevealAfterMeasure then
        var17 = useCommentsListReveal(layout, items, tbl2.onRevealed)
    end

    local commentsListCoordinator = getCommentsListCoordinator(false)
    local var19 = React.useCallback(function()
        return commentsListCoordinator.loadMore(tbl2.feedItemId, tbl2.sessionId)
    end, { commentsListCoordinator, tbl2.feedItemId, tbl2.sessionId })
    local var20 = React.useCallback(function()
        var19()
    end, { var19 })

    local var21 = React.useRef(0)
    local var22 = React.useRef(0)
    local var23 = React.useCallback(function()
        if var21.current > 0 and var22.current > 0 and var22.current <= var21.current then
            var19()
        end
    end, { var19 })
    local onViewportChanged = React.useCallback(function(vector2: Vector2)
        var21.current = vector2.Y
        var23()
    end, { var23 })
    local onContentLengthChanged = React.useCallback(function(current: number)
        var22.current = current
        var23()
    end, { var23 })

    local onRetryLoadMore = React.useCallback(function()
        commentsListCoordinator.retryLoadMore(tbl2.feedItemId, tbl2.sessionId)
    end, { commentsListCoordinator, tbl2.feedItemId, tbl2.sessionId })
    local onRetryPendingSubmission = React.useCallback(function()
        commentsListCoordinator.retryPendingSubmission(tbl2.feedItemId, tbl2.sessionId)
    end, { commentsListCoordinator, tbl2.feedItemId, tbl2.sessionId })
    local onEditPendingSubmission = React.useCallback(function()
        commentsListCoordinator.editPendingSubmission(tbl2.feedItemId, tbl2.sessionId)
    end, { commentsListCoordinator, tbl2.feedItemId, tbl2.sessionId })

    local var29 = if FFlagMomentsComments then getCommentsSheetStore(false).getAnalyticsSession(tbl2.feedItemId, tbl2.sessionId) else nil

    local onToggleReaction = React.useCallback(function(commentId: string, str2: string, arg1, bool1: boolean)
        if FFlagMomentsComments and var29 ~= nil then
            var29.logEvent(
                EventNames.MomentCommentReactButtonClicked,
                {
                    commentId = commentId,
                    reactionSelected = tostring(not bool1)
                }
            )
        end

        if bool1 then
            return commentsListCoordinator.ensureReactionAbsent(tbl2.feedItemId, commentId, str2, arg1)
        end
        return commentsListCoordinator.ensureReactionPresent(tbl2.feedItemId, commentId, str2, arg1)
    end, { commentsListCoordinator, tbl2.feedItemId, var29 })

    local onAddReaction = React.useCallback(function(str2: string, str3: string, arg1)
        return commentsListCoordinator.ensureReactionPresent(tbl2.feedItemId, str2, str3, arg1)
    end, { commentsListCoordinator, tbl2.feedItemId })

    local onToggleCommentTranslation = if FFlagMomentsCommentTranslation then React.useCallback(function(commentId: string)
        local bool1 = var4.getToggledCommentIds(false)[commentId] ~= true
        var4.toggle(commentId)
        if var29 ~= nil then
            var29.logEvent(
                EventNames.MomentCommentTranslationToggled,
                {
                    commentId = commentId,
                    isTranslationShown = tostring(bool1 ~= FFlagMomentsCommentTranslationShownByDefault)
                }
            )
        end
    end, { var4, var29 }) else nil

    local var33 = useMomentsHost()
    local openMomentCommentReport = var33.openMomentCommentReport
    local channelId = var2.channelId
    local onReportComment = React.useMemo(function(): ((string, string) -> ())?
        return if openMomentCommentReport == nil or channelId == nil then nil else function(commentId: string, reportedUserId: string)
            if FFlagMomentsComments and var29 ~= nil then
                var29.logEvent(EventNames.MomentCommentReportClicked, { commentId = commentId })
            end
            if FFlagMomentsCommentActionsRealtime and var29 ~= nil then
                var29.logRealtimeEvent("MomentsCommentReport", { status = "clicked" })
            end
            openMomentCommentReport({ commentId = commentId, channelId = channelId, reportedUserId = reportedUserId })
        end
    end, { openMomentCommentReport, channelId, var29 })
    local openBlockUser = var33.openBlockUser
    local onBlockCommentAuthor = React.useMemo(function(): ((string, string) -> ())?
        return if openBlockUser == nil then nil else function(str2: string, userId: string)
            openBlockUser({
                userId = userId,
                onBlockConfirmed = function()
                    if FFlagMomentsCommentActionsRealtime and var29 ~= nil then
                        var29.logRealtimeEvent("MomentsCommentAuthorBlock", { status = "attempted" })
                    end
                    commentsListCoordinator.hideCommentsByAuthor(tbl2.feedItemId, userId)
                end,
                onBlockFailed = function()
                    if FFlagMomentsCommentActionsRealtime and var29 ~= nil then
                        var29.logRealtimeEvent("MomentsCommentAuthorBlock", { status = "failed" })
                    end
                    commentsListCoordinator.restoreCommentsByAuthor(tbl2.feedItemId, userId)
                end,
                onBlockSucceeded = FFlagMomentsCommentActionsRealtime and var29 ~= nil and function()
                    var29.logRealtimeEvent("MomentsCommentAuthorBlock", { status = "succeeded" })
                end or nil,
                openReportUser = onReportComment ~= nil and function()
                    onReportComment(str2, userId)
                end or nil
            })
        end
    end, {
        openBlockUser,
        onReportComment,
        commentsListCoordinator,
        tbl2.feedItemId,
        var29
    })

    local onDeleteComment = React.useCallback(function(commentId: string)
        local var36 = if FFlagMomentsComments then var29 ~= nil and function()
            var29.logEvent(EventNames.MomentCommentDeleted, { commentId = commentId })
        end or nil else nil

        return commentsListCoordinator.deleteComment(tbl2.feedItemId, commentId, function() -- name: onDeleteFailed
            showDeleteFailedToast(deleteFailed)
        end, var36)
    end, {
        commentsListCoordinator,
        tbl2.feedItemId,
        var29,
        deleteFailed
    })
    local var37 = React.useRef(nil)
    local var38

    if FFlagMomentsCommentsScrollToPostedComment then
        local var39 = React.useRef(nil)

        local pendingSubmission = var2.pendingSubmission
        local clientRequestId = if pendingSubmission == nil then nil else pendingSubmission.clientRequestId
        local var40 = React.useRef(clientRequestId)
        React.useEffect(function()
            if clientRequestId == nil or clientRequestId == var40.current then
                return
            end
            var40.current = clientRequestId
            local current = var39.current
            if current ~= nil then
                current.scrollToOffset(0)
            end
        end, { clientRequestId })

        var38 = var39
    else
        var38 = nil
    end

    local shift300 = var13.Color.Shift.Shift_300
    local creatorEnabled = not (var9 == nil) and var9.creatorEnabled
    local viewerCanWrite = not (var9 == nil) and var9.viewerCanWrite

    local row = React.useMemo(function()
        return {
            viewerUsername = viewerUsername,
            feedItemId = tbl2.feedItemId,
            thumbsUpEmoteId = var12,
            creatorEnabled = creatorEnabled,
            viewerCanWrite = viewerCanWrite,
            avatarBackgroundStyle = shift300,
            scrollingFrameRef = var37,
            onToggleReaction = onToggleReaction,
            onAddReaction = onAddReaction,
            onReportComment = onReportComment,
            onBlockCommentAuthor = onBlockCommentAuthor,
            onDeleteComment = onDeleteComment,
            onToggleCommentExpanded = var3.toggle,
            onToggleCommentTranslation = onToggleCommentTranslation,
            onRetryPendingSubmission = onRetryPendingSubmission,
            onEditPendingSubmission = onEditPendingSubmission,
            onRetryLoadMore = onRetryLoadMore
        }
    end, {
        viewerUsername,
        tbl2.feedItemId,
        var12,
        creatorEnabled,
        viewerCanWrite,
        shift300,
        onToggleReaction,
        onAddReaction,
        onReportComment,
        onBlockCommentAuthor,
        onDeleteComment,
        var3,
        onToggleCommentTranslation or false,
        onRetryPendingSubmission,
        onEditPendingSubmission,
        onRetryLoadMore
    })

    local var40

    if FFlagMomentsCommentsAttachSheetScroller then
        var40 = nil
    else
        local commentsSheetStore = getCommentsSheetStore(false)
        var40 = SignalsReact.useSignalBinding(commentsSheetStore.getIsListScrollingEnabled)
    end

    local tbl3 = {
        data = var16,
        layout = layout,
        rowBleed = small,
        row = row,
        scrollingFrame = if FFlagMomentsCommentsAttachSheetScroller then tbl2.scrollingFrame else nil,
        listScrollingFrameRef = var37,
        listRef = var38,
        isScrollingEnabled = var40,
        onEndReached = 0,
        onViewportChanged = 0,
        onContentLengthChanged = 0,
        onVisibleRangeChanged = 0,
        onVisibleItemsPresented = 0
    }

    if not var2.hasMore then
        var20 = nil
    end

    tbl3.onEndReached = var20
    tbl3.onViewportChanged = onViewportChanged
    tbl3.onContentLengthChanged = onContentLengthChanged
    tbl3.onVisibleRangeChanged = if var17 == nil then nil else var17.onVisibleRangeChanged
    tbl3.onVisibleItemsPresented = var18
    return tbl3
end

return useCommentsListViewModel

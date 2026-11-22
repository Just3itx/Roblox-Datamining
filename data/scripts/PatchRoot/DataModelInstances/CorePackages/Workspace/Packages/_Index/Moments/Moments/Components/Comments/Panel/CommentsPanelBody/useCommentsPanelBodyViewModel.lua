-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _MomentsTypes = require(MomentsParent.MomentsTypes)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)

local FFlagMomentsCommentsRevealAfterMeasure = require(Moments.Flags.FFlagMomentsCommentsRevealAfterMeasure)
local FFlagMomentsCommentsAttachSheetScroller = require(Moments.Flags.FFlagMomentsCommentsAttachSheetScroller)
local GetCommentCollectionStore = require(Moments.Components.Comments.GetCommentCollectionStore)
local getCommentsListCoordinator = require(Moments.Components.Comments.List.getCommentsListCoordinator)
local _getCommentsPanelState = require(script.Parent.Parent.getCommentsPanelState)
local _CommentsPanelBodyView = require(script.Parent.CommentsPanelBodyView)
local useVisibleContentHeight = require(script.Parent.useVisibleContentHeight)

local function useCommentsPanelBodyViewModel(tbl1)
    local feedItemId = tbl1.feedItemId
    local var1 = React.useMemo(function(): {feedItemId: any, sessionId: any}?
        return if tbl1.isOpen and feedItemId ~= nil and feedItemId ~= "" then {
            feedItemId = feedItemId,
            sessionId = tbl1.sessionId
        } else nil
    end, { tbl1.isOpen, tbl1.sessionId, feedItemId })
    local var2, var3 = React.useState(nil)
    local commentCollectionStore = GetCommentCollectionStore(false)
    local var4 = feedItemId or ""
    local var5 = React.useMemo(function()
        return commentCollectionStore.getState(var4)
    end, { commentCollectionStore, var4 })
    local var6 = SignalsReact.useSignalState(var5)
    local commentsListCoordinator = getCommentsListCoordinator(false)

    React.useEffect(function()
        if var1 ~= nil then
            local var7 = commentsListCoordinator.acquireSession(var1.feedItemId, var1.sessionId)
            var3(var1)
            return var7
        end
    end, { commentsListCoordinator, var1 })

    local comments = tbl1.comments
    local var7 = comments == nil or comments.viewerCanRead
    local pendingSubmission = var6.pendingSubmission
    local var8 = if pendingSubmission == nil then "" else pendingSubmission.clientRequestId
    local var9 = if pendingSubmission == nil then "" else pendingSubmission.status
    React.useEffect(function()
        if var1 ~= nil and var2 == var1 and var7 then
            commentsListCoordinator.ensureInitialLoad(var1.feedItemId, var1.sessionId)
        end
    end, {
        var2,
        commentsListCoordinator,
        var1,
        var7,
        var6.initialLoadStatus,
        var6.loadMoreStatus,
        var8,
        var9
    })

    local panelState = tbl1.panelState
    React.useEffect(function()
        if var1 ~= nil and var2 == var1 and panelState.shouldClose then
            tbl1.onClose()
        end
    end, {
        var2,
        tbl1.onClose,
        panelState.shouldClose,
        var1
    })

    local onRetryInitial = React.useCallback(function()
        if feedItemId ~= nil and feedItemId ~= "" then
            commentsListCoordinator.retryInitial(feedItemId, tbl1.sessionId)
        end
    end, { commentsListCoordinator, tbl1.sessionId, feedItemId })

    local stateMinHeight = useVisibleContentHeight(tbl1.scrollingFrameRef, tbl1.actionsFrame)

    local bool1 = true

    local var12 = nil
    local var13

    if FFlagMomentsCommentsRevealAfterMeasure then
        local str1 = `{feedItemId or ""}:{tbl1.sessionId}`
        local var14, var15 = React.useState(nil)
        bool1 = var14 == str1
        local var16 = nil
        if FFlagMomentsCommentsAttachSheetScroller then
            local var17
            var12, var17 = React.useBinding(true)
            var16 = var17
            React.useLayoutEffect(function()
                if not bool1 then
                    var16(true)
                end
            end, { bool1 })
        end
        var13 = React.useCallback(function()
            if var16 ~= nil then
                var16(false)
            end
            var15(str1)
        end, { str1 })

        local bool2 = panelState.contentState == "list" and feedItemId ~= nil

        React.useEffect(function()
            if not bool2 then
                var15(nil)
            end
        end, { bool2 })
    else
        var13 = nil
    end

    return {
        contentState = panelState.contentState,
        isReadOnly = panelState.isReadOnly,
        canRetryInitial = panelState.canRetryInitial,
        feedItemId = feedItemId,
        sessionId = tbl1.sessionId,
        stateMinHeight = stateMinHeight,
        onRetryInitial = onRetryInitial,
        isListRevealed = bool1,
        onListRevealed = var13,
        scrollingFrame = if FFlagMomentsCommentsAttachSheetScroller then tbl1.scrollingFrame else nil,
        revealPlaceholdersVisible = var12
    }
end

return useCommentsPanelBodyViewModel

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local LocalizationService = game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")

local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)
local MomentsGetMomentsCommentsStore = require(MomentsParent.DataHydration.MomentsGetMomentsCommentsStore)

local _CommentsComposerContainer = require(Moments.Components.Comments.Composer.CommentsComposerContainer)

local _CommentsPanelBodyContainer = require(Moments.Components.Comments.Panel.CommentsPanelBody.CommentsPanelBodyContainer)
local GetCommentCollectionStore = require(Moments.Components.Comments.GetCommentCollectionStore)
local getCommentsPanelState = require(Moments.Components.Comments.Panel.getCommentsPanelState)
local _SheetShim = require(Moments.Components.SheetShim)
local useCommentCapabilities = require(Moments.Components.Comments.useCommentCapabilities)
local FFlagMomentsCommentsAttachSheetScroller = require(Moments.Flags.FFlagMomentsCommentsAttachSheetScroller)
local _CommentsSheetView = require(script.Parent.CommentsSheetView)
local getCommentsSheetStore = require(script.Parent.getCommentsSheetStore)
local getCommentsVideoLift = require(script.Parent.getCommentsVideoLift)
local useSheetContentScrollingFrame = require(script.Parent.useSheetContentScrollingFrame)

local useLocalization = Localization.Hooks.useLocalization

local function useCommentsSheetViewModel()
    local commentsSheetStore = getCommentsSheetStore(false)
    local isOpen = SignalsReact.useSignalState(commentsSheetStore.getIsOpen)
    local feedItemId = SignalsReact.useSignalState(commentsSheetStore.getFeedItemId)
    local sessionId = SignalsReact.useSignalState(commentsSheetStore.getOpenSessionId)
    local var4 = MomentsGetMomentsCommentsStore(false)
    local var5 = React.useMemo(function()
        return var4.getCachedMomentComments(feedItemId or "")
    end, { var4, feedItemId })
    local comments = SignalsReact.useSignalState(var5.data)
    local var7 = useCommentCapabilities()

    local close = commentsSheetStore.close
    React.useEffect(function()
        if isOpen and not var7.canRead then
            close()
        end
    end, { isOpen, var7.canRead, close })
    local scrollingFrameRef = React.useRef(nil)
    local actionsFrame, actionsRef = React.useState(nil)
    local commentCollectionStore = GetCommentCollectionStore(false)
    local var11 = feedItemId or ""
    local var12 = React.useMemo(function()
        return commentCollectionStore.getState(var11)
    end, { commentCollectionStore, var11 })
    local var13 = SignalsReact.useSignalState(var12)
    local num1 = if var13.pendingSubmission == nil then 0 else 1
    local count = if var13.initialLoadStatus == "Success" and not var13.hasMore then math.max(0, #var13.orderedCommentIds - num1) else nil

    if comments ~= nil and comments.count ~= nil then
        count = comments.count
    end

    local var1 = if count == nil then nil else Localization.abbreviateCount(count, LocalizationService.RobloxLocaleId)
    local panelState = getCommentsPanelState(comments, var13)
    local isListDisplayed = panelState.contentState == "list" and feedItemId ~= nil
    local var15, var16

    if FFlagMomentsCommentsAttachSheetScroller then
        var15, var16 = useSheetContentScrollingFrame(isListDisplayed)
    else
        var16 = nil
        var15 = nil
    end

    local var2 = if count == nil or not (count > 0) or var1 == nil then "Feature.Moments.Title.Comments" else {
        if comments == nil then "Feature.Moments.Title.CommentsWithCount" elseif comments.countIsCapped then "Feature.Moments.Title.CommentsWithCappedCount" else "Feature.Moments.Title.CommentsWithCount",
        count = var1
    }

    local title = useLocalization({ title = var2 }).title
    local canCompose = isOpen and not (feedItemId == nil or feedItemId == "") and var7.canRead and var7.canWrite and panelState.canCompose
    local setSnapPointIndex = commentsSheetStore.setSnapPointIndex
    local onSnapPointChanged = React.useCallback(function(_: number, num2: number)
        setSnapPointIndex(num2)
    end, { setSnapPointIndex })

    local var19 = Foundation.Hooks.useOverlay()
    local getVideoLift = commentsSheetStore.getVideoLift
    local setVideoLift = commentsSheetStore.setVideoLift
    local onContentInsetChanged = React.useCallback(function(arg1)
        if var19 == nil then
            setVideoLift(nil)
            return
        end
        setVideoLift(
            getCommentsVideoLift({
                sheetInset = arg1.bottom,
                overlayTop = var19.AbsolutePosition.Y,
                overlayHeight = var19.AbsoluteSize.Y,
                isKeyboardVisible = UserInputService.OnScreenKeyboardVisible
            }, getVideoLift(false))
        )
    end, { var19, getVideoLift, setVideoLift })

    React.useEffect(function()
        return function()
            setVideoLift(nil)
        end
    end, { setVideoLift })

    return {
        isOpen = isOpen,
        title = title,
        onClose = commentsSheetStore.close,
        onSnapPointChanged = onSnapPointChanged,
        onContentInsetChanged = onContentInsetChanged,
        isListDisplayed = isListDisplayed,
        scrollingFrameRef = scrollingFrameRef,
        onScrollingFrameChanged = var16,
        actionsRef = actionsRef,
        panelBodyProps = {
            isOpen = isOpen,
            feedItemId = feedItemId,
            comments = comments,
            panelState = panelState,
            sessionId = sessionId,
            scrollingFrameRef = scrollingFrameRef,
            scrollingFrame = var15,
            actionsFrame = actionsFrame,
            onClose = commentsSheetStore.close
        },
        composerProps = canCompose and { feedItemId = feedItemId, sessionId = sessionId } or nil
    }
end

return useCommentsSheetViewModel

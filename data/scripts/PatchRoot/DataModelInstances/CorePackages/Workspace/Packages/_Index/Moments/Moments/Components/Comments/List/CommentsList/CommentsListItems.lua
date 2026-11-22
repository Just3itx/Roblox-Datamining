-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local SignalsReact = require(MomentsParent.SignalsReact)
local ViewRecycler = require(MomentsParent.ViewRecycler)

local CommentsListFooterView = require(script.Parent.Parent.CommentsListFooterView)
local CommentsListRowContext = require(script.Parent.CommentsListRowContext)
local CommentRowContainer = require(script.Parent.Parent.Rows.CommentRow.CommentRowContainer)
local _CommentRowTypes = require(script.Parent.Parent.Rows.CommentRowTypes)
local CommentsReadOnlyNoticeView = require(Moments.Components.Comments.Panel.CommentsReadOnlyNoticeView)
local PendingCommentRowView = require(script.Parent.Parent.Rows.PendingCommentRowView)
local _CommentCollectionTypes = require(Moments.Components.Comments.GetCommentCollectionStore.CommentCollectionTypes)
local FFlagMomentsCommentsAttachSheetScroller = require(Moments.Flags.FFlagMomentsCommentsAttachSheetScroller)

local useCommentsListRow = CommentsListRowContext.useCommentsListRow

local tag = if FFlagMomentsCommentsAttachSheetScroller then "size-full-0 auto-y padding-x-medium" else "size-full-0 auto-y padding-x-small"

local str1 = if FFlagMomentsCommentsAttachSheetScroller then "size-full-0 auto-y padding-x-xlarge" else "size-full-0 auto-y padding-x-large"

local tbl1 = {
    readiness = ViewRecycler.RecyclableViewReadiness.ReadyOnCommit
}

local var1 = table.freeze({
    comment = ViewRecycler.createRecyclableView(function(arg1) -- name: CommentItemView
        local var1 = SignalsReact.useSignalState(arg1.itemSignal)
        local var2 = useCommentsListRow()
        if var1.type ~= "comment" then
            return nil
        end
        return React.createElement(Foundation.View, { tag = tag }, {
            Row = React.createElement(CommentRowContainer, {
                feedItemId = var2.feedItemId,
                commentId = var1.commentId,
                text = var1.text,
                createdAt = var1.createdAt,
                viewerUsername = var2.viewerUsername,
                thumbsUpEmoteId = var2.thumbsUpEmoteId,
                creatorEnabled = var2.creatorEnabled,
                viewerCanWrite = var2.viewerCanWrite,
                scrollingFrameRef = var2.scrollingFrameRef,
                avatarBackgroundStyle = var2.avatarBackgroundStyle,
                onToggleReaction = var2.onToggleReaction,
                onAddReaction = var2.onAddReaction,
                onReportComment = var2.onReportComment,
                onBlockCommentAuthor = var2.onBlockCommentAuthor,
                onDeleteComment = var2.onDeleteComment,
                isExpanded = var1.isExpanded,
                onToggleExpanded = var2.onToggleCommentExpanded,
                translationState = var1.translationState,
                onToggleTranslation = var2.onToggleCommentTranslation
            })
        })
    end, tbl1),
    pending = ViewRecycler.createRecyclableView(function(arg1) -- name: PendingItemView
        local var1 = SignalsReact.useSignalState(arg1.itemSignal)
        local var2 = useCommentsListRow()
        if var1.type ~= "pending" then
            return nil
        end
        local bool1 = var1.status == "OutcomeUnknown"
        local createElement = React.createElement
        local view = Foundation.View
        local tbl2 = { tag = tag }
        local tbl3 = {
            Row = React.createElement(PendingCommentRowView, {
                rowKey = var1.key,
                text = var1.text,
                viewerUsername = var2.viewerUsername,
                avatarBackgroundStyle = var2.avatarBackgroundStyle,
                status = var1.status,
                onRetry = if bool1 then var2.onRetryPendingSubmission else nil,
                onEdit = if bool1 then var2.onEditPendingSubmission else nil
            })
        }
        return createElement(view, tbl2, tbl3)
    end, tbl1),
    loadMore = ViewRecycler.createRecyclableView(function(arg1) -- name: LoadMoreItemView
        local var1 = SignalsReact.useSignalState(arg1.itemSignal)
        local var2 = useCommentsListRow()
        if var1.type ~= "loadMore" then
            return nil
        end
        return React.createElement(
            Foundation.View,
            { tag = str1 },
            {
                Footer = React.createElement(CommentsListFooterView, { status = var1.status, onRetry = var2.onRetryLoadMore })
            }
        )
    end),
    readOnlyNotice = ViewRecycler.createRecyclableView(function(_) -- name: ReadOnlyNoticeItemView
        return React.createElement(Foundation.View, { tag = str1 }, { Notice = React.createElement(CommentsReadOnlyNoticeView) })
    end)
})

local tbl2 = ({})
local readOnlyNotice = { type = "readOnlyNotice", key = "footer:read-only-notice" }

table.freeze(readOnlyNotice)

return table.freeze({
    getItemType = function(arg1, _: number)
        local var2 = var1[arg1.type]
        local type = arg1.type
        assert(var2 ~= nil, `CommentsListItems: unknown item type "{tostring(type)}"`)
        return var2
    end,
    getItemKey = function(arg1, _: number)
        return arg1.key
    end,
    loadMore = function(status)
        local var2 = tbl2[status]
        if var2 ~= nil then
            return var2
        end

        local tbl4 = { type = "loadMore", key = "footer:load-more", status = status }

        table.freeze(tbl4)
        tbl2[status] = tbl4
        return tbl4
    end,
    readOnlyNotice = function()
        return readOnlyNotice
    end
})

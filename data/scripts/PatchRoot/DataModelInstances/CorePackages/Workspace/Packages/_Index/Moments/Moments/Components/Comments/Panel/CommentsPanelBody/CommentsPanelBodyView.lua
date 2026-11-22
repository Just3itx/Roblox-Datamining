-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)

local FFlagMomentsCommentsRevealAfterMeasure = require(Moments.Flags.FFlagMomentsCommentsRevealAfterMeasure)
local FFlagMomentsCommentsAttachSheetScroller = require(Moments.Flags.FFlagMomentsCommentsAttachSheetScroller)

local CommentsListContainer = require(Moments.Components.Comments.List.CommentsList.CommentsListContainer)
local CommentsPanelStateView = require(script.Parent.Parent.CommentsPanelStateView)
local CommentsReadOnlyNoticeView = require(script.Parent.Parent.CommentsReadOnlyNoticeView)
local _getCommentsPanelState = require(script.Parent.Parent.getCommentsPanelState)
local ScrollingFrameCover = require(script.Parent.ScrollingFrameCover)

local function CommentsPanelBodyView(tbl1)
    local feedItemId = tbl1.feedItemId
    local bool1 = tbl1.contentState == "list" and feedItemId ~= nil
    local bool2 = tbl1.contentState == "loading"

    local var1 = FFlagMomentsCommentsAttachSheetScroller and bool1

    local bool3 = bool1 and not var1
    local str1 = "Content"
    local element

    if bool1 then
        str1 = `List:{feedItemId}:{tbl1.sessionId}`
        if var1 and tbl1.scrollingFrame == nil then
            element = nil
        else
            element = React.createElement(CommentsListContainer, {
                feedItemId = feedItemId,
                sessionId = tbl1.sessionId,
                isReadOnly = tbl1.isReadOnly,
                scrollingFrame = if FFlagMomentsCommentsAttachSheetScroller then tbl1.scrollingFrame else nil,
                onRevealed = if FFlagMomentsCommentsRevealAfterMeasure then tbl1.onListRevealed else nil
            })
        end
    else
        element = React.createElement(CommentsPanelStateView, {
            state = if tbl1.contentState == "list" then "unavailable" else tbl1.contentState,
            isReadOnly = tbl1.isReadOnly,
            onRetry = if tbl1.canRetryInitial then tbl1.onRetryInitial else nil
        })
    end

    local element2 = nil
    if FFlagMomentsCommentsRevealAfterMeasure and var1 and not tbl1.isListRevealed then
        if tbl1.scrollingFrame ~= nil then
            element2 = React.createElement(ScrollingFrameCover, {
                scrollingFrame = tbl1.scrollingFrame,
                Visible = tbl1.revealPlaceholdersVisible,
                testId = "moments-comments-panel-reveal-placeholders"
            }, {
                Inset = React.createElement(
                    Foundation.View,
                    { tag = "size-full padding-x-xlarge" },
                    {
                        Placeholders = React.createElement(CommentsPanelStateView, { state = "loading" })
                    }
                )
            })
        end
    elseif FFlagMomentsCommentsRevealAfterMeasure and bool1 and not tbl1.isListRevealed then
        element2 = React.createElement(
            Foundation.View,
            {
                ZIndex = 2,
                tag = "size-full bg-surface-100",
                testId = "moments-comments-panel-reveal-placeholders"
            },
            {
                Placeholders = React.createElement(CommentsPanelStateView, { state = "loading" })
            }
        )
    end

    return React.createElement(Foundation.View, {
        tag = {
            ["col size-full"] = bool3,
            ["col size-full-0 auto-y"] = not bool3
        },
        sizeConstraint = not bool1 and {
            MinSize = tbl1.stateMinHeight:map(function(y: number): Vector2
                return Vector2.new(0, y)
            end),
            MaxSize = nil
        } or nil,
        testId = "moments-comments-panel-body"
    }, {
        Content = React.createElement(Foundation.View, {
            LayoutOrder = 1,
            tag = {
                ["size-full"] = bool3,
                ["size-full-0"] = not bool3,
                ["auto-y"] = not (bool3 or bool2),
                fill = not bool1
            },
            testId = "moments-comments-panel-content"
        }, {
            [str1] = element,
            RevealPlaceholders = element2
        }),
        ReadOnly = if tbl1.isReadOnly and not bool1 then React.createElement(
            Foundation.View,
            {
                LayoutOrder = 2,
                tag = "size-full-0 auto-y",
                testId = "moments-comments-panel-read-only"
            },
            {
                Notice = React.createElement(CommentsReadOnlyNoticeView)
            }
        ) else nil
    })
end

return CommentsPanelBodyView

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ViewRecycler = require(MomentsParent.ViewRecycler)

local CommentsListItems = require(script.Parent.CommentsListItems)
local CommentsListRowContext = require(script.Parent.CommentsListRowContext)
local _CommentRowTypes = require(script.Parent.Parent.Rows.CommentRowTypes)
local FFlagMomentsCommentsAttachSheetScroller = require(Moments.Flags.FFlagMomentsCommentsAttachSheetScroller)

local function AttachedCommentsListView(tbl1)
    return React.createElement(CommentsListRowContext.CommentsListRowContext.Provider, {
        value = tbl1.row
    }, {
        List = React.createElement(ViewRecycler.VirtualList, {
            scrollingFrame = tbl1.scrollingFrame,
            data = tbl1.data,
            layout = tbl1.layout,
            axis = ViewRecycler.Axis.Y,
            itemType = CommentsListItems.getItemType,
            overscan = 2,
            endReachedThreshold = 240,
            onEndReached = tbl1.onEndReached,
            onViewportChanged = tbl1.onViewportChanged,
            onContentLengthChanged = tbl1.onContentLengthChanged,
            onVisibleItemsPresented = tbl1.onVisibleItemsPresented,
            autoScrollOnChange = ViewRecycler.AutoScrollPolicy.WhenAtStart,
            autoScrollThreshold = 33,
            scrollingFrameRef = tbl1.listScrollingFrameRef,
            listRef = tbl1.listRef
        })
    })
end

local function CommentsListView(tbl1)
    if FFlagMomentsCommentsAttachSheetScroller then
        return React.createElement(AttachedCommentsListView, tbl1)
    end

    local uDim = UDim.new(0, tbl1.rowBleed * -2)
    return React.createElement(
        Foundation.View,
        {
            Size = UDim2.fromScale(1, 1),
            padding = { left = uDim, right = uDim },
            testId = "moments-comments-list"
        },
        {
            Rows = React.createElement(CommentsListRowContext.CommentsListRowContext.Provider, {
                value = tbl1.row
            }, {
                List = React.createElement(ViewRecycler.VirtualList, {
                    data = tbl1.data,
                    layout = tbl1.layout,
                    axis = ViewRecycler.Axis.Y,
                    itemType = CommentsListItems.getItemType,
                    overscan = 2,
                    endReachedThreshold = 240,
                    onEndReached = tbl1.onEndReached,
                    onViewportChanged = tbl1.onViewportChanged,
                    onContentLengthChanged = tbl1.onContentLengthChanged,
                    onVisibleRangeChanged = tbl1.onVisibleRangeChanged,
                    autoScrollOnChange = ViewRecycler.AutoScrollPolicy.WhenAtStart,
                    autoScrollThreshold = 33,
                    scrollingFrameRef = tbl1.listScrollingFrameRef,
                    listRef = tbl1.listRef,
                    scrollingFrameProps = {
                        Name = "MomentsCommentsListScrollingFrame",
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        ScrollBarThickness = 0,
                        Selectable = false,
                        ScrollingEnabled = tbl1.isScrollingEnabled
                    }
                })
            })
        }
    )
end
return CommentsListView

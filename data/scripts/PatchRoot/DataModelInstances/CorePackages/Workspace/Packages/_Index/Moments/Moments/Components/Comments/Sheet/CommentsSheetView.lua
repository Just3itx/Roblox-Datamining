-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local FocusNavigationUtils = require(MomentsParent.FocusNavigationUtils)
local Foundation = require(MomentsParent.Foundation)
local React = require(MomentsParent.React)
local ReactUtils = require(MomentsParent.ReactUtils)

local DialogSize = Foundation.Enums.DialogSize
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local Sheet = Foundation.Sheet
local FoundationText = Foundation.Text
local View = Foundation.View
local useComposedRef = ReactUtils.useComposedRef
local useFocusRoot = FocusNavigationUtils.useFocusRoot

local CommentsComposerContainer = require(Moments.Components.Comments.Composer.CommentsComposerContainer)

local CommentsPanelBodyContainer = require(Moments.Components.Comments.Panel.CommentsPanelBody.CommentsPanelBodyContainer)
local SheetShim = require(Moments.Components.SheetShim)
local CommentsSheetSnapPoints = require(script.Parent.CommentsSheetSnapPoints)
local FFlagMomentsCommentsSheetFocusNavigation = require(Moments.Flags.FFlagMomentsCommentsSheetFocusNavigation)
local FFlagMomentsCommentsAttachSheetScroller = require(Moments.Flags.FFlagMomentsCommentsAttachSheetScroller)

local function sizeContentForList(arg1)
    if arg1 ~= nil then
        arg1.AutomaticSize = Enum.AutomaticSize.None
    end
end

local function sizeContentToFit(arg1)
    if arg1 ~= nil then
        arg1.AutomaticSize = Enum.AutomaticSize.Y
    end
end

local function useTopSnapPointReporter(callback: (...any) -> (...any))
    local var1 = React.useRef(nil)
    return React.useCallback(function(arg1)
        if var1.current ~= nil then
            var1.current:Disconnect()
            var1.current = nil
        end
        if arg1 == nil then
            return
        end

        var1.current = arg1:GetPropertyChangedSignal("ScrollingEnabled"):Connect(function()
            if arg1.ScrollingEnabled then
                local commentsSheetSnapPointsLen = #CommentsSheetSnapPoints
                callback(CommentsSheetSnapPoints[commentsSheetSnapPointsLen], commentsSheetSnapPointsLen)
            end
        end)
    end, { callback })
end

local function CommentsSheetView(tbl1)
    local var1 = useTopSnapPointReporter(tbl1.onSnapPointChanged)

    local var2 = useComposedRef(tbl1.scrollingFrameRef, var1)
    local scrollingFrameRef = useComposedRef(
        var2,
        if FFlagMomentsCommentsAttachSheetScroller then tbl1.onScrollingFrameChanged elseif tbl1.isListDisplayed then sizeContentForList else sizeContentToFit
    )
    local ref = if FFlagMomentsCommentsSheetFocusNavigation then useFocusRoot({ surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp, isFocusable = tbl1.isOpen }) else nil
    local createElement = React.createElement
    local root = SheetShim.Root
    local tbl2 = {
        isOpen = tbl1.isOpen,
        onClose = tbl1.onClose,
        onSnapPointChanged = tbl1.onSnapPointChanged,
        onContentInsetChanged = tbl1.onContentInsetChanged,
        hideBackdrop = true,
        size = DialogSize.Medium,
        snapPoints = CommentsSheetSnapPoints,
        testId = "moments-comments-sheet",
        ref = ref
    }
    local tbl3 = {
        Header = React.createElement(Sheet.Header, { hasCloseAffordance = true }, {
            Title = React.createElement(FoundationText, { Text = tbl1.title, tag = "auto-xy text-heading-small content-emphasis" })
        }),
        Content = React.createElement(Sheet.Content, {
            scrollingFrameRef = scrollingFrameRef,
            isContentFullBleed = if FFlagMomentsCommentsAttachSheetScroller then tbl1.isListDisplayed else nil
        }, {
            ContentSlot = React.createElement(
                View,
                {
                    tag = {
                        ["size-full"] = not FFlagMomentsCommentsAttachSheetScroller and tbl1.isListDisplayed,
                        ["size-full-0 auto-y"] = FFlagMomentsCommentsAttachSheetScroller or not tbl1.isListDisplayed
                    },
                    testId = "moments-comments-content-slot"
                },
                {
                    PanelBody = React.createElement(CommentsPanelBodyContainer, tbl1.panelBodyProps)
                }
            )
        }),
        Actions = 0
    }

    local createElement2 = React.createElement
    local actions = Sheet.Actions
    local tbl4 = {
        ref = tbl1.actionsRef
    }
    local tbl5 = {
        ComposerSlot = React.createElement(View, {
            tag = "size-full-0 auto-y",
            testId = "moments-comments-composer-slot"
        }, {
            Composer = if tbl1.composerProps == nil then nil else React.createElement(CommentsComposerContainer, tbl1.composerProps)
        })
    }
    tbl3.Actions = createElement2(actions, tbl4, tbl5)
    return createElement(root, tbl2, tbl3)
end

return CommentsSheetView

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:50:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local BuilderIcons = require(MomentsParent.BuilderIcons)
local FocusNavigationUtils = require(MomentsParent.FocusNavigationUtils)
local Foundation = require(MomentsParent.Foundation)
local InputHandlers = require(MomentsParent.InputHandlers)
local React = require(MomentsParent.React)
local _ReactFocusNavigation = require(MomentsParent.ReactFocusNavigation)

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local InputSize = Foundation.Enums.InputSize
local PopoverAlign = Foundation.Enums.PopoverAlign
local PopoverSide = Foundation.Enums.PopoverSide
local ThreeDotsHorizontal = BuilderIcons.Icon.ThreeDotsHorizontal

local eventMap = {
    [Enum.KeyCode.ButtonB] = FocusNavigationEventNameEnum.NavigateBack,
    [Enum.KeyCode.Escape] = FocusNavigationEventNameEnum.NavigateBack
}

local function CommentActionsMenu(arg1)
    local onClose = arg1.onClose
    local eventHandlers = React.useMemo(function()
        return {
            [FocusNavigationEventNameEnum.NavigateBack] = {
                handler = InputHandlers.onRelease(function(arg2)
                    onClose()
                    arg2:cancel()
                end)
            }
        }
    end, { onClose })

    local ref = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
        isFocusable = arg1.isOpen,
        isAutoFocusRoot = true,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })

    return React.createElement(
        Foundation.Menu,
        {
            isOpen = arg1.isOpen,
            items = arg1.items,
            side = if arg1.anchorRef ~= nil then PopoverSide.Top else PopoverSide.Bottom,
            align = PopoverAlign.End,
            anchorRef = arg1.anchorRef,
            onPressedOutside = onClose,
            ref = ref,
            LayoutOrder = arg1.LayoutOrder,
            testId = `moments-comment-actions-menu-{arg1.commentId}`
        },
        arg1.anchorRef == nil
            and {
                Button = React.createElement(Foundation.IconButton, {
                    icon = ThreeDotsHorizontal,
                    isCircular = true,
                    size = InputSize.XSmall,
                    onActivated = arg1.onButtonActivated,
                    testId = `moments-comment-actions-button-{arg1.commentId}`
                })
            }
            or nil
    )
end

return CommentActionsMenu

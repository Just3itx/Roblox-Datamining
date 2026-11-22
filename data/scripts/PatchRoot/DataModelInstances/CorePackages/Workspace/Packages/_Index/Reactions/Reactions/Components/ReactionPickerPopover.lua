-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T13:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Reactions = script:FindFirstAncestor("Reactions")
local ReactionsParent = Reactions.Parent

local FocusNavigationUtils = require(ReactionsParent.FocusNavigationUtils)
local Foundation = require(ReactionsParent.Foundation)
local InputHandlers = require(ReactionsParent.InputHandlers)
local React = require(ReactionsParent.React)
local _ReactFocusNavigation = require(ReactionsParent.ReactFocusNavigation)

local ReactionPicker = require(Reactions.Components.ReactionPicker)
local _ReactionSize = require(Reactions.Enums.ReactionSize)
local _ReactionType = require(Reactions.Enums.ReactionType)
local usePressGestures = require(Reactions.Hooks.usePressGestures)
local useReactionDragSelect = require(Reactions.Hooks.useReactionDragSelect)
local toGuiSpace = require(Reactions.Utils.toGuiSpace)

local Popover = Foundation.Popover
local PopoverSide = Foundation.Enums.PopoverSide
local Radius = Foundation.Enums.Radius
local useTokens = Foundation.Hooks.useTokens
local useFocusRoot = FocusNavigationUtils.useFocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local eventMap = {
    [Enum.KeyCode.ButtonB] = "NavigateBack",
    [Enum.KeyCode.Escape] = "NavigateBack"
}

local function ReactionPickerPopover(tbl2)
    local var1 = useTokens()
    local var2 = useReactionDragSelect(tbl2.onReactionSelected)

    local onOpen = tbl2.onOpen
    local onDoubleTap = tbl2.onDoubleTap
    usePressGestures(tbl2.anchorRef, {
        onTap = tbl2.onTap or onOpen,
        onDoubleTap = onDoubleTap and function(vector2: Vector2)
            local current = tbl2.anchorRef.current
            local var3 = onDoubleTap
            if typeof(current) == "Instance" then
                vector2 = toGuiSpace(vector2, current)
            end

            var3(vector2)
        end or nil,
        onHold = onOpen and function()
            if not tbl2.isOpen then
                onOpen()
            end
        end or nil,
        onHoldMoved = var2.onDragMoved,
        onHoldEnded = var2.onDragEnded,
        holdDuration = tbl2.holdDuration
    })

    local onDismiss = tbl2.onDismiss
    local eventHandlers = React.useMemo(function()
        return {
            NavigateBack = {
                handler = InputHandlers.onRelease(function()
                    if onDismiss then
                        onDismiss()
                    end
                end)
            }
        }
    end, { onDismiss })
    local ref = useFocusRoot({
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.ContextualMenu,
        isFocusable = tbl2.isOpen,
        isAutoFocusRoot = true,
        eventMap = eventMap,
        eventHandlers = eventHandlers
    })

    return React.createElement(Popover.Root, {
        isOpen = tbl2.isOpen
    }, {
        Anchor = React.createElement(Popover.Anchor, { anchorRef = tbl2.anchorRef }),
        Content = React.createElement(Popover.Content, {
            side = tbl2.side or PopoverSide.Top,
            align = tbl2.align,
            hasArrow = false,
            radius = tbl2.radius or Radius.Circle,
            backgroundStyle = var1.Color.None,
            onPressedOutside = onDismiss,
            ref = ref
        }, {
            Picker = React.createElement(ReactionPicker, {
                onReactionSelected = tbl2.onReactionSelected,
                selectedReactions = tbl2.selectedReactions,
                reactions = tbl2.reactions,
                reactionSize = tbl2.reactionSize,
                radius = tbl2.radius,
                backgroundStyle = tbl2.backgroundStyle,
                hoveredReaction = var2.hoveredReaction,
                getButtonRef = var2.getButtonRef,
                testId = tbl2.testId
            })
        })
    })
end

return ReactionPickerPopover

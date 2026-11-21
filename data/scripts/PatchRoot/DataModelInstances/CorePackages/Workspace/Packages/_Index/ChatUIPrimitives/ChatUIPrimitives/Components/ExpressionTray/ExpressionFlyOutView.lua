-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:01:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ChatUIPrimitives = script:FindFirstAncestor("ChatUIPrimitives")
local ChatUIPrimitivesParent = ChatUIPrimitives.Parent
local Foundation = require(ChatUIPrimitivesParent.Foundation)
local React = require(ChatUIPrimitivesParent.React)
local useDismissOnEscapeOrMenu = require(ChatUIPrimitives.Hooks.useDismissOnEscapeOrMenu)

local tbl1 = {
    SelectionBehaviorUp = Enum.SelectionBehavior.Stop,
    SelectionBehaviorDown = Enum.SelectionBehavior.Stop,
    SelectionBehaviorLeft = Enum.SelectionBehavior.Stop,
    SelectionBehaviorRight = Enum.SelectionBehavior.Stop
}

return React.memo(function(tbl2) -- name: ExpressionFlyOutView
    useDismissOnEscapeOrMenu(tbl2.isOpen, tbl2.onPressedOutside)

    local uDim2 = UDim2.fromOffset(tbl2.width or 360, tbl2.height or 240)
    local contentWrapper = React.createElement(
        Foundation.View,
        {
            Size = uDim2,
            ref = tbl2.contentRef,
            selectionGroup = if tbl2.focusNavEnabled then tbl1 else nil
        },
        {
            Container = tbl2.content
        }
    )
    return React.createElement(Foundation.Popover.Root, {
        isOpen = tbl2.isOpen
    }, {
        Anchor = React.createElement(Foundation.Popover.Anchor, nil, {
            AnchorWrapper = React.createElement(Foundation.View, {
                tag = "col align-x-center align-y-bottom size-0-full auto-x",
                padding = tbl2.addTopPadding and {
                    top = UDim.new(0, 6)
                } or nil
            }, {
                Button = tbl2.anchorContent
            })
        }),
        Content = React.createElement(Foundation.Popover.Content, {
            side = {
                position = Foundation.Enums.PopoverSide.Right,
                offset = 7
            },
            align = {
                position = Foundation.Enums.PopoverAlign.Start,
                offset = 3
            },
            hasArrow = false,
            radius = Foundation.Enums.Radius.Medium,
            onPressedOutside = tbl2.onPressedOutside
        }, { ContentWrapper = contentWrapper })
    })
end)

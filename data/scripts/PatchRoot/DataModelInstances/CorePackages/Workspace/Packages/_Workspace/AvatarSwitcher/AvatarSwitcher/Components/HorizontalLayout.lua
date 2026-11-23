-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:21:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)
local DividerOrientation = Foundation.Enums.DividerOrientation

local function HorizontalLayout(tbl1)
    return (React.createElement(Foundation.View, { tag = "size-full-full" }, {
        LeftPanel = React.createElement(Foundation.View, {
            tag = "col",
            Size = UDim2.fromScale(0.67, 1)
        }, {
            Header = React.createElement(
                Foundation.View,
                { tag = "auto-y size-full-0 shrink-0 padding-bottom-small", LayoutOrder = 1 },
                {
                    HeaderSlot = tbl1.headerSlot
                }
            ),
            LeftItemContainer = React.createElement(Foundation.View, { tag = "size-full-0 fill", LayoutOrder = 2 }, { LeftItem = tbl1.leftItemSlot })
        }),
        RightPanel = React.createElement(
            Foundation.View,
            {
                tag = "position-top-right anchor-top-right",
                Size = UDim2.fromScale(0.32999999999999996, 1)
            },
            {
                RightItem = tbl1.rightItemSlot
            }
        ),
        Divider = React.createElement(
            Foundation.Divider,
            {
                Position = UDim2.fromScale(0.67, 0),
                ZIndex = 2,
                orientation = DividerOrientation.Vertical
            }
        )
    }))
end

return HorizontalLayout

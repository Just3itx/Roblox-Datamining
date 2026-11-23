-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)

local function VerticalLayout(tbl1)
    return (React.createElement(Foundation.View, { tag = "size-full-full col" }, {
        Header = React.createElement(
            Foundation.View,
            { tag = "auto-y size-full-0 shrink-0", LayoutOrder = 1 },
            {
                HeaderSlot = tbl1.headerSlot
            }
        ),
        Divider = React.createElement(Foundation.Divider, { LayoutOrder = 2, ZIndex = 2 }),
        Content = React.createElement(Foundation.View, {
            tag = "size-full-0 fill col",
            LayoutOrder = 3
        }, {
            TopItemContainer = React.createElement(Foundation.View, { Size = UDim2.fromScale(1, 0.5) }, { TopItem = tbl1.topItemSlot }),
            Divider = React.createElement(Foundation.Divider, { Position = UDim2.fromScale(0, 0.5), ZIndex = 2 }),
            BottomItemContainer = React.createElement(
                Foundation.View,
                {
                    tag = "position-bottom-left anchor-bottom-left",
                    Size = UDim2.fromScale(1, 0.5)
                },
                {
                    BottomItem = tbl1.bottomItemSlot
                }
            )
        })
    }))
end

return VerticalLayout

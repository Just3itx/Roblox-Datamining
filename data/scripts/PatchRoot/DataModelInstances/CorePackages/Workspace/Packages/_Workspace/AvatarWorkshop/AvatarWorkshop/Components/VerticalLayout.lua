-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:41:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshopParent = script:FindFirstAncestor("AvatarWorkshop").Parent

local React = require(AvatarWorkshopParent.React)
local Foundation = require(AvatarWorkshopParent.Foundation)

local function VerticalLayout(tbl1)
    return (React.createElement(Foundation.View, { tag = "col size-full-full" }, {
        Header = React.createElement(Foundation.View, { tag = "size-full-0 auto-y", LayoutOrder = 1 }, { HeaderSlot = tbl1.headerSlot }),
        Divider = React.createElement(Foundation.Divider, { LayoutOrder = 2, ZIndex = 2 }),
        Content = React.createElement(Foundation.View, {
            tag = "col fill size-full-0",
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
        }),
        Footer = if tbl1.footerSlot then React.createElement(Foundation.View, { tag = "size-full-0 auto-y", LayoutOrder = 4 }, { FooterSlot = tbl1.footerSlot }) else nil
    }))
end

return VerticalLayout

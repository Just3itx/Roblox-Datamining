-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:31:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarSwitcherParent = script:FindFirstAncestor("AvatarSwitcher").Parent

local React = require(AvatarSwitcherParent.React)
local Foundation = require(AvatarSwitcherParent.Foundation)

local function SingleItemLayout(tbl1)
    return (React.createElement(Foundation.View, { tag = "size-full-full col" }, {
        Header = React.createElement(
            Foundation.View,
            { tag = "auto-y size-full-0 shrink-0 padding-bottom-small", LayoutOrder = 1 },
            {
                HeaderSlot = tbl1.headerSlot
            }
        ),
        Content = React.createElement(Foundation.View, { tag = "size-full-0 fill", LayoutOrder = 2 }, { ContentSlot = tbl1.contentSlot })
    }))
end

return SingleItemLayout

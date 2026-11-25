-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local React = require(scriptParentParentParentParent.React)
local Foundation = require(scriptParentParentParentParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text

return React.memo(function(tbl1) -- name: LeaderboardTextCell
    return React.createElement(
        View,
        {
            Size = UDim2.fromOffset(tbl1.width, tbl1.rowHeight),
            LayoutOrder = tbl1.layoutOrder,
            tag = "clip"
        },
        {
            Text = React.createElement(
                FoundationText,
                {
                    Text = tbl1.text,
                    tag = tbl1.textTag or "size-full text-body-small text-align-x-left content-default"
                }
            )
        }
    )
end)

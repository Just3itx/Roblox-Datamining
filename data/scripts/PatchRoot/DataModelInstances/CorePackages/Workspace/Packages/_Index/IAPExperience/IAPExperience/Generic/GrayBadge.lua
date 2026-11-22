-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local React = require(scriptParentParentParent.React)

local Foundation = require(scriptParentParentParent.Foundation)
local FoundationText = Foundation.Text
local View = Foundation.View
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize

return function(tbl1)
    return React.createElement(View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "row align-x-center align-y-center gap-xsmall size-600 auto-x padding-x-small radius-circle bg-shift-300"
    }, {
        Icon = if tbl1.iconName then React.createElement(Icon, { LayoutOrder = 1, name = tbl1.iconName, size = IconSize.XSmall, tag = "content-emphasis" }) else nil,
        Text = React.createElement(
            FoundationText,
            {
                LayoutOrder = 2,
                Text = tbl1.Text,
                tag = "auto-xy text-caption-small text-align-x-center content-emphasis"
            }
        )
    })
end

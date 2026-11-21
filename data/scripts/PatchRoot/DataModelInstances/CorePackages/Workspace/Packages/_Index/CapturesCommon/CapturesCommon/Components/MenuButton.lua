-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent

local Foundation = require(scriptParentParentParent.Foundation)
local React = require(scriptParentParentParent.React)

local View = Foundation.View
local Button = Foundation.Button
local ButtonSize = Foundation.Enums.ButtonSize
local ButtonVariant = Foundation.Enums.ButtonVariant

return function(tbl1)
    return React.createElement(View, {
        AnchorPoint = tbl1.AnchorPoint,
        LayoutOrder = tbl1.LayoutOrder,
        Position = tbl1.Position,
        tag = "bg-action-subtle align-x-center align-y-center auto-xy padding-bottom-medium"
    }, {
        ShowMoreButton = React.createElement(
            Button,
            {
                onActivated = tbl1.onActivated,
                size = ButtonSize.Small,
                text = tbl1.text,
                variant = ButtonVariant.Subtle
            }
        )
    })
end

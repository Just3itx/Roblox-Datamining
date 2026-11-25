-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:00:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Songbird = script:FindFirstAncestor("Songbird")

local React = require(Songbird.Parent.React)
local Foundation = require(Songbird.Parent.Foundation)

local useTokens = Foundation.Hooks.useTokens

local function RoundIconButton(tbl1)
    local var1 = useTokens()

    return React.createElement(Foundation.View, {
        tag = "auto-xy bg-action-emphasis radius-circle padding-small",
        onActivated = tbl1.onActivated,
        aspectRatio = 1,
        LayoutOrder = tbl1.LayoutOrder
    }, {
        Icon = React.createElement(Foundation.Icon, {
            Position = tbl1.iconOffset,
            name = tbl1.icon,
            size = Foundation.Enums.IconSize.Medium,
            style = var1.Color.ActionEmphasis.Foreground
        })
    })
end

return RoundIconButton

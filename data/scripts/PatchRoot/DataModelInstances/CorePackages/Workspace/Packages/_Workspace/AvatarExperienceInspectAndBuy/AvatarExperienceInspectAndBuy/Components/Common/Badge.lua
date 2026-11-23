-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuyParent = script:FindFirstAncestor("AvatarExperienceInspectAndBuy").Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local IconSize = Foundation.Enums.IconSize

local function Badge(tbl1)
    local var1 = useTokens()

    return React.createElement(Foundation.View, {
        tag = "auto-xy row align-x-center align-y-center bg-surface-300 radius-circle padding-small gap-xsmall",
        BorderSizePixel = 0,
        LayoutOrder = tbl1.LayoutOrder,
        Text = "",
        onActivated = tbl1.onActivated
    }, {
        Icon = React.createElement(Foundation.Icon, {
            name = tbl1.icon,
            variant = tbl1.iconVariant,
            size = IconSize.Medium,
            style = var1.Color.Content.Default,
            LayoutOrder = 1
        }),
        Text = if tbl1.text then React.createElement(Foundation.Text, {
            tag = "text-caption-large content-emphasis text-align-x-left auto-xy text-truncate-none",
            Text = tbl1.text,
            textStyle = var1.Color.Content.Default,
            LayoutOrder = 2
        }) else nil
    })
end

return Badge

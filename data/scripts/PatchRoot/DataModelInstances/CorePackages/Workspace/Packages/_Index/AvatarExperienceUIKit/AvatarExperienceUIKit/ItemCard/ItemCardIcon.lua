-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent
local React = require(AvatarExperienceUIKitParent.React)
local Foundation = require(AvatarExperienceUIKitParent.Foundation)
local Icon = Foundation.Icon
local useTokens = Foundation.Hooks.useTokens
local IconSize = Foundation.Enums.IconSize

local function ItemCardIcon(tbl1)
    local var1 = useTokens()
    return React.createElement(Icon, {
        name = tbl1.icon,
        style = tbl1.iconStyle or var1.Color.Content.Emphasis,
        size = IconSize.Small,
        LayoutOrder = tbl1.LayoutOrder,
        testId = `icon-{tbl1.icon}`
    })
end

if require(AvatarExperienceUIKitParent.AvatarExperienceFlags).FFlagAXItemCardComponentsMemo then
    return (React.memo(ItemCardIcon))
end

return ItemCardIcon

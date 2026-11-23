-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:21:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local Badge = require(AvatarExperienceInspectAndBuy.Components.Common.Badge)
local Enums = Foundation.Enums

local function ControlBar(tbl1)
    return React.createElement(
        Foundation.View,
        {
            tag = "auto-xy row align-x-left align-y-center gap-small",
            LayoutOrder = tbl1.LayoutOrder
        },
        {
            FavoritesBadge = React.createElement(Badge, {
                icon = Enums.IconName.Star,
                iconVariant = tbl1.favoritesBadge.iconVariant,
                text = tbl1.favoritesBadge.text,
                onActivated = tbl1.favoritesBadge.onActivated,
                LayoutOrder = 1
            }),
            TryOnBadge = if tbl1.tryOnBadge then React.createElement(Badge, {
                icon = Enums.IconName.MirrorStanding,
                iconVariant = tbl1.tryOnBadge.iconVariant,
                text = tbl1.tryOnBadge.text,
                onActivated = tbl1.tryOnBadge.onActivated,
                LayoutOrder = 2
            }) else nil
        }
    )
end

return ControlBar

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceInspectAndBuy = script:FindFirstAncestor("AvatarExperienceInspectAndBuy")
local AvatarExperienceInspectAndBuyParent = AvatarExperienceInspectAndBuy.Parent
local React = require(AvatarExperienceInspectAndBuyParent.React)
local Foundation = require(AvatarExperienceInspectAndBuyParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local Enums = Foundation.Enums
local IconSize = Enums.IconSize
local _Types = require(AvatarExperienceInspectAndBuy.Types)

local function ResellableInstancesLabel(tbl1)
    local var1 = useTokens()
    return React.createElement(Foundation.View, {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "auto-xy size-full-0"
    }, {
        UIPadding = if tbl1.padding then React.createElement("UIPadding", {
            PaddingLeft = tbl1.padding.left,
            PaddingRight = tbl1.padding.right,
            PaddingTop = tbl1.padding.top,
            PaddingBottom = tbl1.padding.bottom
        }) else nil,
        Inner = React.createElement(Foundation.View, {
            tag = "auto-y padding-medium size-full-0 row align-x-left align-y-center gap-small radius-medium",
            backgroundStyle = var1.Color.Surface.Surface_300
        }, {
            Icon = React.createElement(Foundation.Icon, {
                name = Enums.IconName.ShoppingBasketCheck,
                variant = Enums.IconVariant.Filled,
                size = IconSize.Medium,
                LayoutOrder = 1
            }),
            Text = React.createElement(
                Foundation.Text,
                {
                    LayoutOrder = 2,
                    tag = "auto-xy text-body-medium content-emphasis text-truncate-end",
                    Text = tbl1.ownedItemsLabel
                }
            )
        })
    })
end
return ResellableInstancesLabel

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GiftingParent = script:FindFirstAncestor("Gifting").Parent

local React = require(GiftingParent.React)
local Foundation = require(GiftingParent.Foundation)

local Icon = Foundation.Icon
local FoundationText = Foundation.Text
local View = Foundation.View
local IconName = Foundation.Enums.IconName
local IconSize = Foundation.Enums.IconSize
local IconVariant = Foundation.Enums.IconVariant
local useTokens = Foundation.Hooks.useTokens

return React.memo(function(tbl1) -- name: GiftAllowanceView
    local var1 = useTokens()

    return React.createElement(View, {
        tag = "row align-y-center gap-large size-full-0 auto-y padding-medium stroke-default radius-medium",
        testId = "GiftAllowanceView",
        LayoutOrder = tbl1.LayoutOrder
    }, {
        RemainingGifts = React.createElement(View, {
            tag = "row align-y-center fill gap-medium auto-y",
            LayoutOrder = 1
        }, {
            GiftIcon = React.createElement(Icon, {
                name = IconName.GiftBox,
                variant = IconVariant.Regular,
                size = IconSize.Medium,
                style = var1.Color.Content.Emphasis,
                LayoutOrder = 1
            }),
            Label = React.createElement(FoundationText, {
                tag = "fill auto-y text-body-medium text-no-wrap text-align-x-left content-emphasis",
                Text = tbl1.remainingGiftsText,
                testId = "gift-allowance-remaining-gifts",
                LayoutOrder = 2
            })
        }),
        Expiry = React.createElement(View, {
            tag = "row align-y-center gap-xsmall auto-xy padding-x-small padding-y-xsmall radius-small bg-shift-200",
            testId = "gift-allowance-expiry-pill",
            LayoutOrder = 2
        }, {
            ClockIcon = React.createElement(Icon, {
                name = IconName.Clock,
                variant = IconVariant.Filled,
                size = IconSize.XSmall,
                style = var1.Color.Content.Emphasis,
                LayoutOrder = 1
            }),
            Label = React.createElement(FoundationText, {
                tag = "auto-xy text-caption-medium text-no-wrap content-emphasis",
                Text = tbl1.expiryText,
                testId = "gift-allowance-expiry",
                LayoutOrder = 2
            })
        })
    })
end)

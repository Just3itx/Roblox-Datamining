-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)
local Foundation = require(RobloxSubscriptionPurchaseAppParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Badge = Foundation.Badge
local BadgeVariant = Foundation.Enums.BadgeVariant
local useLocalization = require(RobloxSubscriptionPurchaseAppParent.Localization).Hooks.useLocalization
local FFlagRobloxPlusUpsellBannerUseTryItForFree = require(RobloxSubscriptionPurchaseApp.Flags.FFlagRobloxPlusUpsellBannerUseTryItForFree)
local FFlagTTOnboardingSheet = require(RobloxSubscriptionPurchaseApp.Flags.FFlagTTOnboardingSheet)

local function RobloxPlusUpsellBannerCTA(tbl1)
    local var1 = useLocalization({
        getFreeTrialText = if FFlagRobloxPlusUpsellBannerUseTryItForFree then "Feature.RobloxSubscription.Action.TryItForFree" else "Feature.RobloxSubscription.Label.FreeTrialText",
        subscribe = "Feature.RobloxSubscription.Action.Subscribe",
        newBadge = "Feature.Catalog.Label.New"
    })

    local var2 = React.useCallback(function()
        if FFlagTTOnboardingSheet and tbl1.ctaText then
            return tbl1.ctaText
        end

        if tbl1.productInfo.isFreeTrial then
            return var1.getFreeTrialText
        end

        return var1.subscribe
    end, {
        tbl1.productInfo.isFreeTrial,
        var1.getFreeTrialText,
        var1.subscribe,
        tbl1.ctaText
    })

    if tbl1.shouldShowNewBadge then
        return React.createElement(
            View,
            {
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, 0, 0.5, 0),
                tag = "row align-y-center gap-xsmall auto-xy"
            },
            {
                NewBadge = React.createElement(Badge, { text = var1.newBadge, variant = BadgeVariant.Contrast, LayoutOrder = 1 })
            }
        )
    end

    return React.createElement(
        View,
        {
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            tag = "auto-xy"
        },
        {
            SubscribeText = React.createElement(
                FoundationText,
                {
                    tag = "auto-xy text-body-small content-default",
                    Text = "<u>" .. var2() .. "</u>",
                    RichText = true
                }
            )
        }
    )
end
return RobloxPlusUpsellBannerCTA

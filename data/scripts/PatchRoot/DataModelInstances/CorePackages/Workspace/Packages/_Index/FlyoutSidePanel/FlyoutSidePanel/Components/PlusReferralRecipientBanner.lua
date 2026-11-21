-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent
local React = require(FlyoutSidePanelParent.React)
local Foundation = require(FlyoutSidePanelParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local IconName = Foundation.Enums.IconName
local useLocalization = require(FlyoutSidePanelParent.Localization).Hooks.useLocalization
local FlyoutAnalytics = require(script.Parent.Parent.Analytics.FlyoutAnalytics)
local FIntPlusReferralRewardRobux = require(FlyoutSidePanelParent.SharedFlags).FIntPlusReferralRewardRobux
local usePlusReferralFlyoutNewBadge = require(FlyoutSidePanel.Hooks.usePlusReferralFlyoutNewBadge)

local function PlusReferralRecipientBanner(tbl1)
    local var1 = useTokens()
    local var2 = useLocalization({
        bannerText = {
            "Feature.RobloxSubscription.Heading.ReferralRecipientEntry",
            amount = tostring(FIntPlusReferralRewardRobux)
        },
        newBadgeText = "Feature.RobloxSubscription.Label.New"
    })

    local var3 = React.useCallback(function()
        tbl1.closeDrawer()
        if tbl1.onOpenReferralSheet then
            tbl1.onOpenReferralSheet(tbl1.referrerId)
        end
        FlyoutAnalytics.onFlyoutContentItemClicked({ integrationId = "PlusReferralRecipient", source = "click" })
    end, { tbl1.closeDrawer, tbl1.referrerId, tbl1.onOpenReferralSheet })

    local var4 = usePlusReferralFlyoutNewBadge(var3, "RobloxPlusUpsellImpressionCount3")

    return React.createElement(Foundation.View, {
        tag = "row align-y-center gap-medium size-full-0 auto-y padding-x-medium padding-y-medium",
        onActivated = var4.onActivated,
        testId = "--core-ui-flyout-plus-referral-recipient",
        LayoutOrder = tbl1.layoutOrder
    }, {
        PlusIcon = React.createElement(
            Icon,
            {
                style = var1.Color.Content.Emphasis,
                name = IconName.RobloxPlus,
                size = IconSize.Medium,
                LayoutOrder = 1
            }
        ),
        BannerText = React.createElement(FoundationText, {
            tag = "fill auto-y text-body-small text-wrap text-align-x-left content-emphasis",
            Text = var2.bannerText,
            LayoutOrder = 2
        }),
        NewBadge = if var4.shouldShowNewBadge then React.createElement(
            Foundation.View,
            {
                tag = "auto-xy padding-x-xsmall padding-y-xxsmall radius-circle bg-system-contrast",
                LayoutOrder = 3
            },
            {
                Text = React.createElement(
                    FoundationText,
                    {
                        Text = var2.newBadgeText,
                        tag = "auto-xy text-title-small",
                        textStyle = var1.Color.Surface.Surface_0
                    }
                )
            }
        ) else nil
    })
end

return PlusReferralRecipientBanner

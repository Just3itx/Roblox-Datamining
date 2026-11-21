-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent
local React = require(FlyoutSidePanelParent.React)
local useDispatch = require(FlyoutSidePanelParent.RoactUtils).Hooks.RoactRodux.useDispatch
local AppPage = require(FlyoutSidePanelParent.RobloxAppEnums).AppPage
local NavigateDown = require(FlyoutSidePanelParent.NavigationRodux).Thunks.NavigateDown
local SharedFlags = require(FlyoutSidePanelParent.SharedFlags)
local FFlagSignalsNavP3Dispatch = SharedFlags.FFlagSignalsNavP3Dispatch
local FIntPlusReferralRewardRobux = SharedFlags.FIntPlusReferralRewardRobux
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(FlyoutSidePanelParent.RobloxAppNavigation).NavigationCommands else nil
local Foundation = require(FlyoutSidePanelParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local IconName = Foundation.Enums.IconName
local useLocalization = require(FlyoutSidePanelParent.Localization).Hooks.useLocalization
local FlyoutAnalytics = require(script.Parent.Parent.Analytics.FlyoutAnalytics)
local usePlusReferralFlyoutNewBadge = require(FlyoutSidePanel.Hooks.usePlusReferralFlyoutNewBadge)

local function PlusReferralBanner(tbl1)
    local var1 = useTokens()
    local var2 = useDispatch()
    local var3 = useLocalization({
        bannerText = {
            "Feature.RobloxSubscription.Heading.ReferralEntry",
            amount = FIntPlusReferralRewardRobux
        },
        newBadgeText = "Feature.RobloxSubscription.Label.New"
    })

    local var4 = React.useCallback(function()
        tbl1.closeDrawer()
        local tbl2 = {
            name = AppPage.PlusReferralDashboard
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
        else
            var2(NavigateDown(tbl2))
        end
        FlyoutAnalytics.onFlyoutContentItemClicked({ integrationId = "PlusReferral", source = "click" })
    end, { tbl1.closeDrawer, var2 })

    local var5 = usePlusReferralFlyoutNewBadge(var4, "RobloxPlusUpsellImpressionCount1")

    return React.createElement(Foundation.View, {
        tag = "row align-y-center gap-medium size-full-0 auto-y padding-x-medium padding-y-medium",
        onActivated = var5.onActivated,
        testId = "--core-ui-flyout-plus-referral",
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
            Text = var3.bannerText,
            LayoutOrder = 2
        }),
        NewBadge = if var5.shouldShowNewBadge then React.createElement(
            Foundation.View,
            {
                tag = "auto-xy padding-x-xsmall padding-y-xxsmall radius-circle bg-system-contrast",
                LayoutOrder = 3
            },
            {
                Text = React.createElement(
                    FoundationText,
                    {
                        Text = var3.newBadgeText,
                        tag = "auto-xy text-title-small",
                        textStyle = var1.Color.Surface.Surface_0
                    }
                )
            }
        ) else nil
    })
end

return PlusReferralBanner

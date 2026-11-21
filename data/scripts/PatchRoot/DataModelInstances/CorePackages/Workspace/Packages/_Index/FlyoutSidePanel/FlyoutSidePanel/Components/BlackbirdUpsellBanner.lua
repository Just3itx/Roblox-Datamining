-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanelParent = script:FindFirstAncestor("FlyoutSidePanel").Parent
local React = require(FlyoutSidePanelParent.React)
local useDispatch = require(FlyoutSidePanelParent.RoactUtils).Hooks.RoactRodux.useDispatch
local AppPage = require(FlyoutSidePanelParent.RobloxAppEnums).AppPage
local NavigateDown = require(FlyoutSidePanelParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(FlyoutSidePanelParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(FlyoutSidePanelParent.RobloxAppNavigation).NavigationCommands else nil
local Foundation = require(FlyoutSidePanelParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local IconName = Foundation.Enums.IconName
local usePlaceholderLocalization = require(script.Parent.Parent.Hooks.usePlaceholderLocalization)
local FlyoutAnalytics = require(script.Parent.Parent.Analytics.FlyoutAnalytics)
local FlyoutContentSettings = require(script.Parent.Parent.Config.FlyoutContentSettings)
local SharedFlags = require(FlyoutSidePanelParent.SharedFlags)
local useLocalization = require(FlyoutSidePanelParent.Localization).Hooks.useLocalization

local FFlagBlackbirdUpdateStringFlyoutMenu = SharedFlags.FFlagBlackbirdUpdateStringFlyoutMenu
local bool1 = game:DefineFastFlag("FixFlyoutMenuTextWrap", false)
local bool2 = game:DefineFastFlag("FlyoutBlackbirdBannerFlexLayout", false)

local function BlackbirdUpsellBanner(tbl1)
    local var1 = useTokens()
    local var2 = useDispatch()
    local var3 = if FFlagBlackbirdUpdateStringFlyoutMenu then useLocalization({ bannerText = "Feature.RobloxSubscription.Description.ExclusiveBenefits" }) else usePlaceholderLocalization({ bannerText = "Feature.RobloxSubscription.Description.ExclusiveBenefits" })

    local onActivated = React.useCallback(function()
        tbl1.closeDrawer()
        local tbl2 = {
            name = AppPage.Blackbird
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
        else
            var2(NavigateDown(tbl2))
        end
        local blackbird = FlyoutContentSettings.ItemType.Blackbird
        if blackbird then
            FlyoutAnalytics.onFlyoutContentItemClicked({ integrationId = blackbird, source = "click" })
        end
    end, { tbl1.closeDrawer })

    if bool1 and bool2 then
        return React.createElement(Foundation.View, {
            tag = "row align-y-center gap-medium size-full-0 auto-y padding-x-medium padding-y-xlarge",
            onActivated = onActivated,
            testId = "--core-ui-flyout-blackbird-upsell",
            LayoutOrder = tbl1.layoutOrder
        }, {
            BlackbirdIcon = React.createElement(
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
            ChevronIcon = React.createElement(
                Icon,
                {
                    name = IconName.ChevronLargeRight,
                    size = IconSize.Medium,
                    style = var1.Color.Content.Default,
                    LayoutOrder = 3
                }
            )
        })
    end
    local createElement = React.createElement
    local view = Foundation.View
    local tbl2 = {
        tag = "size-full-0 auto-y padding-x-medium padding-y-xlarge",
        onActivated = onActivated,
        testId = "--core-ui-flyout-blackbird-upsell",
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = { ContentContainer = 0, ChevronIcon = 0 }
    local createElement2 = React.createElement
    local view2 = Foundation.View
    local tbl4 = {
        tag = "position-center-left anchor-center-left auto-xy align-y-center row gap-medium"
    }
    local tbl5 = {
        BlackbirdIcon = React.createElement(
            Icon,
            {
                style = var1.Color.Content.Emphasis,
                name = IconName.RobloxPlus,
                size = IconSize.Medium,
                LayoutOrder = 1
            }
        ),
        BannerText = React.createElement(FoundationText, {
            Size = if bool1 then UDim2.new(0.75, 0, 0, 0) else UDim2.new(0.65, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            tag = "text-body-small text-align-x-left text-wrap content-emphasis",
            Text = var3.bannerText,
            LayoutOrder = 2
        })
    }
    tbl3.ContentContainer = createElement2(view2, tbl4, tbl5)

    tbl3.ChevronIcon = React.createElement(Icon, {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        name = IconName.ChevronLargeRight,
        size = IconSize.Medium,
        style = var1.Color.Content.Default
    })
    return createElement(view, tbl2, tbl3)
end

return BlackbirdUpsellBanner

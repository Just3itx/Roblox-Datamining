-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:40:54Z
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
local Button = Foundation.Button
local IconSize = Foundation.Enums.IconSize
local InputSize = Foundation.Enums.InputSize
local useLocalization = require(FlyoutSidePanelParent.Localization).Hooks.useLocalization
local FlyoutAnalytics = require(script.Parent.Parent.Analytics.FlyoutAnalytics)
local FlyoutContentSettings = require(script.Parent.Parent.Config.FlyoutContentSettings)
local SharedFlags = require(FlyoutSidePanelParent.SharedFlags)
local FFlagEnableFlyoutMenuRobuxCardRefactor = SharedFlags.FFlagEnableFlyoutMenuRobuxCardRefactor
local FFlagEnableSharedFlyoutRobuxPill = SharedFlags.FFlagEnableSharedFlyoutRobuxPill
local RobuxPill = if FFlagEnableSharedFlyoutRobuxPill then require(FlyoutSidePanelParent.RobuxPill).RobuxPill else nil

local function numWithCommas(robuxBalance: number) -- Luacid: Inlined by compiler; 1 call site recovered
    return tostring(robuxBalance):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

return React.memo(function(tbl1) -- name: RobuxPill
    local var1 = useTokens()
    local var2 = useDispatch()
    local var3 = useLocalization({ buyRobux = "IAPExperience.RobuxUpsell.Action.BuyRobux" })

    local var4 = React.useCallback(function()
        tbl1.closeDrawer()
        local tbl2 = {
            name = AppPage.PurchaseRobux
        }
        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl2))
        else
            var2(NavigateDown(tbl2))
        end
        local robuxPill = FlyoutContentSettings.ItemType.RobuxPill
        FlyoutAnalytics.onFlyoutContentItemClicked({ integrationId = robuxPill, source = "click" })
    end, { tbl1.closeDrawer, var2 })

    if FFlagEnableSharedFlyoutRobuxPill then
        return React.createElement(RobuxPill, {
            layoutOrder = tbl1.layoutOrder,
            robuxBalance = tbl1.robuxBalance,
            buyButtonText = var3.buyRobux,
            onBuyActivated = var4,
            showBorder = not FFlagEnableFlyoutMenuRobuxCardRefactor
        })
    end

    local tag = if FFlagEnableFlyoutMenuRobuxCardRefactor then "size-full-0 auto-y padding-x-medium padding-y-xlarge" else "size-full-0 auto-y padding-xlarge"
    return React.createElement(
        Foundation.View,
        {
            tag = tag,
            onActivated = var4,
            testId = "--core-ui-flyout-robux-pill",
            LayoutOrder = tbl1.layoutOrder
        },
        {
            RobuxContainer = React.createElement(
                Foundation.View,
                {
                    tag = "position-center-left anchor-center-left auto-xy align-y-center row gap-small"
                },
                {
                    RobuxIcon = React.createElement(Icon, { name = "icons/common/goldrobux", size = IconSize.Medium, LayoutOrder = 1 }),
                    RobuxAmount = React.createElement(FoundationText, {
                        Size = UDim2.new(0.5, 0, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        tag = "text-title-large text-align-x-left content-emphasis text-truncate-end",
                        Text = numWithCommas(tbl1.robuxBalance),
                        LayoutOrder = 2
                    })
                }
            ),
            BuyRobuxButton = React.createElement(Button, {
                testId = "--core-ui-flyout-button-buy-robux",
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, 0, 0.5, 0),
                text = var3.buyRobux,
                size = InputSize.Small,
                onActivated = var4
            }),
            UIStroke = if FFlagEnableFlyoutMenuRobuxCardRefactor then nil else React.createElement("UIStroke", {
                Color = var1.Color.Stroke.Default.Color3,
                Transparency = var1.Color.Stroke.Default.Transparency,
                Thickness = var1.Stroke.Standard
            }),
            UICorner = if FFlagEnableFlyoutMenuRobuxCardRefactor then nil else React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) })
        }
    )
end)

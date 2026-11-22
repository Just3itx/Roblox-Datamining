-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local React = require(RobloxSubscriptionPurchaseAppParent.React)
local Foundation = require(RobloxSubscriptionPurchaseAppParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Icon = Foundation.Icon
local IconSize = Foundation.Enums.IconSize
local IconName = Foundation.Enums.IconName
local useTokens = Foundation.Hooks.useTokens

local useLocalization = require(RobloxSubscriptionPurchaseAppParent.Localization).Hooks.useLocalization

local FFlagSupportNewBadgeRobloxPlus = require(RobloxSubscriptionPurchaseApp.Flags.FFlagSupportNewBadgeRobloxPlus)
local useRobloxPlusUpsellBannerNewBadgeInteraction = require(RobloxSubscriptionPurchaseApp.Hooks.useRobloxPlusUpsellBannerNewBadgeInteraction)
local RobloxPlusUpsellBannerCTA = require(script.Parent.RobloxPlusUpsellBannerCTA)
local FFlagRobloxPlusUpsellBannerUseTryItForFree = require(RobloxSubscriptionPurchaseApp.Flags.FFlagRobloxPlusUpsellBannerUseTryItForFree)
local bool1 = game:DefineFastFlag("BoldBlackbirdUpsellBannerStroke", false)

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase
local FFlagTTOnboardingSheet = require(RobloxSubscriptionPurchaseApp.Flags.FFlagTTOnboardingSheet)

local function BlackbirdUpsellBanner(tbl1)
    local var1 = useTokens()

    local var2 = useLocalization({
        bannerText = {
            "Feature.RobloxSubscription.Label.BlackbirdUpsellBanner",
            discountPercentage = tbl1.productInfo.initialDiscountPercentage or 10
        },
        getFreeTrialText = if FFlagRobloxPlusUpsellBannerUseTryItForFree then "Feature.RobloxSubscription.Action.TryItForFree" else "Feature.RobloxSubscription.Label.FreeTrialText",
        subscribe = "Feature.RobloxSubscription.Action.Subscribe"
    })

    local var3 = React.useCallback(function()
        return if tbl1.productInfo.isFreeTrial then var2.getFreeTrialText else var2.subscribe
    end, { tbl1.productInfo.isFreeTrial, var2.getFreeTrialText, var2.subscribe })

    local var4 = if FFlagSupportNewBadgeRobloxPlus then useRobloxPlusUpsellBannerNewBadgeInteraction(tbl1.onActivated) else nil
    local createElement = React.createElement
    local var5 = View
    local tbl2 = {
        tag = "size-full-0 auto-y padding-medium",
        onActivated = if FFlagSupportNewBadgeRobloxPlus then var4.onActivated else tbl1.onActivated,
        LayoutOrder = tbl1.LayoutOrder
    }
    local tbl3 = {
        ContentContainer = 0,
        SubscribeText = 0,
        SubscribeCTA = 0,
        UIStroke = 0,
        UICorner = 0
    }
    local createElement2 = React.createElement
    local var6 = View
    local tbl4 = { tag = "row align-y-center gap-small size-full-0 auto-y" }

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
            Size = UDim2.new(0.7, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            TextWrapped = true,
            tag = "text-body-small text-align-x-left content-emphasis",
            Text = if (FFlagLuaAppsEnablePromptVIPServerPurchase or FFlagTTOnboardingSheet) and tbl1.bannerText then tbl1.bannerText else var2.bannerText,
            LayoutOrder = 2
        })
    }
    tbl3.ContentContainer = createElement2(var6, tbl4, tbl5)

    tbl3.SubscribeText = if FFlagSupportNewBadgeRobloxPlus then nil else React.createElement(FoundationText, {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, 0, 0.5, 0),
        tag = "auto-xy text-body-small content-default",
        Text = "<u>" .. var3() .. "</u>",
        RichText = true
    })
    local element = if FFlagSupportNewBadgeRobloxPlus then React.createElement(RobloxPlusUpsellBannerCTA, {
        productInfo = tbl1.productInfo,
        shouldShowNewBadge = var4.shouldShowNewBadge,
        ctaText = if FFlagTTOnboardingSheet then tbl1.ctaText else nil
    }) else nil
    tbl3.SubscribeCTA = element

    tbl3.UIStroke = React.createElement("UIStroke", {
        Color = var1.Color.Stroke.Default.Color3,
        Transparency = var1.Color.Stroke.Default.Transparency,
        Thickness = if bool1 then var1.Stroke.Thick else var1.Stroke.Standard
    })
    tbl3.UICorner = React.createElement("UICorner", { CornerRadius = UDim.new(0, var1.Radius.Medium) })
    return createElement(var5, tbl2, tbl3)
end

return BlackbirdUpsellBanner

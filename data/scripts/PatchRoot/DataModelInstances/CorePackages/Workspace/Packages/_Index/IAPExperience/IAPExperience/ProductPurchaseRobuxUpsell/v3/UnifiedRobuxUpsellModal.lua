-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local SharedFlags = require(scriptParentParentParentParent.SharedFlags)

local Foundation = require(scriptParentParentParentParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local ButtonGroup = Foundation.ButtonGroup
local ButtonVariant = Foundation.Enums.ButtonVariant
local FillBehavior = Foundation.Enums.FillBehavior
local EnumsOrientation = Foundation.Enums.Orientation
local Sheet = Foundation.Sheet
local useScaledValue = Foundation.Hooks.useScaledValue
local Enums = Foundation.Enums
local getIconRichText = Foundation.Utility.getIconRichText

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParentParentParentParent.AppLocales).Localization
local Localization2 = require(scriptParentParentParentParent.Localization)
local LocalizationProvider = Localization2.LocalizationProvider
local useLocalization = Localization2.Hooks.useLocalization

local UnifiedProductDetails = require(scriptParentParentParent.Generic.UnifiedProductDetails)
local YellowBadge = require(scriptParentParentParent.Generic.YellowBadge)
local GrayBadge = require(scriptParentParentParent.Generic.GrayBadge)
local PriceSummary = require(scriptParentParentParent.Generic.PriceSummary)
local UnifiedPurchaseModalHeader = require(scriptParentParentParent.Generic.UnifiedPurchaseModalHeader)
local ProductDetailsContainer = require(scriptParentParentParent.Generic.ProductDetailsContainer)
local CartPricingLoading = require(scriptParentParentParent.ProductPurchase.v4.CartPricingLoading)
local buildCartPricingOfferCheckboxes = require(scriptParentParentParent.ProductPurchase.v4.buildCartPricingOfferCheckboxes)
local useCartPricing = require(scriptParentParentParent.ProductPurchase.v4.useCartPricing)

local useInitialButtonDisableDelay = require(scriptParentParentParent.Generic.Hooks.useInitialButtonDisableDelay)
local useFocusNavigationRefs = require(scriptParentParentParent.Generic.Hooks.useFocusNavigationRefs)

local UnifiedPurchaseModalTypeEnum = require(scriptParentParentParent.Enums.UnifiedPurchaseModalTypeEnum)
local _cartPricingResponseLineItem = require(scriptParentParentParent.ProductPurchase.v4.cartPricingResponseLineItem)

local formatNumber = require(scriptParentParentParent.Utility.formatNumber)
local getUpsellBadgeInfo = require(scriptParentParentParent.Utility.getUpsellBadgeInfo)

local Constants = require(scriptParentParentParent.Generic.Constants)

local UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_SINGLE_PACKAGE = Constants.UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_SINGLE_PACKAGE

local UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_DEFAULT = Constants.UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_DEFAULT

local UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_WITH_MULTIPLE_PACKAGES = Constants.UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_WITH_MULTIPLE_PACKAGES

local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird

local FFlagEnableRobuxUpsellPlusButtonExperiment = require(scriptParentParentParent.Flags.FFlagEnableRobuxUpsellPlusButtonExperiment)

local FFlagUnifiedPurchaseFlowMarketplaceUIImprovements = require(scriptParentParentParent.Parent.SharedFlags).FFlagUnifiedPurchaseFlowMarketplaceUIImprovements
local num1 = game:DefineFastInt("CompactUpsellModalBreakpoint", 400)

local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(scriptParentParentParent.Parent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs
local FFlagShouldFixDevSubsFlashingTitle = require(scriptParentParentParent.Flags.FFlagShouldFixDevSubsFlashingTitle)

local GetFFlagIAPExperienceEnableMultiDisplayUpsell = require(scriptParentParentParent.Flags.GetFFlagIAPExperienceEnableMultiDisplayUpsell)

local GetFFlagIAPExperienceUseUpsellBadgeHelper = require(scriptParentParentParent.Flags.GetFFlagIAPExperienceUseUpsellBadgeHelper)
local FFlagFixUpsellModalUnevenLayout = require(scriptParentParentParent.Flags.FFlagFixUpsellModalUnevenLayout)

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(scriptParentParentParent.Parent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local _GetUpsellSuggestionsTypes = require(scriptParentParentParent.Api.PaymentsGateway.GetUpsellSuggestionsTypes)
local BadgeType = require(scriptParentParentParent.Enums.BadgeType)
local _VirtualItemBadgeType = require(scriptParentParentParent.Enums.VirtualItemBadgeType)
local _PricingTypes = require(scriptParentParentParent.ProductPurchase.PricingTypes)

local function UpsellProductDetailsLegacyImpl(tbl1, tbl2)
    local var1 = if tbl1.badgeType == BadgeType.Popular then tbl2.Popular elseif tbl1.badgeType == BadgeType.LastPurchased then tbl2.LastPurchased else nil
    local icon = if tbl1.badgeType == BadgeType.Popular then "icons/menu/fire_fill" else nil

    local str1 = "size-full-1400 radius-medium padding-x-large row"
    local tag = if tbl1.selected then str1 .. " bg-surface-200 stroke-system-contrast stroke-thick" else str1 .. " bg-surface-300 stroke-emphasis stroke-standard"
    local str2 = if tbl1.isCompact then "auto-xy text-title-small content-emphasis text-align-x-left" else "auto-xy text-title-large content-emphasis text-align-x-left"

    local str3 = if tbl1.isCompact then "auto-xy text-title-small content-muted text-align-x-left" else "auto-xy text-title-large content-muted text-align-x-left"

    local str4 = if tbl1.isCompact then "auto-xy text-title-small content-emphasis text-align-x-right" else "auto-xy text-title-large content-emphasis text-align-x-right"

    local createElement = React.createElement
    local var3 = View
    local tbl3 = {
        LayoutOrder = tbl1.layoutOrder,
        onActivated = tbl1.onSelected,
        tag = tag,
        Size = if tbl1.isCompact then UDim2.new(1, 0, 0, 40) else nil
    }
    local tbl4 = {
        LeftSide = React.createElement(View, {
            LayoutOrder = 1,
            tag = { ["row align-y-center gap-small"] = true, ["align-x-start"] = true },
            Size = UDim2.new(0.5, 0, 1, 0)
        }, {
            RobuxAmount = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = utf8.char(57346) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.product.robuxAmount),
                tag = str2
            }),
            RobuxAmountBonus = tbl1.product.robuxAmountBeforeBonus
                and React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    RichText = true,
                    Text = "<s>" .. utf8.char(57346) .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.product.robuxAmountBeforeBonus) .. "</s>",
                    tag = str3
                })
        }),
        RightSide = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "row align-x-right align-y-center gap-large",
                Size = UDim2.new(0.5, 0, 1, 0)
            },
            {
                Badge = if var1 then React.createElement(YellowBadge, { LayoutOrder = 1, Text = var1, Icon = icon }) else nil,
                RobuxPrice = React.createElement(FoundationText, { LayoutOrder = 2, Text = tbl1.product.price or "", tag = str4 })
            }
        )
    }
    return createElement(var3, tbl3, tbl4)
end

local function UpsellProductDetailsMultiDisplayFixedImpl(tbl1, tbl2)
    local var1, var2

    if GetFFlagIAPExperienceUseUpsellBadgeHelper() then
        local upsellBadgeInfo = getUpsellBadgeInfo(tbl1.badgeType, tbl2)
        var1 = upsellBadgeInfo.text
        var2 = upsellBadgeInfo.icon
    else
        if tbl1.badgeType == BadgeType.Popular then
            var1 = tbl2.Popular
        elseif tbl1.badgeType == BadgeType.LastPurchased then
            var1 = tbl2.LastPurchased
        elseif tbl1.badgeType == BadgeType.ForYou then
            var1 = tbl2.ForYouItem
        elseif tbl1.badgeType == BadgeType.BetterValue then
            var1 = tbl2.BetterValue
        else
            var1 = nil
        end
        if tbl1.badgeType == BadgeType.Popular then
            var2 = Enums.IconName.Flame
        elseif tbl1.badgeType == BadgeType.ForYou then
            var2 = Enums.IconName.CircleStar
        elseif tbl1.badgeType == BadgeType.BetterValue then
            var2 = Enums.IconName.Tag
        else
            var2 = nil
        end
    end

    local str1 = if tbl1.isCompact then "size-full-1000 radius-medium padding-small row" else "size-full-1400 radius-medium padding-x-large row"
    local tag = if tbl1.selected then str1 .. " bg-surface-200 stroke-system-contrast stroke-thick" else str1 .. " bg-surface-300 stroke-default stroke-standard"
    local str2 = if tbl1.isCompact then "auto-xy text-title-small content-emphasis text-align-x-left" else "auto-xy text-heading-small content-emphasis text-align-x-left"

    local str3 = if tbl1.isCompact then "auto-xy text-title-small content-muted text-align-x-left" else "auto-xy text-title-medium content-muted text-align-x-left"

    local str4 = if tbl1.isCompact then "auto-xy text-title-small content-emphasis text-align-x-right" else "auto-xy text-title-large content-emphasis text-align-x-right"

    local createElement = React.createElement
    local var3 = View
    local tbl3 = {
        LayoutOrder = tbl1.layoutOrder,
        onActivated = tbl1.onSelected,
        tag = tag
    }
    local tbl4 = {
        LeftSide = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "row align-x-left align-y-center gap-small",
                Size = UDim2.new(0.5, 0, 1, 0)
            },
            {
                RobuxAmount = React.createElement(FoundationText, {
                    LayoutOrder = 1,
                    RichText = true,
                    Text = getIconRichText(Enums.IconName.Robux) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.product.robuxAmount),
                    tag = str2
                }),
                RobuxAmountBonus = tbl1.product.robuxAmountBeforeBonus
                    and React.createElement(FoundationText, {
                        LayoutOrder = 2,
                        RichText = true,
                        Text = "<s>" .. getIconRichText(Enums.IconName.Robux) .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.product.robuxAmountBeforeBonus) .. "</s>",
                        tag = str3
                    }),
                Badge = if var1 then React.createElement(GrayBadge, { LayoutOrder = 3, Text = var1, iconName = var2 }) else nil
            }
        ),
        RightSide = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "row align-x-right align-y-center gap-large",
                Size = UDim2.new(0.5, 0, 1, 0)
            },
            {
                RobuxPrice = React.createElement(FoundationText, { LayoutOrder = 1, Text = tbl1.product.price or "", tag = str4 })
            }
        )
    }
    return createElement(var3, tbl3, tbl4)
end

local function UpsellProductDetailsMultiDisplayImpl(tbl1, tbl2)
    local var1, var2

    if GetFFlagIAPExperienceUseUpsellBadgeHelper() then
        local upsellBadgeInfo = getUpsellBadgeInfo(tbl1.badgeType, tbl2)
        var1 = upsellBadgeInfo.text
        var2 = upsellBadgeInfo.icon
    else
        if tbl1.badgeType == BadgeType.Popular then
            var1 = tbl2.Popular
        elseif tbl1.badgeType == BadgeType.LastPurchased then
            var1 = tbl2.LastPurchased
        elseif tbl1.badgeType == BadgeType.ForYou then
            var1 = tbl2.ForYouItem
        elseif tbl1.badgeType == BadgeType.BetterValue then
            var1 = tbl2.BetterValue
        else
            var1 = nil
        end
        if tbl1.badgeType == BadgeType.Popular then
            var2 = Enums.IconName.Flame
        elseif tbl1.badgeType == BadgeType.ForYou then
            var2 = Enums.IconName.CircleStar
        elseif tbl1.badgeType == BadgeType.BetterValue then
            var2 = Enums.IconName.Tag
        else
            var2 = nil
        end
    end

    local str1 = if tbl1.isCompact then "size-full-0 auto-y radius-medium padding-small row" else "col align-x-left gap-medium size-full-0 auto-y padding-medium radius-medium"
    local tag = if tbl1.selected then str1 .. " bg-surface-200 stroke-system-contrast stroke-thick" else str1 .. " bg-surface-300 stroke-default stroke-standard"
    local str2 = if tbl1.isCompact then "auto-xy text-title-small content-emphasis text-align-x-left" else "auto-xy text-heading-small content-emphasis text-align-x-left"

    local str3 = if tbl1.isCompact then "auto-xy text-title-small content-muted text-align-x-left" else "auto-xy text-title-medium content-muted text-align-x-left"

    local str4 = if tbl1.isCompact then "auto-xy text-title-small content-emphasis text-align-x-right" else "auto-xy text-title-large content-emphasis text-align-x-right"

    local createElement = React.createElement
    local var3 = View
    local tbl3 = {
        LayoutOrder = tbl1.layoutOrder,
        onActivated = tbl1.onSelected,
        tag = tag,
        Size = if tbl1.isCompact then UDim2.new(1, 0, 0, 40) else nil
    }
    local tbl4 = {
        LeftSide = React.createElement(View, {
            LayoutOrder = 1,
            tag = {
                ["row align-x-left align-y-center gap-small"] = true,
                ["size-full-0 auto-y"] = not tbl1.isCompact
            },
            Size = if tbl1.isCompact then UDim2.new(0.65, 0, 1, 0) else nil
        }, {
            RobuxAmount = React.createElement(FoundationText, {
                LayoutOrder = 1,
                RichText = true,
                Text = getIconRichText(Enums.IconName.Robux) .. " " .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.product.robuxAmount),
                tag = str2
            }),
            RobuxAmountBonus = tbl1.product.robuxAmountBeforeBonus
                and React.createElement(FoundationText, {
                    LayoutOrder = 2,
                    RichText = true,
                    Text = "<s>" .. getIconRichText(Enums.IconName.Robux) .. formatNumber(LocalizationService.RobloxLocaleId, tbl1.product.robuxAmountBeforeBonus) .. "</s>",
                    tag = str3
                }),
            Badge = if var1 then React.createElement(GrayBadge, { LayoutOrder = 3, Text = var1, iconName = var2 }) else nil
        }),
        RightSide = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = {
                    ["row align-x-right align-y-center gap-large"] = true,
                    ["size-full-0 auto-y"] = not tbl1.isCompact
                },
                Size = if tbl1.isCompact then UDim2.new(0.35, 0, 1, 0) else nil
            },
            {
                RobuxPrice = React.createElement(FoundationText, { LayoutOrder = 1, Text = tbl1.product.price or "", tag = str4 })
            }
        )
    }
    return createElement(var3, tbl3, tbl4)
end

local function UpsellProductDetails(tbl1)
    local var1 = useLocalization({
        Popular = "IAPExperience.RobuxUpsell.Text.PopularItem",
        LastPurchased = "IAPExperience.RobuxUpsell.Text.LastPurchased",
        ForYouItem = "IAPExperience.RobuxUpsell.Text.ForYou",
        BetterValue = "IAPExperience.RobuxUpsell.Text.BetterValue",
        BestValue = "IAPExperience.RobuxUpsell.Text.BestValue"
    })

    if GetFFlagIAPExperienceEnableMultiDisplayUpsell() then
        if FFlagFixUpsellModalUnevenLayout then
            return UpsellProductDetailsMultiDisplayFixedImpl(tbl1, var1)
        end
        return UpsellProductDetailsMultiDisplayImpl(tbl1, var1)
    end
    return UpsellProductDetailsLegacyImpl(tbl1, var1)
end

local function resolveRobloxPlusCta(tbl1) -- Luacid: unused: defined but never referenced
    local robloxPlusDiscountPercentage = tbl1.robloxPlusDiscountPercentage
    if type(robloxPlusDiscountPercentage) ~= "number" then
        return nil, nil
    end
    return robloxPlusDiscountPercentage, tbl1.onRobloxPlusButtonActivated
end

local function UnifiedRobuxUpsellModal(tbl1)
    local robloxPlusDiscountPercentage, onRobloxPlusButtonActivated

    if FFlagEnableRobuxUpsellPlusButtonExperiment then
        robloxPlusDiscountPercentage = tbl1.robloxPlusDiscountPercentage
        if type(robloxPlusDiscountPercentage) == "number" then
            onRobloxPlusButtonActivated = tbl1.onRobloxPlusButtonActivated
        else
            robloxPlusDiscountPercentage = nil
            onRobloxPlusButtonActivated = nil
        end
    else
        robloxPlusDiscountPercentage = nil
        onRobloxPlusButtonActivated = nil
    end

    local cartPricing = useCartPricing({
        product = tbl1.product,
        purchaseModalType = tbl1.purchaseModalType,
        cartPricingResponse = tbl1.cartPricingResponse,
        onCartOfferAppliedChanged = tbl1.onCartOfferAppliedChanged
    })

    local product = React.useMemo(function()
        return if cartPricing.showCartOfferUi then cartPricing.mergedProductForDetails else tbl1.product
    end, { tbl1.product, cartPricing.showCartOfferUi, cartPricing.mergedProductForDetails })

    local var3 = useLocalization({
        Buy = "IAPExperience.PurchasePrompt.Action.Buy",
        GetTenPercentOff = robloxPlusDiscountPercentage ~= nil
            and {
                "IAPExperience.RobuxUpsell.Action.GetPercentOff",
                discountPercentage = robloxPlusDiscountPercentage
            }
            or nil,
        Subscribe = if FFlagEnableUnifiedPurchaseFlowForDevSubs then "Feature.Subscription.Action.Subscribe" else nil,
        DisclosurePayment = "IAPExperience.RobuxUpsell.Text.DisclosurePayment",
        DisclosureTermsURL = "IAPExperience.RobuxUpsell.Text.DisclosureTermsURL",
        TermsOfUse = "IAPExperience.RobuxUpsell.Text.TermsOfUse",
        BuyRobuxAndExperience = "IAPExperience.PurchasePrompt.BuyRobuxAndExperience",
        BuyRobuxAndItem = "IAPExperience.PurchasePrompt.Title.BuyRobuxAndItem",
        BuyRobuxAndItems = "IAPExperience.PurchasePrompt.Title.BuyRobuxAndItems",
        BuyRobuxOnly = if FFlagAXMISWithBlackbird then "IAPExperience.PurchasePrompt.Title.BuyRobuxOnly" else nil,
        BuyRobuxAndAvatar = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then "IAPExperience.PurchasePrompt.Header.BuyRobuxAndAvatar" else nil,
        BuyRobuxAndSubscription = if FFlagEnableUnifiedPurchaseFlowForDevSubs then "IAPExperience.PurchasePrompt.BuyRobuxAndSubscription" else nil,
        PerMonth = if FFlagEnableUnifiedPurchaseFlowForDevSubs then "Feature.Subscription.Text.PerMonth" elseif FFlagLuaAppsEnablePromptVIPServerPurchase then "Feature.Subscription.Text.PerMonth" else nil
    })
    local isCompact = if FFlagEnableUnifiedPurchaseFlowForDevSubs
        and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription then tbl1.screenSize.Y > 0 and tbl1.screenSize.Y < num1 else tbl1.screenSize.Y < num1
    local isDisabled = useInitialButtonDisableDelay(false)

    local var5, var6 = React.useState(UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_DEFAULT)

    React.useEffect(function()
        if not GetFFlagIAPExperienceEnableMultiDisplayUpsell() or FFlagFixUpsellModalUnevenLayout then
            if #tbl1.upsellSuggestions > 1 then
                var6(UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_WITH_MULTIPLE_PACKAGES)
            end

            if FFlagEnableUnifiedPurchaseFlowForDevSubs
                and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription
            then
                var6(UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_WITH_MULTIPLE_PACKAGES)
            end
            return
        end

        if FFlagEnableUnifiedPurchaseFlowForDevSubs
            and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription
        then
            var6(UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_WITH_MULTIPLE_PACKAGES)
            return
        end
        local upsellSuggestionsLen = #tbl1.upsellSuggestions
        if upsellSuggestionsLen == 1 then
            var6(UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_SINGLE_PACKAGE)
        elseif upsellSuggestionsLen == 2 then
            var6(UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_DEFAULT)
        else
            var6(UNIFIED_ROBUX_UPSELL_MODAL_MIN_HEIGHT_PIXELS_WITH_MULTIPLE_PACKAGES)
        end
    end, { tbl1.upsellSuggestions, tbl1.purchaseModalType })

    local var7 = useScaledValue(var5 or 0)

    local titleText, var9 = React.useState(var3.BuyRobuxAndItem)
    React.useEffect(function()
        local purchaseModalType = tbl1.purchaseModalType

        if FFlagEnableUnifiedPurchaseFlowForDevSubs and purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription then
            local buyRobuxAndItem = var3.BuyRobuxAndItem

            if FFlagShouldFixDevSubsFlashingTitle and var3.BuyRobuxAndSubscription and var3.BuyRobuxAndSubscription ~= "" then
                buyRobuxAndItem = var3.BuyRobuxAndSubscription
            end
            var9(buyRobuxAndItem)
            return
        end

        if purchaseModalType ~= UnifiedPurchaseModalTypeEnum.MultiItem then
            if purchaseModalType == UnifiedPurchaseModalTypeEnum.Experience then
                var9(var3.BuyRobuxAndExperience)
            else
                var9(var3.BuyRobuxAndItem)
            end

            return
        end

        if FFlagAXMISWithBlackbird then
            if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements and tbl1.product.itemName ~= "RobuxUpsell" then
                var9(var3.BuyRobuxAndAvatar)
                return
            end
            var9(var3.BuyRobuxOnly)
        elseif FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then
            var9(var3.BuyRobuxAndAvatar)
        else
            var9(var3.BuyRobuxAndItems)
        end
    end, {
        tbl1.purchaseModalType,
        var3.BuyRobuxAndAvatar,
        var3.BuyRobuxAndExperience,
        var3.BuyRobuxAndItem,
        var3.BuyRobuxAndItems,
        var3.BuyRobuxAndSubscription,
        if FFlagAXMISWithBlackbird then tbl1.product.itemName else nil,
        if FFlagAXMISWithBlackbird then var3.BuyRobuxOnly else nil
    })

    local var10, ref = useFocusNavigationRefs(tbl1.buttons.cancelPurchaseActivated, tbl1.onBuyItemButtonMounted)

    React.useEffect(function() end, { tbl1.upsellSuggestions })

    local function onSelected(num2: number) -- Luacid: Inlined by compiler; 3 call sites recovered
        tbl1.onUpsellSuggestionsSelected(num2)
    end

    local tbl2 = string.split(var3.DisclosureTermsURL, " {termsofuse} ")
    local termsOfUse = var3.TermsOfUse
    if tbl1.termsOfUseActivated then
        termsOfUse = "<u>" .. termsOfUse .. "</u>"
    end

    local var12 = FFlagEnableUnifiedPurchaseFlowForDevSubs
        and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription
    local perMonth = if var12 then var3.PerMonth elseif FFlagLuaAppsEnablePromptVIPServerPurchase and tbl1.isMonthlyPrice then var3.PerMonth else nil
    local text = if var12 then var3.Subscribe else var3.Buy
    local var1 = tbl1.isCartPricingLoading == true or isDisabled
    local cartPricingOfferCheckboxes = buildCartPricingOfferCheckboxes({ cartPricing = cartPricing, isDisabled = var1 })
    local postPurchaseActions = if next(cartPricingOfferCheckboxes) then React.createElement(View, { tag = "col gap-medium size-full-0 auto-y", LayoutOrder = 3 }, cartPricingOfferCheckboxes) else nil
    local element2 = React.createElement(ProductDetailsContainer, {
        purchaseModalType = tbl1.purchaseModalType,
        product = product,
        isCompact = isCompact,
        model = product.model,
        priceSuffix = perMonth,
        includePriceSuffixOnOriginal = if FFlagLuaAppsEnablePromptVIPServerPurchase then tbl1.isMonthlyPrice else nil,
        hideDiscountSummary = tbl1.isCartPricingLoading,
        savingsSummary = cartPricing.cartPricingSavingsSummary
    })

    local fFlagIapExperienceEnableMultiDisplayUpsell = GetFFlagIAPExperienceEnableMultiDisplayUpsell()
    local tag = if fFlagIapExperienceEnableMultiDisplayUpsell then "col align-x-center align-y-start gap-medium size-full-0 auto-y" else "col gap-medium auto-y size-full-0 align-x-center align-y-start"

    local str1 = if fFlagIapExperienceEnableMultiDisplayUpsell then "col align-x-center align-y-start gap-medium size-full-0 auto-y padding-x-xsmall" else "col gap-medium auto-y size-full-0 align-x-center align-y-center padding-x-xsmall padding-y-small padding-bottom-xxlarge"

    local str2 = if onRobloxPlusButtonActivated then "col gap-small size-full-0 auto-y" elseif fFlagIapExperienceEnableMultiDisplayUpsell then "row wrap align-x-center align-y-center gap-medium size-full-0 auto-y" else "row wrap auto-xy align-y-center align-x-center size-full-0 gap-medium"

    local str3 = if fFlagIapExperienceEnableMultiDisplayUpsell then "row wrap align-x-left align-y-center gap-xxsmall size-full-0 auto-y" else "row wrap auto-y align-y-center align-x-center size-full-0 gap-xxsmall"

    local size = if isCompact then "Small" elseif fFlagIapExperienceEnableMultiDisplayUpsell then "Medium" else nil

    local tbl3 = {
        LayoutOrder = 1,
        text = text,
        onActivated = tbl1.buttons.buyItemActivated,
        inputDelay = tbl1.buttons.buyItemEnableInputDelayed and (if isDisabled then 0 else 2.5) or 0,
        isDisabled = isDisabled,
        ref = ref,
        fillBehavior = FillBehavior.Fill,
        variant = ButtonVariant.Emphasis,
        size = size
    }
    local str4 = if fFlagIapExperienceEnableMultiDisplayUpsell then "col align-x-center align-y-center gap-medium size-full-0 auto-y" else "col gap-medium auto-y size-full-0 align-x-center align-y-center"

    local createElement = React.createElement
    local root = Sheet.Root
    local tbl4 = {
        onClose = tbl1.buttons.cancelPurchaseActivated,
        snapPoints = { var7, 0.8 },
        centerSheetHeight = 0,
        preferCenterSheet = true,
        ref = 0
    }

    if FFlagFixUpsellModalUnevenLayout or not fFlagIapExperienceEnableMultiDisplayUpsell then
        var7 = nil
    end

    tbl4.centerSheetHeight = var7

    if isDisabled then
        var10 = nil
    end

    tbl4.ref = var10
    local tbl5 = { Header = 0, Content = 0, Actions = 0 }
    local createElement2 = React.createElement
    local header = Sheet.Header
    local tbl6 = {
        hasCloseAffordance = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then if tbl1.hideUserRobuxBalance then true else nil else nil
    }

    local tbl7 = {
        ModalHeader = React.createElement(UnifiedPurchaseModalHeader, {
            titleText = titleText,
            robuxBalanceAmount = tbl1.userBalance,
            hideUserRobuxBalance = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then tbl1.hideUserRobuxBalance else nil
        })
    }
    tbl5.Header = createElement2(header, tbl6, tbl7)

    local createElement3 = React.createElement
    local content = Sheet.Content
    local tbl8 = { LayoutOrder = 2 }

    local tbl9 = { SheetContentContainer = 0 }
    local createElement4 = React.createElement
    local var16 = View
    local tbl10 = { tag = tag }
    local tbl11 = {
        ProductDetailsContainer = 0,
        CartPricingLoading = 0,
        PostPurchaseActions = 0,
        UpsellSuggestions = 0
    }

    if not element2 then
        local createElement5 = React.createElement
        local var17 = View
        local tbl12 = { tag = str4, LayoutOrder = 1 }

        local tbl13 = { ProductDetails = 0 }
        local element3

        if tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.MultiItem then
            element3 = React.createElement(PriceSummary, { amount = tbl1.product.itemRobuxCost })
        else
            element3 = React.createElement(UnifiedProductDetails, {
                isPortrait = false,
                isCompact = isCompact,
                itemIcon = product.itemIcon,
                itemName = product.itemName,
                itemRobuxCost = product.itemRobuxCost,
                model = product.model,
                priceSuffix = perMonth,
                includePriceSuffixOnOriginal = if FFlagLuaAppsEnablePromptVIPServerPurchase then tbl1.isMonthlyPrice else nil
            })
        end

        tbl13.ProductDetails = element3
        element2 = createElement5(var17, tbl12, tbl13)
    end

    tbl11.ProductDetailsContainer = element2

    tbl11.CartPricingLoading = React.createElement(CartPricingLoading, { isLoading = tbl1.isCartPricingLoading, LayoutOrder = 1 })

    tbl11.PostPurchaseActions = postPurchaseActions
    local createElement5 = React.createElement
    local var17 = View
    local tbl12 = { LayoutOrder = 2, tag = str1 }
    local tbl13

    if fFlagIapExperienceEnableMultiDisplayUpsell then
        tbl13 = {}
        for layoutOrder, upsellSuggestion in ipairs(tbl1.upsellSuggestions) do
            local str6 = "UpsellPackage" .. tostring(layoutOrder)
            local createElement6 = React.createElement
            local func2 = UpsellProductDetails
            local tbl14 = {
                layoutOrder = layoutOrder,
                product = upsellSuggestion,
                selected = tbl1.selectedUpsellIndex == layoutOrder,
                isCompact = isCompact,
                onSelected = 0,
                badgeType = 0
            }

            function tbl14.onSelected()
                onSelected(layoutOrder)
            end
            tbl14.badgeType = upsellSuggestion.badgeType
            tbl13[str6] = createElement6(func2, tbl14)
        end
    else
        tbl13 = {
            UpsellPackage1 = React.createElement(UpsellProductDetails, {
                layoutOrder = 1,
                product = tbl1.upsellSuggestions[1],
                selected = tbl1.selectedUpsellIndex == 1,
                isCompact = isCompact,
                onSelected = function()
                    onSelected(1)
                end
            }),
            UpsellPackage2 = if #tbl1.upsellSuggestions > 1 then React.createElement(UpsellProductDetails, {
                layoutOrder = 2,
                product = tbl1.upsellSuggestions[2],
                selected = tbl1.selectedUpsellIndex == 2,
                isCompact = isCompact,
                onSelected = function()
                    onSelected(2)
                end,
                badgeType = tbl1.upsellSuggestions[2].badgeType
            }) else nil
        }
    end

    tbl11.UpsellSuggestions = createElement5(var17, tbl12, tbl13)
    tbl9.SheetContentContainer = createElement4(var16, tbl10, tbl11)
    tbl5.Content = createElement3(content, tbl8, tbl9)

    local createElement6 = React.createElement
    local actions = Sheet.Actions
    local tbl14 = { LayoutOrder = 3 }

    local createElement7 = React.createElement
    local var18 = View
    local tbl15 = { LayoutOrder = 1, tag = str2 }
    local tbl16 = { BuyAndPlusRow = 0, DisclosureTerms = 0 }
    local element3

    if onRobloxPlusButtonActivated then
        element3 = React.createElement(ButtonGroup, {
            LayoutOrder = 1,
            orientation = EnumsOrientation.Vertical,
            size = size,
            buttons = {
                {
                    text = tbl3.text,
                    onActivated = tbl3.onActivated,
                    inputDelay = tbl3.inputDelay,
                    isDisabled = tbl3.isDisabled,
                    ref = tbl3.ref,
                    variant = tbl3.variant
                },
                {
                    text = var3.GetTenPercentOff,
                    onActivated = onRobloxPlusButtonActivated,
                    isDisabled = isDisabled,
                    variant = ButtonVariant.Standard,
                    icon = Enums.IconName.RobloxPlus
                }
            }
        })
    else
        element3 = React.createElement(Foundation.Button, tbl3)
    end

    tbl16.BuyAndPlusRow = element3

    tbl16.DisclosureTerms = React.createElement(View, { LayoutOrder = 2, tag = str3 }, {
        DisclosurePayment = React.createElement(FoundationText, {
            LayoutOrder = 1,
            Text = var3.DisclosurePayment,
            tag = "auto-xy text-body content-default text-align-x-left content-muted text-caption-small"
        }),
        BeforeText = React.createElement(FoundationText, {
            LayoutOrder = 2,
            Text = tbl2[1],
            tag = "auto-xy text-body content-default text-align-x-left content-muted text-caption-small"
        }),
        TextLink = React.createElement(FoundationText, {
            LayoutOrder = 3,
            RichText = true,
            Text = termsOfUse,
            tag = "auto-xy text-body content-default text-align-x-left content-muted text-caption-small",
            onActivated = tbl1.termsOfUseActivated
        }),
        AfterText = React.createElement(FoundationText, {
            LayoutOrder = 4,
            Text = tbl2[2],
            tag = "auto-xy text-body content-default text-align-x-left content-muted text-caption-small"
        })
    })
    tbl5.Actions = createElement6(actions, tbl14, { createElement7(var18, tbl15, tbl16) })
    return createElement(root, tbl4, tbl5)
end

local function UnifiedRobuxUpsellModalContainer(tbl1)
    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            UnifiedRobuxUpsellModal = React.createElement(UnifiedRobuxUpsellModal, tbl1)
        }
    )
end
return UnifiedRobuxUpsellModalContainer

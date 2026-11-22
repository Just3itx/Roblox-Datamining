-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)
local SharedFlags = require(scriptParentParentParentParent.SharedFlags)

local Foundation = require(scriptParentParentParentParent.Foundation)
local View = Foundation.View
local FoundationText = Foundation.Text
local Checkbox = Foundation.Checkbox
local ButtonVariant = Foundation.Enums.ButtonVariant
local ButtonGroup = Foundation.ButtonGroup
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation
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
local ProductDetailsContainer = require(scriptParentParentParent.Generic.ProductDetailsContainer)
local CartPricingLoading = require(scriptParentParentParent.ProductPurchase.v4.CartPricingLoading)
local buildCartPricingOfferCheckboxes = require(scriptParentParentParent.ProductPurchase.v4.buildCartPricingOfferCheckboxes)
local useCartPricing = require(scriptParentParentParent.ProductPurchase.v4.useCartPricing)

local useFocusNavigationRefs = require(scriptParentParentParent.Generic.Hooks.useFocusNavigationRefs)

local UnifiedPurchaseModalTypeEnum = require(scriptParentParentParent.Enums.UnifiedPurchaseModalTypeEnum)

local _cartPricingResponseLineItem = require(scriptParentParentParent.ProductPurchase.v4.cartPricingResponseLineItem)

local formatNumber = require(scriptParentParentParent.Utility.formatNumber)
local getUpsellBadgeInfo = require(scriptParentParentParent.Utility.getUpsellBadgeInfo)

local FFlagAXMISWithBlackbird = SharedFlags.FFlagAXMISWithBlackbird

local FFlagEnableRobuxUpsellPlusButtonExperiment = require(scriptParentParentParent.Flags.FFlagEnableRobuxUpsellPlusButtonExperiment)

local FFlagUnifiedPurchaseFlowMarketplaceUIImprovements = require(scriptParentParentParent.Parent.SharedFlags).FFlagUnifiedPurchaseFlowMarketplaceUIImprovements
local num1 = game:DefineFastInt("CompactUpsellModalBreakpoint", 400)

local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(scriptParentParentParent.Parent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs
local FFlagShouldFixDevSubsFlashingTitle = require(scriptParentParentParent.Flags.FFlagShouldFixDevSubsFlashingTitle)

local GetFFlagIAPExperienceEnableMultiDisplayUpsell = require(scriptParentParentParent.Flags.GetFFlagIAPExperienceEnableMultiDisplayUpsell)

local GetFFlagIAPExperienceUseUpsellBadgeHelper = require(scriptParentParentParent.Flags.GetFFlagIAPExperienceUseUpsellBadgeHelper)

local _GetUpsellSuggestionsTypes = require(scriptParentParentParent.Api.PaymentsGateway.GetUpsellSuggestionsTypes)
local BadgeType = require(scriptParentParentParent.Enums.BadgeType)
local _VirtualItemBadgeType = require(scriptParentParentParent.Enums.VirtualItemBadgeType)
local _UnifiedProductPurchaseModalTypes = require(scriptParentParentParent.ProductPurchase.v3.UnifiedProductPurchaseModalTypes)

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
        LeftSide = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "row gap-small align-y-center align-x-start",
                Size = UDim2.new(0.5, 0, 1, 0)
            },
            {
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
            }
        ),
        RightSide = React.createElement(
            View,
            {
                LayoutOrder = 2,
                tag = "row align-y-center align-x-right gap-large",
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
        LeftSide = React.createElement(
            View,
            {
                LayoutOrder = 1,
                tag = "row gap-small align-y-center align-x-start",
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
                tag = "row align-y-center align-x-right gap-large",
                Size = UDim2.new(0.5, 0, 1, 0)
            },
            {
                RobuxPrice = React.createElement(FoundationText, { LayoutOrder = 2, Text = tbl1.product.price or "", tag = str4 })
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
        return UpsellProductDetailsMultiDisplayImpl(tbl1, var1)
    end
    return UpsellProductDetailsLegacyImpl(tbl1, var1)
end

local function UnifiedRobuxUpsellModalV2(tbl1)
    local robloxPlusDiscountPercentage = if FFlagEnableRobuxUpsellPlusButtonExperiment and type(tbl1.robloxPlusDiscountPercentage) == "number" then tbl1.robloxPlusDiscountPercentage else nil
    local onRobloxPlusButtonActivated = if robloxPlusDiscountPercentage == nil then nil else tbl1.onRobloxPlusButtonActivated
    local cartPricing = useCartPricing({
        product = tbl1.product,
        purchaseModalType = tbl1.purchaseModalType,
        cartPricingResponse = tbl1.cartPricingResponse,
        onCartOfferAppliedChanged = tbl1.onCartOfferAppliedChanged
    })

    local var2, var3 = React.useState(tbl1.postPurchaseActions or {})

    local onActivated = React.useCallback(function()
        if var2 and tbl1.setPostPurchaseActions then
            tbl1.setPostPurchaseActions(var2)
        end

        tbl1.buttons.buyItemActivated()
    end, { tbl1.buttons.buyItemActivated, tbl1.setPostPurchaseActions, var2 })

    local product = React.useMemo(function()
        return if cartPricing.showCartOfferUi then cartPricing.mergedProductForDetails else tbl1.product
    end, { tbl1.product, cartPricing.showCartOfferUi, cartPricing.mergedProductForDetails })

    local var6 = useLocalization({
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
        PerMonth = if FFlagEnableUnifiedPurchaseFlowForDevSubs then "Feature.Subscription.Text.PerMonth" else nil
    })
    local isCompact = if FFlagEnableUnifiedPurchaseFlowForDevSubs
        and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription then tbl1.screenSize.Y > 0 and tbl1.screenSize.Y < num1 else tbl1.screenSize.Y < num1
    local text, var8 = React.useState(var6.BuyRobuxAndItem)
    React.useEffect(function()
        local purchaseModalType = tbl1.purchaseModalType

        if FFlagEnableUnifiedPurchaseFlowForDevSubs and purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription then
            local buyRobuxAndItem = var6.BuyRobuxAndItem

            if FFlagShouldFixDevSubsFlashingTitle and var6.BuyRobuxAndSubscription and var6.BuyRobuxAndSubscription ~= "" then
                buyRobuxAndItem = var6.BuyRobuxAndSubscription
            end
            var8(buyRobuxAndItem)
            return
        end

        if purchaseModalType ~= UnifiedPurchaseModalTypeEnum.MultiItem then
            if purchaseModalType == UnifiedPurchaseModalTypeEnum.Experience then
                var8(var6.BuyRobuxAndExperience)
            else
                var8(var6.BuyRobuxAndItem)
            end

            return
        end

        if FFlagAXMISWithBlackbird then
            if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements and tbl1.product.itemName ~= "RobuxUpsell" then
                var8(var6.BuyRobuxAndAvatar)
                return
            end
            var8(var6.BuyRobuxOnly)
        elseif FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then
            var8(var6.BuyRobuxAndAvatar)
        else
            var8(var6.BuyRobuxAndItems)
        end
    end, {
        tbl1.purchaseModalType,
        var6.BuyRobuxAndAvatar,
        var6.BuyRobuxAndExperience,
        var6.BuyRobuxAndItem,
        var6.BuyRobuxAndItems,
        var6.BuyRobuxAndSubscription,
        if FFlagAXMISWithBlackbird then tbl1.product.itemName else nil,
        if FFlagAXMISWithBlackbird then var6.BuyRobuxOnly else nil
    })

    local ref, var1 = useFocusNavigationRefs(tbl1.buttons.cancelPurchaseActivated, tbl1.onBuyItemButtonMounted)

    React.useEffect(function() end, { tbl1.upsellSuggestions })

    local function onSelected(num2: number) -- Luacid: Inlined by compiler; 3 call sites recovered
        tbl1.onUpsellSuggestionsSelected(num2)
    end

    local tbl2 = string.split(var6.DisclosureTermsURL, " {termsofuse} ")
    local termsOfUse = var6.TermsOfUse
    if tbl1.termsOfUseActivated then
        termsOfUse = "<u>" .. termsOfUse .. "</u>"
    end

    local var11 = FFlagEnableUnifiedPurchaseFlowForDevSubs
        and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription
    local perMonth = if var11 then var6.PerMonth else nil
    local var4 = if var11 then var6.Subscribe else var6.Buy
    local isDisabled = tbl1.buttons.buyItemDisabled == true or tbl1.isCartPricingLoading == true

    local cartPricingOfferCheckboxes = buildCartPricingOfferCheckboxes({ cartPricing = cartPricing, isDisabled = isDisabled })

    local tbl3 = {
        text = var4,
        variant = ButtonVariant.Emphasis,
        onActivated = onActivated,
        isDisabled = isDisabled,
        ref = var1,
        inputDelay = tbl1.buttons.buyItemEnableInputDelayed and (if isDisabled then 0 else 2.5) or 0
    }
    local actions = { tbl3 }

    local cartPricingOffersLen = cartPricing.showCartOfferUi and #cartPricing.cartPricingOffers or 0

    local var13 = React.useMemo(function()
        local result = ({})
        for value, value2 in var2 do
            local actionKey = value2.actionKey
            local createElement = React.createElement
            local var13 = Checkbox
            local tbl5 = {
                LayoutOrder = cartPricingOffersLen + value,
                size = "XSmall",
                label = value2.label,
                isChecked = value2.isActionSelected,
                isDisabled = isDisabled,
                onActivated = 0
            }

            function tbl5.onActivated()
                var3(function(arg1)
                    local var14 = table.clone(arg1)
                    var14[value] = {
                        label = value2.label,
                        isActionSelected = not value2.isActionSelected,
                        actionKey = value2.actionKey
                    }
                    return var14
                end)
            end

            result[actionKey] = createElement(var13, tbl5)
        end

        return result
    end, { var2, isDisabled, cartPricingOffersLen })

    local var14 = table.clone(cartPricingOfferCheckboxes)
    for k, value in pairs(var13) do
        var14[k] = value
    end

    local postPurchaseActions = if next(var14) then React.createElement(View, { tag = "col gap-medium size-full-0 auto-y", LayoutOrder = 3 }, var14) else nil
    local cartPricingSavingsSummary = cartPricing.cartPricingSavingsSummary
    if tbl1.product.itemPrice and tbl1.product.itemPrice.savingsSummaryOverride then
        cartPricingSavingsSummary = tbl1.product.itemPrice.savingsSummaryOverride
    end

    local element2 = React.createElement(ProductDetailsContainer, {
        purchaseModalType = tbl1.purchaseModalType,
        product = product,
        isCompact = isCompact,
        model = product.model,
        priceSuffix = perMonth,
        hideProductDetails = tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.MultiItem,
        hideDiscountSummary = tbl1.isCartPricingLoading,
        savingsSummary = cartPricingSavingsSummary
    })

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl5 = {
        size = DialogSize.Medium,
        onClose = tbl1.buttons.cancelPurchaseActivated,
        ref = ref,
        disablePortal = false
    }
    local tbl6 = {
        DialogTitle = React.createElement(Dialog.Title, { text = text }),
        DialogContent = 0,
        DialogActions = 0,
        DisclosureTerms = 0
    }
    local createElement2 = React.createElement
    local content = Dialog.Content
    local var15 = nil
    local tbl7 = { ContentView = 0 }
    local createElement3 = React.createElement
    local var16 = View
    local tbl8 = { tag = "col align-x-center align-y-top gap-medium size-full-0 auto-y" }

    local tbl9 = {
        ProductDetailsContainer = 0,
        CartPricingLoading = 0,
        PostPurchaseActions = 0,
        UpsellSuggestions = 0
    }

    if not element2 then
        local createElement4 = React.createElement
        local var17 = View
        local tbl10 = {
            tag = "col align-x-center align-y-center gap-medium size-full-0",
            LayoutOrder = 1
        }

        local tbl11 = { ProductDetails = 0 }
        local element3

        if tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.MultiItem then
            element3 = React.createElement(PriceSummary, { amount = product.itemRobuxCost, itemPrice = product.itemPrice })
        else
            element3 = React.createElement(UnifiedProductDetails, {
                isPortrait = false,
                isCompact = isCompact,
                itemIcon = product.itemIcon,
                itemName = product.itemName,
                itemRobuxCost = product.itemRobuxCost,
                itemPrice = product.itemPrice,
                model = product.model,
                priceSuffix = perMonth
            })
        end

        tbl11.ProductDetails = element3
        element2 = createElement4(var17, tbl10, tbl11)
    end

    tbl9.ProductDetailsContainer = element2

    tbl9.CartPricingLoading = React.createElement(CartPricingLoading, { isLoading = tbl1.isCartPricingLoading })

    tbl9.PostPurchaseActions = postPurchaseActions
    local createElement4 = React.createElement
    local var17 = View
    local tbl10 = {
        LayoutOrder = 3,
        tag = "col align-x-center align-y-center gap-medium size-full-0 auto-y padding-x-xsmall padding-bottom-xxlarge padding-top-small"
    }
    local tbl11

    if GetFFlagIAPExperienceEnableMultiDisplayUpsell() then
        tbl11 = {}
        for layoutOrder, upsellSuggestion in ipairs(tbl1.upsellSuggestions) do
            local str1 = "UpsellPackage" .. tostring(layoutOrder)
            local createElement5 = React.createElement
            local func2 = UpsellProductDetails
            local tbl12 = {
                layoutOrder = layoutOrder,
                product = upsellSuggestion,
                selected = tbl1.selectedUpsellIndex == layoutOrder,
                isCompact = isCompact,
                onSelected = 0,
                badgeType = 0
            }

            function tbl12.onSelected()
                onSelected(layoutOrder)
            end
            tbl12.badgeType = upsellSuggestion.badgeType
            tbl11[str1] = createElement5(func2, tbl12)
        end
    else
        tbl11 = {
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

    tbl9.UpsellSuggestions = createElement4(var17, tbl10, tbl11)
    tbl7.ContentView = createElement3(var16, tbl8, tbl9)
    tbl6.DialogContent = createElement2(content, var15, tbl7)
    local element3

    if onRobloxPlusButtonActivated then
        element3 = React.createElement(ButtonGroup, {
            LayoutOrder = 4,
            orientation = EnumsOrientation.Vertical,
            buttons = {
                tbl3,
                {
                    text = var6.GetTenPercentOff,
                    variant = ButtonVariant.Standard,
                    onActivated = onRobloxPlusButtonActivated,
                    isDisabled = tbl3.isDisabled,
                    icon = Enums.IconName.RobloxPlus
                }
            }
        })
    else
        element3 = React.createElement(Dialog.Actions, { LayoutOrder = 4, orientation = EnumsOrientation.Horizontal, actions = actions })
    end

    tbl6.DialogActions = element3

    tbl6.DisclosureTerms = React.createElement(
        View,
        {
            LayoutOrder = 5,
            tag = "row wrap align-x-center align-y-center gap-xxsmall size-full-0 auto-y"
        },
        {
            DisclosurePayment = React.createElement(FoundationText, {
                LayoutOrder = 1,
                Text = var6.DisclosurePayment,
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
        }
    )
    return createElement(root, tbl5, tbl6)
end

local function UnifiedRobuxUpsellModalV2Container(tbl1)
    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            UnifiedRobuxUpsellModalV2 = React.createElement(UnifiedRobuxUpsellModalV2, tbl1)
        }
    )
end
return UnifiedRobuxUpsellModalV2Container

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:11:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)

local Foundation = require(scriptParentParentParentParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local Checkbox = Foundation.Checkbox
local Sheet = Foundation.Sheet
local Button = Foundation.Button
local View = Foundation.View
local FoundationText = Foundation.Text
local FillBehavior = Foundation.Enums.FillBehavior

local UnifiedProductDetails = require(scriptParentParentParent.Generic.UnifiedProductDetails)
local PriceSummary = require(scriptParentParentParent.Generic.PriceSummary)
local UnifiedPurchaseModalHeader = require(scriptParentParentParent.Generic.UnifiedPurchaseModalHeader)
local _ProductDetailsContainer = require(scriptParentParentParent.Generic.ProductDetailsContainer)

local useCartPricing = require(scriptParentParentParent.ProductPurchase.v4.useCartPricing)
local buildCartPricingOfferCheckboxes = require(scriptParentParentParent.ProductPurchase.v4.buildCartPricingOfferCheckboxes)
local _cartPricingResponseLineItem = require(scriptParentParentParent.ProductPurchase.v4.cartPricingResponseLineItem)
local CartPricingProductDetails = require(scriptParentParentParent.ProductPurchase.v4.CartPricingProductDetails)

local UrlBuilder = require(scriptParentParentParentParent.UrlBuilder).UrlBuilder

local useInitialButtonDisableDelay = require(scriptParentParentParent.Generic.Hooks.useInitialButtonDisableDelay)
local useFocusNavigationRefs = require(scriptParentParentParent.Generic.Hooks.useFocusNavigationRefs)

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParentParentParentParent.AppLocales).Localization
local Localization2 = require(scriptParentParentParentParent.Localization)
local LocalizationProvider = Localization2.LocalizationProvider
local useLocalization = Localization2.Hooks.useLocalization

local _UnifiedProductPurchaseModalTypes = require(script.Parent.UnifiedProductPurchaseModalTypes)
local UnifiedPurchaseModalTypeEnum = require(scriptParentParentParent.Enums.UnifiedPurchaseModalTypeEnum)

local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(scriptParentParentParent.Parent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs

local FFlagUnifiedPurchaseFlowMarketplaceUIImprovements = require(scriptParentParentParent.Parent.SharedFlags).FFlagUnifiedPurchaseFlowMarketplaceUIImprovements
local FFlagOffersOnlyAffordableLock = require(scriptParentParentParent.Parent.SharedFlags).FFlagOffersOnlyAffordableLock

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(scriptParentParentParent.Parent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local _PricingTypes = require(scriptParentParentParent.ProductPurchase.PricingTypes)

local BlackbirdUpsellBanner = require(scriptParentParentParentParent.RobloxSubscriptionPurchaseApp).Components.BlackbirdUpsellBanner

local function UnifiedProductPurchaseModal(tbl1)
    local var1 = useLocalization({
        Buy = "IAPExperience.PurchasePrompt.Action.Buy",
        Subscribe = "Feature.Subscription.Action.Subscribe",
        BuyItem = "IAPExperience.PurchasePrompt.Title.BuyItem",
        BuyItemV2 = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then "IAPExperience.PurchasePrompt.Title.BuyItemV2" else nil,
        GetSubscription = "IAPExperience.SubscriptionPurchasePrompt.Label.GetSubscription",
        BuyExperience = "IAPExperience.PurchasePrompt.Title.BuyExperience",
        BuyItems = "IAPExperience.PurchasePrompt.Title.BuyItems",
        BuyAvatar = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then "IAPExperience.PurchasePrompt.Header.BuyAvatar" else nil,
        TestPurchaseDisclaimer = "IAPExperience.PurchasePrompt.Text.TestPurchase",
        PerMonth = if FFlagEnableUnifiedPurchaseFlowForDevSubs then "Feature.Subscription.Text.PerMonth" elseif FFlagLuaAppsEnablePromptVIPServerPurchase then "Feature.Subscription.Text.PerMonth" else nil,
        Free = if FFlagLuaAppsEnablePromptVIPServerPurchase then "Feature.Catalog.LabelFree" else nil,
        FreeWithPlus = if FFlagLuaAppsEnablePromptVIPServerPurchase then "Feature.PrivateServers.Action.FreeWithBlackbird" else nil,
        CreatePrivateServer = if FFlagLuaAppsEnablePromptVIPServerPurchase then "Feature.PrivateServers.Action.CreatePrivateServer" else nil,
        SubscribeTermsAgreement = FFlagEnableUnifiedPurchaseFlowForDevSubs
            and {
                "Feature.Subscription.Footer.PurchasePromptLegalText",
                SubscribeButtonTitle = "\"Subscribe\"",
                tosUrl = UrlBuilder.static.about.terms()
            }
            or nil
    })
    local perMonth = if FFlagEnableUnifiedPurchaseFlowForDevSubs
        and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription then var1.PerMonth elseif FFlagLuaAppsEnablePromptVIPServerPurchase and tbl1.isMonthlyPrice then var1.PerMonth else nil
    local var2, var3 = React.useState(tbl1.postPurchaseActions or {})
    local titleText, var5 = React.useState(var1.BuyItem)

    local var6 = useInitialButtonDisableDelay(tbl1.buttons.isDisabled)

    local cartPricing = useCartPricing({
        product = tbl1.product,
        purchaseModalType = tbl1.purchaseModalType,
        cartPricingResponse = tbl1.cartPricingResponse,
        onCartOfferAppliedChanged = tbl1.onCartOfferAppliedChanged
    })

    local isDisabled = tbl1.buttons.isDisabled or tbl1.isCartPricingLoading == true or var6 == true

    local priceWithoutOffersDiscounts = cartPricing.priceWithoutOffersDiscounts
    local priceAfterOffersDiscounts = cartPricing.priceAfterOffersDiscounts
    local bool1 = not (priceWithoutOffersDiscounts == nil) and tbl1.robuxBalanceAmount < priceWithoutOffersDiscounts
    local bool2 = not (priceAfterOffersDiscounts == nil) and priceAfterOffersDiscounts <= tbl1.robuxBalanceAmount
    local var4 = isDisabled or bool1 and (not FFlagOffersOnlyAffordableLock or bool2)

    local cartPricingOffersLen = cartPricing.showCartOfferUi and #cartPricing.cartPricingOffers or 0

    React.useEffect(function()
        local purchaseModalType = tbl1.purchaseModalType

        if FFlagEnableUnifiedPurchaseFlowForDevSubs and purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription then
            var5(var1.GetSubscription)
            return
        end

        if purchaseModalType == UnifiedPurchaseModalTypeEnum.MultiItem then
            if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then
                var5(var1.BuyAvatar)
                return
            end
            var5(var1.BuyItems)
            return
        end
        if purchaseModalType == UnifiedPurchaseModalTypeEnum.Experience then
            var5(var1.BuyExperience)
        elseif FFlagLuaAppsEnablePromptVIPServerPurchase and purchaseModalType == UnifiedPurchaseModalTypeEnum.VIPServer then
            var5(var1.CreatePrivateServer)
        elseif FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then
            var5(var1.BuyItemV2)
        else
            var5(var1.BuyItem)
        end
    end, { tbl1.purchaseModalType })

    local var10, ref = useFocusNavigationRefs(tbl1.buttons.cancelActivated, tbl1.onBuyItemButtonMounted)

    local onActivated = React.useCallback(function()
        if var2 and tbl1.setPostPurchaseActions then
            tbl1.setPostPurchaseActions(var2)
        end

        tbl1.buttons.buyItemActivated()
    end, { tbl1.buttons.buyItemActivated, var2 })

    React.useEffect(function()
        var3(tbl1.postPurchaseActions or {})
    end, { tbl1.postPurchaseActions })

    local text = if FFlagEnableUnifiedPurchaseFlowForDevSubs
        and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription then var1.Subscribe else var1.Buy

    local var14 = React.useMemo(function()
        local result = ({})
        for value, value2 in var2 do
            local actionKey = value2.actionKey
            local createElement = React.createElement
            local var14 = Checkbox
            local tbl2 = {
                LayoutOrder = cartPricingOffersLen + value,
                size = "XSmall",
                label = value2.label,
                isChecked = value2.isActionSelected,
                isDisabled = isDisabled,
                onActivated = 0
            }

            function tbl2.onActivated()
                var3(function(arg1)
                    local var15 = table.clone(arg1)
                    var15[value] = {
                        label = value2.label,
                        isActionSelected = not value2.isActionSelected,
                        actionKey = value2.actionKey
                    }
                    return var15
                end)
            end

            result[actionKey] = createElement(var14, tbl2)
        end

        return result
    end, { var2, cartPricingOffersLen, isDisabled })

    local cartPricingOfferCheckboxes = buildCartPricingOfferCheckboxes({ cartPricing = cartPricing, isDisabled = var4 })

    local var15 = table.clone(cartPricingOfferCheckboxes)
    for k, value in pairs(var14) do
        var15[k] = value
    end

    local postPurchaseActions = React.createElement(
        View,
        { tag = "col gap-medium auto-y size-full-0 align-x-start align-y-start", LayoutOrder = 2 },
        var15
    )

    local itemPrice = tbl1.product.itemPrice
    local var16 = if itemPrice then itemPrice.priceInRobux else tbl1.product.itemRobuxCost
    local var17 = if FFlagLuaAppsEnablePromptVIPServerPurchase and var16 == 0 then if tbl1.isFreeWithRobloxPlus then var1.FreeWithPlus elseif tbl1.isMonthlyPrice then var1.Free else nil else nil
    local element2

    if FFlagEnableUnifiedPurchaseFlowForDevSubs
        and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription
    then
        local var18 = string.gsub(var1.SubscribeTermsAgreement or "", "<a.->(.-)</a>", "%1")
        local var19 = string.gsub(var18, "<.->", "")
        element2 = React.createElement(
            FoundationText,
            {
                LayoutOrder = 4,
                Text = var19,
                tag = "wrap size-full-0 auto-y text-caption-small text-wrap text-align-x-left"
            }
        )
    else
        element2 = nil
    end

    local createElement = React.createElement
    local var18 = CartPricingProductDetails
    local tbl2 = {
        cartPricing = cartPricing,
        purchaseModalType = tbl1.purchaseModalType,
        priceSuffix = perMonth,
        priceText = 0,
        includePriceSuffixOnOriginal = 0,
        isCartPricingLoading = 0
    }

    if not FFlagLuaAppsEnablePromptVIPServerPurchase then
        var17 = nil
    end

    tbl2.priceText = var17
    tbl2.includePriceSuffixOnOriginal = if FFlagLuaAppsEnablePromptVIPServerPurchase then tbl1.isMonthlyPrice else nil
    tbl2.isCartPricingLoading = tbl1.isCartPricingLoading
    local element3 = createElement(var18, tbl2)

    local createElement2 = React.createElement
    local root = Sheet.Root
    local tbl3 = {
        onClose = tbl1.buttons.cancelActivated,
        preferCenterSheet = true,
        ref = 0
    }
    if var6 then
        var10 = nil
    end

    tbl3.ref = var10
    local tbl4 = { Header = 0, Content = 0, Actions = 0 }
    local createElement3 = React.createElement
    local header = Sheet.Header
    local tbl5 = {
        hasCloseAffordance = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then if tbl1.hideUserRobuxBalance then true else nil else nil
    }

    local tbl6 = {
        ModalHeader = React.createElement(UnifiedPurchaseModalHeader, {
            titleText = titleText,
            robuxBalanceAmount = tbl1.robuxBalanceAmount,
            hideUserRobuxBalance = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then tbl1.hideUserRobuxBalance else nil
        })
    }
    tbl4.Header = createElement3(header, tbl5, tbl6)

    local createElement4 = React.createElement
    local content = Sheet.Content
    local tbl7 = { LayoutOrder = 2 }

    local tbl8 = { SheetContentContainer = 0 }
    local createElement5 = React.createElement
    local var19 = View
    local tbl9 = { tag = "col gap-medium auto-y size-full-0 align-x-center align-y-center" }

    local tbl10 = { ProductDetailsContainer = 0, PostPurchaseActions = 0 }
    if not element3 then
        local createElement6 = React.createElement
        local var20 = View
        local tbl11 = {
            tag = "col gap-medium auto-y size-full-0 align-x-center align-y-center",
            LayoutOrder = 1
        }

        local tbl12 = { ProductDetails = 0 }
        local element4

        if tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.MultiItem then
            element4 = React.createElement(PriceSummary, { amount = var16, itemPrice = itemPrice })
        else
            element4 = React.createElement(UnifiedProductDetails, {
                isPortrait = false,
                itemIcon = tbl1.product.itemIcon,
                itemName = tbl1.product.itemName,
                itemRobuxCost = var16,
                itemPrice = itemPrice,
                itemDisplayPrice = if FFlagEnableUnifiedPurchaseFlowForDevSubs then tbl1.product.itemDisplayPrice else nil,
                priceSuffix = perMonth,
                model = tbl1.product.model
            })
        end

        tbl12.ProductDetails = element4
        element3 = createElement6(var20, tbl11, tbl12)
    end

    tbl10.ProductDetailsContainer = element3

    tbl10.PostPurchaseActions = postPurchaseActions
    tbl8.SheetContentContainer = createElement5(var19, tbl9, tbl10)
    tbl4.Content = createElement4(content, tbl7, tbl8)

    local createElement6 = React.createElement
    local actions = Sheet.Actions
    local tbl11 = { LayoutOrder = 3 }

    local createElement7 = React.createElement
    local var20 = View
    local tbl12 = {
        tag = "row wrap auto-xy align-y-center align-x-center size-full-0 gap-medium",
        LayoutOrder = 1
    }

    local tbl13 = {
        BuyButton = React.createElement(Button, {
            text = text,
            onActivated = onActivated,
            inputDelay = tbl1.buttons.buyItemEnableInputDelayed and (if var6 then 0 else 2.5) or 0,
            isDisabled = isDisabled,
            ref = ref,
            fillBehavior = FillBehavior.Fill,
            variant = ButtonVariant.Emphasis,
            LayoutOrder = 1
        }),
        BlackbirdUpsellBanner = 0,
        TestPurchaseDisclaimer = 0,
        SubscribeTerms = 0
    }
    local element4

    if tbl1.BlackbirdUpsellBannerProductInfo and tbl1.onBlackbirdUpsellActivated then
        element4 = React.createElement(BlackbirdUpsellBanner, {
            productInfo = tbl1.BlackbirdUpsellBannerProductInfo,
            onActivated = tbl1.onBlackbirdUpsellActivated,
            bannerText = if FFlagLuaAppsEnablePromptVIPServerPurchase and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.VIPServer then var1.FreeWithPlus else nil,
            LayoutOrder = 2
        })
    else
        element4 = nil
    end

    tbl13.BlackbirdUpsellBanner = element4

    tbl13.TestPurchaseDisclaimer = if tbl1.isTestPurchase then React.createElement(FoundationText, {
        Text = var1.TestPurchaseDisclaimer,
        tag = "auto-y size-full-0 text-caption-small text-align-x-center text-wrap wrap",
        LayoutOrder = 3
    }) else nil

    tbl13.SubscribeTerms = element2
    tbl4.Actions = createElement6(actions, tbl11, { createElement7(var20, tbl12, tbl13) })
    return createElement2(root, tbl3, tbl4)
end

local function UnifiedProductPurchaseModalContainer(tbl1)
    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            ProductPurchaseModal = React.createElement(UnifiedProductPurchaseModal, tbl1)
        }
    )
end
return UnifiedProductPurchaseModalContainer

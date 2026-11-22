-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local React = require(scriptParentParentParentParent.React)

local BlackbirdUpsellBanner = require(scriptParentParentParentParent.RobloxSubscriptionPurchaseApp).Components.BlackbirdUpsellBanner

local Foundation = require(scriptParentParentParentParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local Dialog = Foundation.Dialog
local Checkbox = Foundation.Checkbox
local View = Foundation.View
local DialogSize = Foundation.Enums.DialogSize

local _ProductDetailsContainer = require(scriptParentParentParent.Generic.ProductDetailsContainer)
local CartPricingProductDetails = require(script.Parent.CartPricingProductDetails)
local buildCartPricingOfferCheckboxes = require(script.Parent.buildCartPricingOfferCheckboxes)
local useCartPricing = require(script.Parent.useCartPricing)

local useFocusNavigationRefs = require(scriptParentParentParent.Generic.Hooks.useFocusNavigationRefs)

local LocalizationService = game:GetService("LocalizationService")
local Localization = require(scriptParentParentParentParent.AppLocales).Localization
local Localization2 = require(scriptParentParentParentParent.Localization)
local LocalizationProvider = Localization2.LocalizationProvider
local useLocalization = Localization2.Hooks.useLocalization

local UrlBuilder = require(scriptParentParentParentParent.UrlBuilder).UrlBuilder

local SubtitleComponentMap = require(script.Parent.SubtitleComponentMap)

local _UnifiedProductPurchaseModalTypes = require(script.Parent.Parent.v3.UnifiedProductPurchaseModalTypes)
local UnifiedPurchaseModalTypeEnum = require(scriptParentParentParent.Enums.UnifiedPurchaseModalTypeEnum)

local FFlagUnifiedPurchaseFlowMarketplaceUIImprovements = require(scriptParentParentParent.Parent.SharedFlags).FFlagUnifiedPurchaseFlowMarketplaceUIImprovements
local FFlagUnifiedPurchaseAddSkeleton = require(scriptParentParentParent.Parent.SharedFlags).FFlagUnifiedPurchaseAddSkeleton

local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(scriptParentParentParent.Parent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs

local FFlagOffersOnlyAffordableLock = require(scriptParentParentParent.Parent.SharedFlags).FFlagOffersOnlyAffordableLock

local _cartPricingResponseLineItem = require(script.Parent.cartPricingResponseLineItem)

local function UnifiedProductPurchaseModalV2(tbl1)
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
        PerMonth = if FFlagEnableUnifiedPurchaseFlowForDevSubs then "Feature.Subscription.Text.PerMonth" else nil,
        SubscribeTermsAgreement = FFlagEnableUnifiedPurchaseFlowForDevSubs
            and {
                "Feature.Subscription.Footer.PurchasePromptLegalText",
                SubscribeButtonTitle = "\"Subscribe\"",
                tosUrl = UrlBuilder.static.about.terms()
            }
            or nil
    })
    local perMonth = if FFlagEnableUnifiedPurchaseFlowForDevSubs
        and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription then var1.PerMonth else nil
    local cartPricing = useCartPricing({
        product = tbl1.product,
        purchaseModalType = tbl1.purchaseModalType,
        cartPricingResponse = tbl1.cartPricingResponse,
        onCartOfferAppliedChanged = tbl1.onCartOfferAppliedChanged
    })

    local var3, var4 = React.useState(tbl1.postPurchaseActions or {})

    local purchaseModalType = tbl1.purchaseModalType
    local text = if FFlagEnableUnifiedPurchaseFlowForDevSubs and purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription then var1.GetSubscription elseif purchaseModalType == UnifiedPurchaseModalTypeEnum.MultiItem then var1.BuyAvatar elseif purchaseModalType == UnifiedPurchaseModalTypeEnum.Experience then var1.BuyExperience else var1.BuyItemV2
    local ref, var2 = useFocusNavigationRefs(tbl1.buttons.cancelActivated, tbl1.onBuyItemButtonMounted)

    local onActivated = React.useCallback(function()
        if var3 and tbl1.setPostPurchaseActions then
            tbl1.setPostPurchaseActions(var3)
        end

        tbl1.buttons.buyItemActivated()
    end, { tbl1.buttons.buyItemActivated, var3 })

    React.useEffect(function()
        var4(tbl1.postPurchaseActions or {})
    end, { tbl1.postPurchaseActions })

    local isDisabled = tbl1.buttons.isDisabled
        or tbl1.isCartPricingLoading == true
        or FFlagUnifiedPurchaseAddSkeleton and tbl1.isLoading == true

    local priceWithoutOffersDiscounts = cartPricing.priceWithoutOffersDiscounts
    local priceAfterOffersDiscounts = cartPricing.priceAfterOffersDiscounts
    local bool1 = not (priceWithoutOffersDiscounts == nil) and tbl1.robuxBalanceAmount < priceWithoutOffersDiscounts
    local bool2 = not (priceAfterOffersDiscounts == nil) and priceAfterOffersDiscounts <= tbl1.robuxBalanceAmount
    local var5 = isDisabled or bool1 and (not FFlagOffersOnlyAffordableLock or bool2)

    local cartPricingOffersLen = cartPricing.showCartOfferUi and #cartPricing.cartPricingOffers or 0

    local var11 = React.useMemo(function()
        local result = ({})
        for value, value2 in var3 do
            local actionKey = value2.actionKey
            local createElement = React.createElement
            local var11 = Checkbox
            local tbl2 = {
                LayoutOrder = cartPricingOffersLen + value,
                size = "XSmall",
                label = value2.label,
                isChecked = value2.isActionSelected,
                isDisabled = isDisabled,
                onActivated = 0
            }

            function tbl2.onActivated()
                var4(function(arg1)
                    local var12 = table.clone(arg1)
                    var12[value] = {
                        label = value2.label,
                        isActionSelected = not value2.isActionSelected,
                        actionKey = value2.actionKey
                    }
                    return var12
                end)
            end

            result[actionKey] = createElement(var11, tbl2)
        end

        return result
    end, { var3, cartPricingOffersLen, isDisabled })

    local element = nil
    if tbl1.subtitleView then
        local var12 = SubtitleComponentMap[tbl1.subtitleView.componentName]
        if var12 then
            element = React.createElement(var12, tbl1.subtitleView.props)
        end
    end

    local productDetailsContainer = React.createElement(CartPricingProductDetails, {
        cartPricing = cartPricing,
        purchaseModalType = tbl1.purchaseModalType,
        subtitleView = element,
        priceSuffix = perMonth,
        isLoading = tbl1.isLoading,
        isCartPricingLoading = tbl1.isCartPricingLoading
    })

    local cartPricingOfferCheckboxes = buildCartPricingOfferCheckboxes({ cartPricing = cartPricing, isDisabled = var5 })

    local var12 = table.clone(cartPricingOfferCheckboxes)
    for k, value in pairs(var11) do
        var12[k] = value
    end

    local postPurchaseActions = if next(cartPricingOfferCheckboxes) or next(var11) then React.createElement(
        View,
        { tag = "col gap-medium auto-y size-full-0 align-x-start align-y-start", LayoutOrder = 1 },
        var12
    ) else nil
    local actions = {{
        text = if FFlagEnableUnifiedPurchaseFlowForDevSubs
            and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription then var1.Subscribe else var1.Buy,
        variant = ButtonVariant.Emphasis,
        onActivated = onActivated,
        isDisabled = isDisabled,
        ref = var2,
        inputDelay = if tbl1.buttons.buyItemEnableInputDelayed then if tbl1.buttons.isDisabled then 0 else 2.5 else 0
    }}
    local element4

    if FFlagEnableUnifiedPurchaseFlowForDevSubs
        and tbl1.purchaseModalType == UnifiedPurchaseModalTypeEnum.DeveloperSubscription
    then
        local var13 = string.gsub(var1.SubscribeTermsAgreement or "", "<a.->(.-)</a>", "%1")
        local var14 = string.gsub(var13, "<.->", "")
        element4 = React.createElement(
            Foundation.Text,
            {
                LayoutOrder = 6,
                Text = var14,
                tag = "wrap size-full-0 auto-y text-caption-small text-wrap text-align-x-left"
            }
        )
    else
        element4 = nil
    end

    local createElement = React.createElement
    local root = Dialog.Root
    local tbl3 = {
        size = DialogSize.Medium,
        onClose = tbl1.buttons.cancelActivated,
        ref = ref,
        disablePortal = false
    }
    local tbl4 = {
        DialogTitle = React.createElement(Dialog.Title, { text = text }),
        DialogContent = React.createElement(
            View,
            {
                tag = "col gap-medium auto-y size-full-0 align-x-center align-y-center",
                LayoutOrder = 1
            },
            { ProductDetailsContainer = productDetailsContainer }
        ),
        ActionsSection = 0,
        TestDisclaimer = 0,
        SubscribeTerms = 0
    }
    local createElement2 = React.createElement
    local var13 = View
    local tbl5 = { tag = "col size-full-0 auto-y gap-xlarge", LayoutOrder = 3 }

    local tbl6 = {
        PostPurchaseActions = postPurchaseActions,
        BuyAndUpsell = React.createElement(View, {
            tag = "col size-full-0 auto-y gap-medium",
            LayoutOrder = 2
        }, {
            DialogActions = React.createElement(
                Dialog.Actions,
                {
                    LayoutOrder = 1,
                    orientation = Foundation.Enums.Orientation.Horizontal,
                    actions = actions
                }
            ),
            BlackbirdUpsellBanner = if tbl1.BlackbirdUpsellBannerProductInfo and tbl1.onBlackbirdUpsellActivated then React.createElement(
                BlackbirdUpsellBanner,
                {
                    productInfo = tbl1.BlackbirdUpsellBannerProductInfo,
                    onActivated = tbl1.onBlackbirdUpsellActivated,
                    LayoutOrder = 2
                }
            ) else nil
        })
    }
    tbl4.ActionsSection = createElement2(var13, tbl5, tbl6)

    tbl4.TestDisclaimer = if tbl1.isTestPurchase then React.createElement(Foundation.Text, {
        LayoutOrder = 5,
        Text = var1.TestPurchaseDisclaimer,
        tag = "auto-y size-full-0 text-caption-small text-align-x-center text-wrap wrap"
    }) else nil

    tbl4.SubscribeTerms = element4
    return createElement(root, tbl3, tbl4)
end

local function UnifiedProductPurchaseModalV2Container(tbl1)
    return React.createElement(
        LocalizationProvider,
        {
            localization = Localization.new(LocalizationService.RobloxLocaleId)
        },
        {
            ProductPurchaseModal = React.createElement(UnifiedProductPurchaseModalV2, tbl1)
        }
    )
end
return UnifiedProductPurchaseModalV2Container

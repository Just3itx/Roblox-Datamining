-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:10Z
-- Luau bytecode version: 14 | Luau type version: 3
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local PurchasePromptDeps = require(PurchasePromptParent.PurchasePromptDeps)
local ToastLite = require(PurchasePromptParent.ToastLite)
local Rodux = PurchasePromptDeps.Rodux

local PromptRequestReducer = require(script.Parent.PromptRequestReducer)
local PurchaseFlowReducer = require(script.Parent.PurchaseFlowReducer)
local ProductInfoReducer = require(script.Parent.ProductInfoReducer)
local NativeUpsellSuggestionsReducer = require(script.Parent.NativeUpsellSuggestionsReducer)
local PromptStateReducer = require(script.Parent.PromptStateReducer)
local PurchaseFlowUUIDReducer = require(script.Parent.PurchaseFlowUUIDReducer)
local PurchaseErrorReducer = require(script.Parent.PurchaseErrorReducer)
local AccountInfoReducer = require(script.Parent.AccountInfoReducer)
local PurchasingStartTimeReducer = require(script.Parent.PurchasingStartTimeReducer)
local HasCompletedPurchaseReducer = require(script.Parent.HasCompletedPurchaseReducer)
local GamepadEnabledReducer = require(script.Parent.GamepadEnabledReducer)
local ABVariationReducer = require(script.Parent.ABVariationReducer)
local WindowStateReducer = require(script.Parent.WindowStateReducer)
local ButtonStateReducer = require(script.Parent.ButtonStateReducer)
local SubscriptionPurchaseInfoReducer = require(script.Parent.SubscriptionPurchaseInfoReducer)
local EconomicRestrictionErrorReducer = require(script.Parent.EconomicRestrictionErrorReducer)
local CurrentToastMessagesReducer = ToastLite.Reducers.CurrentToastMessagesReducer
local PurchaseCallbacksReducer = require(script.Parent.PurchaseCallbacksReducer)
local PostPurchaseActionsReducer = require(script.Parent.PostPurchaseActionsReducer)
local ProductPayloadReducer = require(script.Parent.ProductPayloadReducer)
local UnifiedPurchaseEligibilityReducer = require(script.Parent.UnifiedPurchaseEligibilityReducer)
local PurchaseAnalyticsMetadataReducer = require(script.Parent.PurchaseAnalyticsMetadataReducer)
local PurchaseOptionsReducer = require(script.Parent.PurchaseOptionsReducer)
local RobloxSubscriptionProductsReducer = require(script.Parent.RobloxSubscriptionProductsReducer)
local CartPricingReducer = require(script.Parent.CartPricingReducer)

local GetFFlagEnableToastLiteRender = require(PurchasePrompt.Flags.GetFFlagEnableToastLiteRender)

local FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow = require(PurchasePrompt.Parent.SharedFlags).FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow
local combineReducers = Rodux.combineReducers
local tbl1 = {
    promptRequest = PromptRequestReducer,
    purchaseFlow = PurchaseFlowReducer,
    productInfo = ProductInfoReducer,
    robuxUpsellSuggestions = NativeUpsellSuggestionsReducer,
    promptState = PromptStateReducer,
    purchaseFlowUUID = PurchaseFlowUUIDReducer,
    purchaseError = PurchaseErrorReducer,
    economicRestrictionError = EconomicRestrictionErrorReducer,
    accountInfo = AccountInfoReducer,
    purchasingStartTime = PurchasingStartTimeReducer,
    hasCompletedPurchase = HasCompletedPurchaseReducer,
    gamepadEnabled = GamepadEnabledReducer,
    abVariations = ABVariationReducer,
    windowState = WindowStateReducer,
    buttonState = ButtonStateReducer,
    subscriptionPurchaseInfo = SubscriptionPurchaseInfoReducer,
    currentToastMessages = 0,
    purchaseCallbacks = 0,
    postPurchaseActions = 0,
    productPayload = 0,
    isUserEligibleForUnifiedPurchaseFlow = 0,
    purchaseAnalyticsMetadata = 0,
    purchaseOptions = 0,
    robloxSubscriptionProducts = 0,
    cartPricing = 0
}

if not GetFFlagEnableToastLiteRender() then
    CurrentToastMessagesReducer = nil
end

tbl1.currentToastMessages = CurrentToastMessagesReducer
tbl1.purchaseCallbacks = PurchaseCallbacksReducer
tbl1.postPurchaseActions = PostPurchaseActionsReducer
tbl1.productPayload = ProductPayloadReducer
tbl1.isUserEligibleForUnifiedPurchaseFlow = UnifiedPurchaseEligibilityReducer
tbl1.purchaseAnalyticsMetadata = PurchaseAnalyticsMetadataReducer
if not FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow then
    PurchaseOptionsReducer = nil
end

tbl1.purchaseOptions = PurchaseOptionsReducer
tbl1.robloxSubscriptionProducts = RobloxSubscriptionProductsReducer
tbl1.cartPricing = CartPricingReducer
return (combineReducers(tbl1))

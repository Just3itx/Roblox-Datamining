-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:50:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent

local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local _GetRobloxSubscriptionProductsModel = require(RobloxSubscriptionPurchaseApp.Models.GetRobloxSubscriptionProductsModel)
local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local _types = require(RobloxSubscriptionPurchaseApp.types)
local createPaymentSession = require(RobloxSubscriptionPurchaseApp.Network.createPaymentSession)
local performRobloxSubscriptionPurchase = require(RobloxSubscriptionPurchaseApp.Actions.performRobloxSubscriptionPurchase)
local RobloxSubscriptionHeadlessOverlayController = require(RobloxSubscriptionPurchaseApp.Flows.RobloxSubscriptionHeadlessOverlayController)
local transitionToError = require(RobloxSubscriptionPurchaseApp.Actions.transitionToError)
local ErrorReason = require(RobloxSubscriptionPurchaseApp.Enums.ErrorReason)
local logRobloxSubscriptionUpsellCounter = require(RobloxSubscriptionPurchaseApp.Utils.logRobloxSubscriptionUpsellCounter)
local RobloxSubscriptionUpsellTelemetry = require(RobloxSubscriptionPurchaseApp.Events.RobloxSubscriptionUpsellTelemetry)
local logSubscriptionPurchaseFlowEvent = require(RobloxSubscriptionPurchaseApp.Utils.logSubscriptionPurchaseFlowEvent)

local FFlagEnableSubscriptionPurchaseFlowEventIngest = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnableSubscriptionPurchaseFlowEventIngest)
local UniversalAppPolicy = require(RobloxSubscriptionPurchaseAppParent.UniversalAppPolicy)
local FFlagEnableBuyRobuxSdui = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagEnableBuyRobuxSdui
local getAppFeaturePolicies = UniversalAppPolicy.getAppFeaturePolicies
local _RobloxSubscriptionFlowCompleteReason = require(RobloxSubscriptionPurchaseApp.Enums.RobloxSubscriptionFlowCompleteReason)
local Constants = require(RobloxSubscriptionPurchaseApp.Constants)

local function createProductFromParams(tbl1)
    return {
        EligibleOffers = tbl1.isFreeTrial and {{
            Duration = 0,
            OfferType = "FreeTrial",
            PeriodType = ""
        }} or {},
        LocalizedPrice = { CurrencyCode = "", Nanos = 0, Units = 0 },
        LocalizedPriceDisplayString = tbl1.displayPrice,
        PeriodType = "",
        ProductKey = {
            Id = tbl1.subscriptionProductId,
            Type = Constants.ROBLOX_SUBSCRIPTION_PRODUCT_TYPE
        },
        ProductTypeDetails = {
            RobloxSubscriptionProductDetails = {
                FeatureConfig = {
                    IsRobuxTransferEnabled = false,
                    IsTradingEnabled = false,
                    IsUgcPublishingEnabled = false
                }
            }
        }
    }
end

local function startRobloxSubscriptionPurchaseFromUpsell(tbl1)
    local var1 = RobloxSubscriptionStore.get()
    local entryContext = tbl1.entryContext

    var1.setRobloxSubscriptionProduct(tbl1.productDetails or createProductFromParams(tbl1))
    var1.setOnFlowComplete(tbl1.onFlowComplete)
    var1.setPurchaseFlowOptions({ skipWaitingForPurchaseResult = tbl1.skipWaitingForPurchaseResult == true })

    if entryContext then
        var1.setEntryContext(entryContext)
    end

    logRobloxSubscriptionUpsellCounter(RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionUpsellModalInitiatedCounter)

    local var2 = getAppFeaturePolicies().getDisableBlackbirdEntrypoints()

    local var3 = RobloxSubscriptionHeadlessOverlayController.render()

    if var2 then
        transitionToError(ErrorReason.UnsupportedPlatform, "startRobloxSubscriptionPurchaseFromUpsell")
        return var3
    end

    var1.setPromptState(PromptState.SubscriptionPurchaseRequested)
    if FFlagEnableSubscriptionPurchaseFlowEventIngest then
        logSubscriptionPurchaseFlowEvent("SubscriptionUpsellModalOpen")
    end

    if not FFlagEnableBuyRobuxSdui or tbl1.paymentSessionId == nil then
        createPaymentSession(entryContext):andThen(function(str1: string)
            var1.setPaymentSessionId(str1)
            performRobloxSubscriptionPurchase()
        end)

        return var3
    end

    var1.setPaymentSessionId(tbl1.paymentSessionId)
    performRobloxSubscriptionPurchase()
    return var3
end

return startRobloxSubscriptionPurchaseFromUpsell

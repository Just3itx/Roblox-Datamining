-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent
local Promise = require(RobloxSubscriptionPurchaseAppParent.Promise)

local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local _types = require(RobloxSubscriptionPurchaseApp.types)
local _GetRobloxSubscriptionProductsModel = require(RobloxSubscriptionPurchaseApp.Models.GetRobloxSubscriptionProductsModel)
local createPaymentSession = require(RobloxSubscriptionPurchaseApp.Network.createPaymentSession)
local getRobloxSubscriptionProducts = require(RobloxSubscriptionPurchaseApp.Network.getRobloxSubscriptionProducts)
local getRobloxSubscriptionProductsDirect = require(RobloxSubscriptionPurchaseApp.Network.getRobloxSubscriptionProductsDirect)
local FFlagRobloxSubscriptionProductsDirectFetch = require(RobloxSubscriptionPurchaseApp.Flags.FFlagRobloxSubscriptionProductsDirectFetch)
local getAmpFeatureAccess = require(RobloxSubscriptionPurchaseApp.Network.getAmpFeatureAccess)
local logRobloxSubscriptionUpsellCounter = require(RobloxSubscriptionPurchaseApp.Utils.logRobloxSubscriptionUpsellCounter)
local logSubscriptionPurchaseFlowEvent = require(RobloxSubscriptionPurchaseApp.Utils.logSubscriptionPurchaseFlowEvent)

local FFlagEnableSubscriptionPurchaseFlowEventIngest = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnableSubscriptionPurchaseFlowEventIngest)
local RobloxSubscriptionUpsellTelemetry = require(RobloxSubscriptionPurchaseApp.Events.RobloxSubscriptionUpsellTelemetry)
local transitionToError = require(RobloxSubscriptionPurchaseApp.Actions.transitionToError)
local FFlagRobloxPlusAmpSubscriptionCheck = require(RobloxSubscriptionPurchaseApp.Flags.FFlagRobloxPlusAmpSubscriptionCheck)
local FFlagEnablePlusReferralLandingSheet = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagEnablePlusReferralLandingSheet

local FFlagPlusSubscribeDeepLinkIncludeUpgrades = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagPlusSubscribeDeepLinkIncludeUpgrades
local FFlagTTOnboardingSheet = require(RobloxSubscriptionPurchaseApp.Flags.FFlagTTOnboardingSheet)
local RobloxPlusSheetKind = require(RobloxSubscriptionPurchaseApp.Enums.RobloxPlusSheetKind)
local FFlagPlusMembershipConfigChangeCheck = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagPlusMembershipConfigChangeCheck
local getRobloxSubscriptionMembershipConfig = require(RobloxSubscriptionPurchaseApp.Network.getRobloxSubscriptionMembershipConfig)
local resetPerFlowState = require(RobloxSubscriptionPurchaseApp.Actions.resetPerFlowState)
local RobloxSubscriptionSignals = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionSignals)
local fetchReferralEligibility = require(RobloxSubscriptionPurchaseApp.Network.fetchReferralEligibility)
local ErrorReason = require(RobloxSubscriptionPurchaseApp.Enums.ErrorReason)
local ReferralIneligibilityReason = require(RobloxSubscriptionPurchaseApp.Enums.ReferralIneligibilityReason)
local AmpAccessResponse = require(RobloxSubscriptionPurchaseApp.Enums.AmpAccessResponse)
local getAppFeaturePolicies = require(RobloxSubscriptionPurchaseAppParent.UniversalAppPolicy).getAppFeaturePolicies

local tbl1 = {
    [ReferralIneligibilityReason.RecipientSelfReferral] = ErrorReason.ReferralSelfReferral
}

function initiateRobloxSubscriptionPurchaseInternal(arg1)
    logRobloxSubscriptionUpsellCounter(RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionUpsellModalInitiatedCounter)

    local var1 = RobloxSubscriptionStore.get()

    if FFlagPlusMembershipConfigChangeCheck then
        resetPerFlowState()
    end

    local purchaseUiOptions = var1.getPurchaseUIOptions()

    local var2 = getAppFeaturePolicies().getDisableBlackbirdEntrypoints()
    if purchaseUiOptions ~= nil and purchaseUiOptions.skipGuacPolicy then
        var2 = false
    end

    if var2 then
        transitionToError(ErrorReason.UnsupportedPlatform, "initiateRobloxSubscriptionPurchaseInternal")
        return
    end

    if FFlagTTOnboardingSheet and purchaseUiOptions and purchaseUiOptions.sheetKind == RobloxPlusSheetKind.TT then
        var1.setPromptState(PromptState.SubscriptionPurchaseUIReady)
        return
    end

    var1.setPromptState(PromptState.SubscriptionPurchaseRequested)
    if FFlagEnableSubscriptionPurchaseFlowEventIngest then
        logSubscriptionPurchaseFlowEvent("SubscriptionUpsellModalOpen")
    end

    local paymentSession = createPaymentSession(arg1)
    local referrerId = if FFlagEnablePlusReferralLandingSheet then var1.getReferrerId() else nil
    local var3 = referrerId and referrerId > 0 and referrerId or nil
    local bool1 = if FFlagPlusSubscribeDeepLinkIncludeUpgrades and FFlagRobloxSubscriptionProductsDirectFetch then var1.getPurchaseFlowOptions().includeUpgrades == true else nil
    local var4 = if FFlagRobloxSubscriptionProductsDirectFetch then getRobloxSubscriptionProductsDirect(var3, bool1) else getRobloxSubscriptionProducts()
    local var5 = FFlagRobloxPlusAmpSubscriptionCheck and not bool1
    local tbl2 = { paymentSession, var4 }
    if var5 then
        table.insert(tbl2, getAmpFeatureAccess())
    end
    if FFlagEnablePlusReferralLandingSheet and var3 then
        table.insert(tbl2, fetchReferralEligibility(var3))
    end

    local var6 = nil

    if FFlagPlusMembershipConfigChangeCheck and bool1 and RobloxSubscriptionSignals.get().getHasRobloxSubscription() then
        table.insert(tbl2, getRobloxSubscriptionMembershipConfig())
        var6 = #tbl2
    end

    Promise.all(tbl2):andThen(function(arg2)
        local var7 = arg2[1]
        local var8 = arg2[2]

        if var5 and arg2[3] == AmpAccessResponse.Granted then
            transitionToError(ErrorReason.AlreadySubscribed, "initiateRobloxSubscriptionPurchaseInternal")
            return
        end

        if FFlagEnablePlusReferralLandingSheet and var3 then
            local var9 = arg2[if var5 then 4 else 3]
            if not var9.eligible then
                local var10 = tbl1[var9.reason] or ErrorReason.ReferralIneligible
                transitionToError(var10, "initiateRobloxSubscriptionPurchaseInternal")
                return
            end
        end

        if var6 then
            local var9 = arg2[var6]
            if var9 == nil then
                transitionToError(ErrorReason.GenericError, "initiateRobloxSubscriptionPurchaseInternal")
                return
            end
            var1.setMembershipConfigSnapshot(var9)
        end

        var1.setPaymentSessionId(var7)

        if #var8 > 0 then
            local var9 = var8[1]
            var1.setRobloxSubscriptionProduct(var9)

            var1.setPromptState(PromptState.SubscriptionPurchaseUIReady)
            return
        end

        transitionToError(ErrorReason.AlreadySubscribed, "initiateRobloxSubscriptionPurchaseInternal")
    end, function(_)
        transitionToError(ErrorReason.GenericError, "initiateRobloxSubscriptionPurchaseInternal")
    end)
end

return initiateRobloxSubscriptionPurchaseInternal

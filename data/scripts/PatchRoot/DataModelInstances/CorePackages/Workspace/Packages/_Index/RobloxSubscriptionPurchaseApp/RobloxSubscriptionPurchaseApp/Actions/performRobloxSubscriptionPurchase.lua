-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")

local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)

local getSubscriptionPurchaseUrl = require(RobloxSubscriptionPurchaseApp.Utils.getSubscriptionPurchaseUrl)
local WebViewServiceWrapper = require(RobloxSubscriptionPurchaseApp.Utils.WebViewServiceWrapper)
local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local Constants = require(RobloxSubscriptionPurchaseApp.Constants)
local _GetRobloxSubscriptionProductsModel = require(RobloxSubscriptionPurchaseApp.Models.GetRobloxSubscriptionProductsModel)
local completeRobloxSubscriptionUpsellFlow = require(RobloxSubscriptionPurchaseApp.Actions.completeRobloxSubscriptionUpsellFlow)
local transitionToError = require(RobloxSubscriptionPurchaseApp.Actions.transitionToError)
local ErrorReason = require(RobloxSubscriptionPurchaseApp.Enums.ErrorReason)
local claimEventSubscription = require(RobloxSubscriptionPurchaseApp.Network.claimEventSubscription)
local RobloxPlusSheetKind = require(RobloxSubscriptionPurchaseApp.Enums.RobloxPlusSheetKind)

local RobloxSubscriptionUpsellTelemetry = require(RobloxSubscriptionPurchaseApp.Events.RobloxSubscriptionUpsellTelemetry)
local logRobloxSubscriptionUpsellCounter = require(RobloxSubscriptionPurchaseApp.Utils.logRobloxSubscriptionUpsellCounter)
local logSubscriptionPurchaseFlowEvent = require(RobloxSubscriptionPurchaseApp.Utils.logSubscriptionPurchaseFlowEvent)
local FFlagTTOnboardingSheet = require(RobloxSubscriptionPurchaseApp.Flags.FFlagTTOnboardingSheet)

local FFlagEnableSubscriptionPurchaseFlowEventIngest = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnableSubscriptionPurchaseFlowEventIngest)

local FFlagEnableStudioMockPurchaseRobloxSubscription = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnableStudioMockPurchaseRobloxSubscription)
local RobloxSubscriptionPurchaseAppParent = RobloxSubscriptionPurchaseApp.Parent
local FFlagEnablePlusReferralLandingSheet = require(RobloxSubscriptionPurchaseAppParent.SharedFlags).FFlagEnablePlusReferralLandingSheet
local title = game:DefineFastString("FStringBlackbirdWebviewHeaderName", "Black bird")
local engineFeature = game:GetEngineFeature("EnableSubscriptionPurchaseReferrerId")

local function getPaymentProviderForPlatform(platform: Enum.Platform): string -- Luacid: Inlined by compiler; 1 call site recovered
    if platform == Enum.Platform.IOS then
        return "AppleAppStore"
    end

    if platform == Enum.Platform.Android then
        return "GooglePlayStore"
    end

    return "Unknown"
end

function performRobloxSubscriptionPurchase()
    local var1 = RobloxSubscriptionStore.get()
    local robloxSubscriptionProductId = var1.getRobloxSubscriptionProductId()
    local paymentSessionId = var1.getPaymentSessionId()

    if robloxSubscriptionProductId == nil then
        return
    end

    if FFlagEnableStudioMockPurchaseRobloxSubscription and RunService:IsStudio() then
        MarketplaceService:SignalMockPurchaseRobloxSubscription()
        var1.setDidTryPurchasing(true)
        completeRobloxSubscriptionUpsellFlow()
        return
    end

    if FFlagEnableSubscriptionPurchaseFlowEventIngest then
        logSubscriptionPurchaseFlowEvent("SubscriptionPurchaseAttempted")
    end

    if FFlagTTOnboardingSheet and var1.getPurchaseUIOptions().sheetKind == RobloxPlusSheetKind.TT then
        var1.setIsNativePurchase(false)
        var1.setPromptState(PromptState.SubscriptionPurchaseInProgress)

        claimEventSubscription():andThen(function()
            var1.setDidTryPurchasing(true)
            completeRobloxSubscriptionUpsellFlow()
        end, function()
            transitionToError(ErrorReason.GenericError, "performRobloxSubscriptionPurchase")
            logRobloxSubscriptionUpsellCounter(RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionUpsellPurchaseFailedCounter)
        end)

        return
    end

    local platform = UserInputService:GetPlatform()
    local bool1 = platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.Linux
    local referrerId = if FFlagEnablePlusReferralLandingSheet then var1.getReferrerId() else nil

    if bool1 then
        var1.setIsNativePurchase(false)
        var1.setPromptState(PromptState.SubscriptionPurchaseUIReady)
        WebViewServiceWrapper.new({
            url = getSubscriptionPurchaseUrl(robloxSubscriptionProductId, paymentSessionId, referrerId),
            title = title,
            closeCallback = function()
                var1.setDidTryPurchasing(true)
                completeRobloxSubscriptionUpsellFlow()
            end,
            onOpenCallback = function()
                var1.setPromptState(PromptState.SubscriptionPurchaseInProgress)
            end
        }):open()
        return
    end

    var1.setPromptState(PromptState.SubscriptionPurchaseInProgress)
    local paymentProviderForPlatform = getPaymentProviderForPlatform(platform)
    var1.setIsNativePurchase(true)

    local success, _result = pcall(function()
        if FFlagEnablePlusReferralLandingSheet and engineFeature and referrerId then
            MarketplaceService:PerformSubscriptionPurchaseV3Async(
                Constants.ROBLOX_SUBSCRIPTION_PRODUCT_TYPE,
                robloxSubscriptionProductId,
                paymentProviderForPlatform,
                paymentSessionId,
                referrerId
            )
            return
        end

        MarketplaceService:PerformSubscriptionPurchaseV3Async(
            Constants.ROBLOX_SUBSCRIPTION_PRODUCT_TYPE,
            robloxSubscriptionProductId,
            paymentProviderForPlatform,
            paymentSessionId
        )
    end)

    if not success then
        transitionToError(ErrorReason.GenericError, "performRobloxSubscriptionPurchase")
        logRobloxSubscriptionUpsellCounter(RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionUpsellPurchaseFailedCounter)
    end
end

return performRobloxSubscriptionPurchase

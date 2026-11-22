-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local RobloxSubscriptionFlowCompleteReason = require(RobloxSubscriptionPurchaseApp.Enums.RobloxSubscriptionFlowCompleteReason)
local cleanupSubscriptionFlow = require(RobloxSubscriptionPurchaseApp.Actions.cleanupSubscriptionFlow)
local logRobloxSubscriptionUpsellCounter = require(RobloxSubscriptionPurchaseApp.Utils.logRobloxSubscriptionUpsellCounter)
local logSubscriptionPurchaseFlowEvent = require(RobloxSubscriptionPurchaseApp.Utils.logSubscriptionPurchaseFlowEvent)
local RobloxSubscriptionUpsellTelemetry = require(RobloxSubscriptionPurchaseApp.Events.RobloxSubscriptionUpsellTelemetry)

local FFlagEnableSubscriptionPurchaseFlowEventIngest = require(RobloxSubscriptionPurchaseApp.Flags.FFlagEnableSubscriptionPurchaseFlowEventIngest)
local FFlagBustAvatarCacheAfterSubscriptionPurchase = require(RobloxSubscriptionPurchaseApp.Flags.FFlagBustAvatarCacheAfterSubscriptionPurchase)

local function func1(bool1: boolean, bool2: boolean, bool3: boolean, bool4: boolean) -- Luacid: Inlined by compiler; 2 call sites recovered
    if not bool1 then
        return RobloxSubscriptionFlowCompleteReason.UpsellDismissed
    end

    if bool2 then
        return RobloxSubscriptionFlowCompleteReason.UpsellPurchaseSucceeded
    end

    if bool3 and not bool4 then
        return RobloxSubscriptionFlowCompleteReason.UpsellPurchaseFailed
    end

    return RobloxSubscriptionFlowCompleteReason.UpsellPurchaseAttempted
end

local function emitCompletionTelemetry(arg1)
    if arg1 == RobloxSubscriptionFlowCompleteReason.UpsellDismissed then
        if FFlagEnableSubscriptionPurchaseFlowEventIngest then
            logSubscriptionPurchaseFlowEvent("SubscriptionUpsellPurchaseDismissed")
        end
        logRobloxSubscriptionUpsellCounter(RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionUpsellDismissedCounter)
    elseif arg1 == RobloxSubscriptionFlowCompleteReason.UpsellPurchaseSucceeded then
        if FFlagEnableSubscriptionPurchaseFlowEventIngest then
            logSubscriptionPurchaseFlowEvent("SubscriptionUpsellPurchaseSucceeded")
        end
        logRobloxSubscriptionUpsellCounter(RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionUpsellPurchaseSucceededCounter)
    elseif arg1 == RobloxSubscriptionFlowCompleteReason.UpsellPurchaseFailed then
        if FFlagEnableSubscriptionPurchaseFlowEventIngest then
            logSubscriptionPurchaseFlowEvent("SubscriptionUpsellPurchaseFailed")
        end

        logRobloxSubscriptionUpsellCounter(
            RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionUpsellNativePurchasePollingTimeoutCounter
        )
    elseif arg1 == RobloxSubscriptionFlowCompleteReason.UpsellPurchaseAttempted then
        logRobloxSubscriptionUpsellCounter(RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionPurchaseAttemptedCounter)
    end

    logRobloxSubscriptionUpsellCounter(RobloxSubscriptionUpsellTelemetry.RobloxSubscriptionUpsellFlowCompletedCounter)
end

local function finalizeRobloxSubscriptionUpsellFlow(bool1: boolean)
    local var1 = RobloxSubscriptionStore.get()
    local didTryPurchasing = var1.getDidTryPurchasing()
    local isNativePurchase = var1.getIsNativePurchase()
    local skipWaitingForPurchaseResult = var1.getPurchaseFlowOptions().skipWaitingForPurchaseResult or false
    local var2 = if didTryPurchasing then func1(true, bool1, isNativePurchase, skipWaitingForPurchaseResult) else func1(false, nil, nil, nil)
    var1.setPromptState(PromptState.SubscriptionPurchaseCompleted)

    emitCompletionTelemetry(var2)

    if FFlagBustAvatarCacheAfterSubscriptionPurchase and var2 == RobloxSubscriptionFlowCompleteReason.UpsellPurchaseSucceeded then
        game:GetService("AvatarEditorService"):BustAvatarFetchCache()
    end

    var1.triggerOnFlowComplete(var2)
    cleanupSubscriptionFlow()
end

return finalizeRobloxSubscriptionUpsellFlow

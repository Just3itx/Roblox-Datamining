-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:31:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxSubscriptionPurchaseApp = script:FindFirstAncestor("RobloxSubscriptionPurchaseApp")
local MarketplaceService = game:GetService("MarketplaceService")

local RobloxSubscriptionStore = require(RobloxSubscriptionPurchaseApp.Store.RobloxSubscriptionStore)
local PromptState = require(RobloxSubscriptionPurchaseApp.Enums.PromptState)
local _GetRobloxSubscriptionProductsModel = require(RobloxSubscriptionPurchaseApp.Models.GetRobloxSubscriptionProductsModel)
local finalizeRobloxSubscriptionUpsellFlow = require(RobloxSubscriptionPurchaseApp.Actions.finalizeRobloxSubscriptionUpsellFlow)
local FFlagFixSignalFinishedOnError = require(RobloxSubscriptionPurchaseApp.Flags.FFlagFixSignalFinishedOnError)

local engineFeature = game:GetEngineFeature("EnablePromptSignalRobloxSubscriptionPurchaseFinished")

local function completeRobloxSubscriptionUpsellFlow()
    local var1 = RobloxSubscriptionStore.get()
    local didTryPurchasing = var1.getDidTryPurchasing()
    local robloxSubscriptionProductId = var1.getRobloxSubscriptionProductId()
    local skipWaitingForPurchaseResult = var1.getPurchaseFlowOptions().skipWaitingForPurchaseResult
    local promptState = var1.getPromptState()

    if promptState == PromptState.Error or promptState == PromptState.SubscriptionStatusPolling then
        if promptState == PromptState.Error and FFlagFixSignalFinishedOnError and engineFeature then
            MarketplaceService:signalPromptRobloxSubscriptionPurchaseFinished(robloxSubscriptionProductId, didTryPurchasing)
        end
        finalizeRobloxSubscriptionUpsellFlow(false)
        return
    end
    var1.setPromptState(PromptState.SubscriptionPurchaseCompleted)

    if engineFeature then
        MarketplaceService:signalPromptRobloxSubscriptionPurchaseFinished(robloxSubscriptionProductId, didTryPurchasing)
    end

    if skipWaitingForPurchaseResult or not didTryPurchasing then
        finalizeRobloxSubscriptionUpsellFlow(false)
        return
    end

    var1.setPromptState(PromptState.SubscriptionStatusPolling)
end

return completeRobloxSubscriptionUpsellFlow

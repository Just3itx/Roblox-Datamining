-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:40:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Workspace = game:GetService("Workspace")

local _types = require(scriptParentParent.types)

local SetPromptState = require(scriptParentParent.Actions.SetPromptState)
local PurchaseCompleteRecieved = require(scriptParentParent.Actions.PurchaseCompleteRecieved)
local PromptState = require(scriptParentParent.Enums.PromptState)
local Thunk = require(scriptParentParent.Thunk)
local completeRequest = require(scriptParentParent.Thunks.completeRequest)
local FFlagSkipCompletionModalForMarketplace = require(scriptParentParent.Parent.SharedFlags).FFlagSkipCompletionModalForMarketplace
local logUnifiedPurchaseTelemetryCounter = require(scriptParentParent.Utils.logUnifiedPurchaseTelemetryCounter)
local UnifiedPurchaseTelemetry = require(scriptParentParent.Events.UnifiedPurchaseTelemetry)
local sendUnifiedPurchaseEventLog = require(scriptParentParent.Utils.sendUnifiedPurchaseEventLog)
local UnifiedPurchaseEventNameEnum = require(scriptParentParent.Enums.UnifiedPurchaseEventNameEnum)
local getFeatureKeyForSurface = require(scriptParentParent.Utils.getFeatureKeyForSurface)
local FFlagRefetchBothOfferKeysAfterPurchase = require(scriptParentParent.Flags.FFlagRefetchBothOfferKeysAfterPurchase)
local InExperienceOffers = require(scriptParentParent.Parent.InExperienceOffers)

local function completePurchase(arg1)
    return Thunk.new(script.Name, {}, function(arg2, _)
        local purchasingStartTime = arg2:getState().purchasingStartTime
        local var1 = Workspace.DistributedGameTime - purchasingStartTime

        arg2:dispatch(PurchaseCompleteRecieved())

        arg2:flush()

        local purchaseAnalyticsMetadata = arg2:getState().purchaseAnalyticsMetadata
        if purchaseAnalyticsMetadata then
            local offersStore = InExperienceOffers.getOffersStore(false)
            local offers = offersStore.getOffers(false)
            local featureKeys = InExperienceOffers.FeatureKeys
            local getOffersForKey = InExperienceOffers.Utils.getOffersForKey
            if FFlagRefetchBothOfferKeysAfterPurchase then
                local tbl1 = { featureKeys.RobloxShop, featureKeys.DeveloperShop }
                if InExperienceOffers.Utils.hasOfferForAnyKey(offers, tbl1) then
                    offersStore.fetchOffers(tbl1)
                end
            elseif getFeatureKeyForSurface(purchaseAnalyticsMetadata.surface) == featureKeys.RobloxShop then
                if getOffersForKey(offers, featureKeys.RobloxShop) ~= nil then
                    offersStore.fetchOffers({ featureKeys.RobloxShop })
                end
            elseif getOffersForKey(offers, featureKeys.DeveloperShop) ~= nil then
                offersStore.fetchOffers({ featureKeys.DeveloperShop })
            end
        end

        if arg2:getState().isUserEligibleForUnifiedPurchaseFlow then
            local state = arg2:getState()
            local postPurchaseActions = state.postPurchaseActions
            local postPurchaseActionsState = state.postPurchaseActionsState or {}
            if postPurchaseActions then
                for _, postPurchaseAction in ipairs(postPurchaseActions) do
                    if postPurchaseAction and postPurchaseAction.actionKey and postPurchaseAction.isActionSelected ~= nil then
                        postPurchaseActionsState[postPurchaseAction.actionKey] = postPurchaseAction.isActionSelected
                    end
                end
            end

            if state.purchaseCallbacks and state.purchaseCallbacks.onPurchaseSuccess then
                state.purchaseCallbacks.onPurchaseSuccess(arg1, postPurchaseActionsState)
            end

            if state.purchaseAnalyticsMetadata then
                local purchaseAnalyticsMetadata2 = state.purchaseAnalyticsMetadata

                logUnifiedPurchaseTelemetryCounter(
                    UnifiedPurchaseTelemetry.UnifiedProductPurchaseModalPurchaseSuccessCounter,
                    purchaseAnalyticsMetadata2.surface,
                    purchaseAnalyticsMetadata2.productType
                )

                sendUnifiedPurchaseEventLog({
                    event_name = UnifiedPurchaseEventNameEnum.ItemPurchaseSuccess,
                    purchase_flow_uuid = purchaseAnalyticsMetadata2.purchaseFlowUUID,
                    product_id = purchaseAnalyticsMetadata2.productId,
                    product_type = purchaseAnalyticsMetadata2.productType,
                    product_target_id = purchaseAnalyticsMetadata2.productTargetId,
                    robux_price = purchaseAnalyticsMetadata2.price,
                    surface = purchaseAnalyticsMetadata2.surface,
                    user_roblox_balance = purchaseAnalyticsMetadata2.userRobuxBalance,
                    salelocation_universeid = purchaseAnalyticsMetadata2.saleLocationUniverseId
                })
            end
        end

        if FFlagSkipCompletionModalForMarketplace then
            local purchaseOptions = arg2:getState().purchaseOptions
            if purchaseOptions and purchaseOptions.skipPurchaseSuccessModal then
                arg2:dispatch(SetPromptState(PromptState.PurchaseComplete))
                return arg2:dispatch(completeRequest())
            end
        end

        if var1 >= 1 then
            return arg2:dispatch(SetPromptState(PromptState.PurchaseComplete))
        end
        delay(1 - var1, function()
            return arg2:dispatch(SetPromptState(PromptState.PurchaseComplete))
        end)
    end)
end

return completePurchase

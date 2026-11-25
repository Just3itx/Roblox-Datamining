-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:41:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ExperienceAuthService = game:GetService("ExperienceAuthService")

local PurchasePromptParent = PurchasePrompt.Parent
local IAPExperience = require(PurchasePromptParent.IAPExperience)
local isEconomicRestrictionResponse = IAPExperience.Utility.isEconomicRestrictionResponse
local parseEconomicRestrictionsFailureReason = IAPExperience.Utility.parseEconomicRestrictionsFailureReason

local parseEconomicRestrictionsExpirationTimeInMinutes = IAPExperience.Utility.parseEconomicRestrictionsExpirationTimeInMinutes

local SetPromptState = require(PurchasePrompt.Actions.SetPromptState)
local StartPurchase = require(PurchasePrompt.Actions.StartPurchase)
local ErrorOccurred = require(PurchasePrompt.Actions.ErrorOccurred)
local SetEconomicRestrictionError = require(PurchasePrompt.Actions.SetEconomicRestrictionError)
local PurchaseFlow = require(PurchasePrompt.Enums.PurchaseFlow)
local PromptState = require(PurchasePrompt.Enums.PromptState)
local ItemType = require(PurchasePrompt.Enums.ItemType)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local RequestType = require(PurchasePrompt.Enums.RequestType)
local getToolAsset = require(PurchasePrompt.Network.getToolAsset)
local performPurchase = require(PurchasePrompt.Network.performPurchase)
local performPurchaseV2 = require(PurchasePrompt.Network.performPurchaseV2)
local performCreatorStorePurchase = require(PurchasePrompt.Network.performCreatorStorePurchase)
local Network = require(PurchasePrompt.Services.Network)
local Analytics = require(PurchasePrompt.Services.Analytics)
local ExternalSettings = require(PurchasePrompt.Services.ExternalSettings)
local isCreatorStoreAssetType = require(PurchasePrompt.Utils.isCreatorStoreAssetType)
local Thunk = require(PurchasePrompt.Thunk)
local Promise = require(PurchasePrompt.Promise)
local _types = require(PurchasePrompt.types)
local ProductTypeEnum = require(PurchasePrompt.types).ProductTypeEnum
local selectProductPrice = require(PurchasePrompt.Selectors.selectProductPrice)
local derivePurchaseOptionsFromCartPricingResponse = require(PurchasePrompt.Utils.derivePurchaseOptionsFromCartPricingResponse)
local mergeOfferIdsIntoPurchasePayload = require(PurchasePrompt.Utils.mergeOfferIdsIntoPurchasePayload)

local performLuaPurchase = require(PurchasePrompt.Thunks.performLuaPurchase)
local handlePriceChangedError = require(PurchasePrompt.Utils.handlePriceChangedError)

local completePurchase = require(script.Parent.completePurchase)
local GetFFlagEnableCreatorStorePurchasingCutover = require(PurchasePrompt.Flags.GetFFlagEnableCreatorStorePurchasingCutover)
local logUnifiedPurchaseTelemetryCounter = require(PurchasePrompt.Utils.logUnifiedPurchaseTelemetryCounter)
local reportPurchasePromptNonCollectiblePurchase = require(PurchasePrompt.Telemetry.reportPurchasePromptNonCollectiblePurchase)
local UnifiedPurchaseTelemetry = require(PurchasePrompt.Events.UnifiedPurchaseTelemetry)

local FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow = require(PurchasePromptParent.SharedFlags).FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow

local FFlagEnablePurchasePayloadInExperienceShop = require(PurchasePromptParent.SharedFlags).FFlagEnablePurchasePayloadInExperienceShop
local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(PurchasePromptParent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs
local FFlagMockDevSubPurchaseInStudio = require(PurchasePrompt.Flags.FFlagMockDevSubPurchaseInStudio)

local FFlagEnableMarketplacePurchaseDeepLinkAttribution = require(PurchasePromptParent.SharedFlags).FFlagEnableMarketplacePurchaseDeepLinkAttribution

local FFlagEnableNonCollectiblePurchaseCountersLua = require(PurchasePromptParent.SharedFlags).FFlagEnableNonCollectiblePurchaseCountersLua

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(PurchasePromptParent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local tbl1 = { Network, Analytics, ExternalSettings }

function isLuaPurchase(productPayload)
    if productPayload == nil then
        return false
    end

    return (productPayload.kind == ProductTypeEnum.Product and productPayload.universeId ~= nil
        or productPayload.kind == ProductTypeEnum.Experience
        or productPayload.kind == ProductTypeEnum.Look
        or FFlagEnableUnifiedPurchaseFlowForDevSubs and productPayload.kind == ProductTypeEnum.DeveloperSubscription)
        and true
        or FFlagLuaAppsEnablePromptVIPServerPurchase and productPayload.kind == ProductTypeEnum.VIPServer
end

local function purchaseItem()
    return Thunk.new(script.Name, tbl1, function(arg1, arg2)
        local var1 = arg2[Network]
        local var2 = arg2[ExternalSettings]
        local var3 = arg2[Analytics]

        local state = arg1:getState()
        local purchaseFlow = state.purchaseFlow
        local requestType = state.promptRequest.requestType

        if state.cartPricing ~= nil and state.cartPricing.isFetching then
            local purchaseAnalyticsMetadata = state.purchaseAnalyticsMetadata
            logUnifiedPurchaseTelemetryCounter(
                UnifiedPurchaseTelemetry.UnifiedCartPricingBuyBlockedWhileFetchingCounter,
                purchaseAnalyticsMetadata and purchaseAnalyticsMetadata.surface,
                purchaseAnalyticsMetadata and purchaseAnalyticsMetadata.productType
            )
            return
        end

        local platform = var2.getPlatform()

        arg1:dispatch(StartPurchase(Workspace.DistributedGameTime))

        if arg1:getState().isUserEligibleForUnifiedPurchaseFlow then
            logUnifiedPurchaseTelemetryCounter(
                UnifiedPurchaseTelemetry.UnifiedProductPurchaseModalPurchaseAttemptedCounter,
                state.purchaseAnalyticsMetadata.surface,
                state.purchaseAnalyticsMetadata.productType
            )

            if state.purchaseCallbacks and state.purchaseCallbacks.onPurchaseAttempt then
                state.purchaseCallbacks.onPurchaseAttempt()
            end
        end

        if requestType == RequestType.AvatarCreationFee then
            local metadata = ({})
            metadata.avatarName = state.productInfo.name
            metadata.avatarDescription = state.productInfo.description
            metadata.priceFromToken = state.productInfo.price

            local scopes = { Enum.ExperienceAuthScope.CreatorAssetsCreate }

            ExperienceAuthService:ScopeCheckUIComplete(
                state.promptRequest.id,
                scopes,
                Enum.ScopeCheckResult.ConsentAccepted,
                metadata
            )

            var3.signalAvatarCreationPurchaseSubmit()

            arg1:dispatch(completePurchase())
            return
        end

        if purchaseFlow == PurchaseFlow.RobuxUpsellV2 or purchaseFlow == PurchaseFlow.LargeRobuxUpsell then
            arg1:dispatch(SetPromptState(PromptState.PurchaseInProgress))
        end

        local state2 = arg1:getState()

        local str1 = HttpService:GenerateGUID(false)

        local id = state2.promptRequest.id
        local infoType = state2.promptRequest.infoType
        local equipIfPurchased = state2.promptRequest.equipIfPurchased
        local isRobloxPurchase = state2.promptRequest.isRobloxPurchase
        local purchaseAuthToken = state2.promptRequest.purchaseAuthToken
        local idempotencyKey = state2.promptRequest.idempotencyKey
        local collectibleItemId = state2.promptRequest.collectibleItemId
        local collectibleItemInstanceId = state2.promptRequest.collectibleItemInstanceId
        local collectibleProductId = state2.promptRequest.collectibleProductId
        local var4 = selectProductPrice(state2)
        local assetTypeId = state2.productInfo.assetTypeId
        local assetType = state2.productInfo.assetType
        local productId = state2.productInfo.productId
        local collectibleItemId2 = state2.productInfo.collectibleItemId
        local collectibleProductId2 = state2.productInfo.collectibleProductId

        local var5 = derivePurchaseOptionsFromCartPricingResponse(state2.cartPricing and state2.cartPricing.response)

        if FFlagEnableMarketplacePurchaseDeepLinkAttribution then
            local deepLinkId = state2.productPayload and state2.productPayload.deepLinkId
            if deepLinkId ~= nil and deepLinkId ~= "" then
                var5 = var5 or {}
                var5.DeepLinkId = deepLinkId
            end
        end

        local itemType = state2.productInfo.itemType

        var3.signalProductPurchaseConfirmed(productId, state2.requestType)
        local bool1 = collectibleItemId and not (collectibleItemId == "") and infoType == Enum.InfoType.Bundle

        if isLuaPurchase(state2.productPayload) then
            if FFlagMockDevSubPurchaseInStudio
                and FFlagEnableUnifiedPurchaseFlowForDevSubs
                and state2.productPayload.kind == ProductTypeEnum.DeveloperSubscription
                and var2.isStudio()
            then
                arg1:dispatch(completePurchase())
                return
            end

            arg1:dispatch(performLuaPurchase())
            return
        end

        if GetFFlagEnableCreatorStorePurchasingCutover() and isCreatorStoreAssetType(assetType) then
            return performCreatorStorePurchase(var1, productId, assetType):andThen(function(arg3)
                arg1:dispatch(completePurchase())

                var3.signalPurchaseSuccess(id, infoType, var4, arg3)

                return Promise.resolve()
            end):catch(function(arg3)
                arg1:dispatch(ErrorOccurred(arg3))
            end)
        end

        if bool1 or collectibleItemInstanceId and collectibleItemInstanceId ~= "" then
            return performPurchaseV2(
                var1,
                infoType,
                productId,
                var4,
                str1,
                isRobloxPurchase,
                collectibleItemId,
                collectibleProductId,
                idempotencyKey,
                purchaseAuthToken,
                collectibleItemInstanceId,
                var5
            ):andThen(
                function(arg3)
                    arg1:dispatch(completePurchase(arg3))

                    var3.signalPurchaseSuccess(id, infoType, var4, arg3)

                    return Promise.resolve()
                end
            ):catch(
                function(arg3)
                    if isEconomicRestrictionResponse(arg3) then
                        local var6 = parseEconomicRestrictionsFailureReason(arg3)
                        local var7 = parseEconomicRestrictionsExpirationTimeInMinutes(arg3)
                        arg1:dispatch(SetEconomicRestrictionError(var6, var7))
                        arg1:dispatch(ErrorOccurred(PurchaseError.EconomicRestriction))
                        return
                    end

                    if handlePriceChangedError(arg1, arg3, state2.productPayload and state2.productPayload.kind) then
                        return
                    end

                    if arg3 == PurchaseError.TwoFactorNeeded then
                        var3.signalTwoSVSettingsErrorShown(productId, infoType)

                        if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX then
                            arg3 = PurchaseError.TwoFactorNeededSettings
                        end
                    end

                    arg1:dispatch(ErrorOccurred(arg3))
                end
            )
        end

        if FFlagEnableNonCollectiblePurchaseCountersLua and (collectibleItemId2 == nil or collectibleItemId2 == "") then
            reportPurchasePromptNonCollectiblePurchase(infoType, state2.productInfo)
        end

        local timedOptionDays = if FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow then state2.productPayload and state2.productPayload.timedOptionDays else nil
        local var6

        if FFlagEnablePurchasePayloadInExperienceShop then
            local purchasePayload = state2.productPayload and state2.productPayload.purchasePayload
            var6 = mergeOfferIdsIntoPurchasePayload(purchasePayload, var5)
        else
            var6 = nil
        end
        local var7 = performPurchase

        if not FFlagAXSupportRentalPurchaseInUnifiedProductPurchaseFlow then
            timedOptionDays = nil
        end

        if not FFlagEnablePurchasePayloadInExperienceShop then
            var6 = nil
        end

        return var7(
            var1,
            infoType,
            productId,
            var4,
            str1,
            isRobloxPurchase,
            collectibleItemId2,
            collectibleProductId2,
            idempotencyKey,
            purchaseAuthToken,
            timedOptionDays,
            var6,
            var5
        ):andThen(
            function(arg3)
                arg1:dispatch(completePurchase(arg3))

                if itemType ~= ItemType.Bundle then
                    var3.signalPurchaseSuccess(id, infoType, var4, arg3)
                end

                if not equipIfPurchased or assetTypeId ~= 19 then
                    return Promise.resolve()
                end

                return getToolAsset(var1, id):andThen(function(arg4)
                    if arg4 then
                        arg4.Parent = Players.LocalPlayer.Backpack
                    end
                end)
            end
        ):catch(
            function(arg3)
                if isEconomicRestrictionResponse(arg3) then
                    local var8 = parseEconomicRestrictionsFailureReason(arg3)
                    local var9 = parseEconomicRestrictionsExpirationTimeInMinutes(arg3)
                    arg1:dispatch(SetEconomicRestrictionError(var8, var9))
                    arg1:dispatch(ErrorOccurred(PurchaseError.EconomicRestriction))
                    return
                end

                if handlePriceChangedError(arg1, arg3, state2.productPayload and state2.productPayload.kind) then
                    return
                end

                if arg3 == PurchaseError.TwoFactorNeeded then
                    var3.signalTwoSVSettingsErrorShown(productId, infoType)

                    if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX then
                        arg3 = PurchaseError.TwoFactorNeededSettings
                    end
                end

                arg1:dispatch(ErrorOccurred(arg3))
            end
        )
    end)
end

return purchaseItem

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("OpenPurchasePrompt"):FindFirstAncestor("ServerDrivenUi").Parent
local SduiCoreSystem = require(ServerDrivenUiParent.SduiCoreSystem)
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType
local SduiActionType = SduiCoreSystem.SduiActionType
local SetCentralOverlay = require(ServerDrivenUiParent.CentralOverlay).Actions.SetCentralOverlay
local CloseCentralOverlay = require(ServerDrivenUiParent.CentralOverlay).Thunks.CloseCentralOverlay
local CentralOverlayType = require(ServerDrivenUiParent.RobloxAppEnums).CentralOverlayType
local DataHydration = require(ServerDrivenUiParent.DataHydration)
local Promise = require(ServerDrivenUiParent.Promise)
local TimeToInteractiveTracker = require(ServerDrivenUiParent.TimeToInteractiveTracker).TimeToInteractiveTracker
local PurchasePromptLite = require(ServerDrivenUiParent.PurchasePromptLite)
local ProductPurchaseSurface = PurchasePromptLite.Enums.ProductPurchaseSurface
local ProductKind = PurchasePromptLite.Enums.ProductKind
local sduiReportGamePlayIntent = require(ServerDrivenUiParent.SduiSharedContent).sduiReportGamePlayIntent
local SharedFlags = require(ServerDrivenUiParent.SharedFlags)
local FFlagSduiDevStoreSeeAllSupport = SharedFlags.FFlagSduiDevStoreSeeAllSupport
local FFlagEnableHomeGameItemOwnershipUpdate = SharedFlags.FFlagEnableHomeGameItemOwnershipUpdate
local FFlagEnableSearchGameItemOwnershipUpdate = SharedFlags.FFlagEnableSearchGameItemOwnershipUpdate
local FFlagEnableEdpPreviewPurchaseSurface = SharedFlags.FFlagEnableEdpPreviewPurchaseSurface
local FFlagEnableLaunchAfterPurchase = SharedFlags.FFlagEnableLaunchAfterPurchase

local ExperienceService = game:GetService("ExperienceService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local bool1 = game:DefineFastFlag("EnableJoinAfterBuyFromEDP", false)
local bool2 = game:DefineFastFlag("EnablePurchasePayloadForSduiPurchase", false)

local function mapPriceDiscountDetails(priceDiscountDetails)
    if priceDiscountDetails == nil or #priceDiscountDetails == 0 then
        return nil
    end
    local result = {}
    for _, priceDiscountDetail in priceDiscountDetails do
        table.insert(result, {
            Type = priceDiscountDetail.type,
            AmountInRobux = priceDiscountDetail.amountInRobux,
            Percent = priceDiscountDetail.percent
        })
    end
    return result
end

local function buildFetchProductInfo(displayInfo, kind: string?): (() -> any)? -- Luacid: Inlined by compiler; 1 call site recovered
    return if displayInfo == nil then nil else function()
        return Promise.resolve({
            ProductId = displayInfo.productId,
            TargetId = displayInfo.targetId,
            Name = displayInfo.productName,
            Description = displayInfo.description,
            PriceInRobux = displayInfo.priceInRobux,
            IsForSale = displayInfo.isForSale == nil or displayInfo.isForSale,
            ProductType = displayInfo.productType or kind,
            ImageUrl = displayInfo.imageUrl,
            DisplayPrice = displayInfo.displayPrice,
            IconImageAssetId = displayInfo.iconImageAssetId,
            BasePriceInRobux = displayInfo.basePriceInRobux,
            PriceDiscountDetails = mapPriceDiscountDetails(displayInfo.priceDiscountDetails)
        })
    end
end

local function buildOnPurchaseSuccess(str1: string?, kind: string?, str2: string?, rootPlaceId: string?)
    if not str2 then
        return nil
    end

    if kind == ProductKind.Gamepass
        and (str1 == ProductPurchaseSurface.EDP
            or FFlagEnableHomeGameItemOwnershipUpdate and str1 == ProductPurchaseSurface.HomePageGameItemShop
            or FFlagEnableSearchGameItemOwnershipUpdate and str1 == ProductPurchaseSurface.SearchPageGameItemShop
            or FFlagEnableEdpPreviewPurchaseSurface and str1 == ProductPurchaseSurface.EDPPreview)
    then
        return function()
            DataHydration.Game.getGamePassStore(false).updateGamePassInfo(str2, { isOwned = true })
        end
    end

    if FFlagSduiDevStoreSeeAllSupport and kind == ProductKind.DeveloperSubscription and str1 == ProductPurchaseSurface.EDP then
        return function()
            DataHydration.Game.getGameSubscriptionStore(false).updateGameSubscriptionInfo(str2, { isSubscribed = true })
        end
    end

    if kind ~= ProductKind.Product
        or not rootPlaceId
        or (not FFlagSduiDevStoreSeeAllSupport or str1 ~= ProductPurchaseSurface.EDP)
            and (not FFlagEnableHomeGameItemOwnershipUpdate or str1 ~= ProductPurchaseSurface.HomePageGameItemShop)
            and (not FFlagEnableSearchGameItemOwnershipUpdate or str1 ~= ProductPurchaseSurface.SearchPageGameItemShop)
            and (not FFlagSduiDevStoreSeeAllSupport
                or not FFlagEnableEdpPreviewPurchaseSurface
                or str1 ~= ProductPurchaseSurface.EDPPreview)
    then
        return nil
    end

    return function()
        local localPlayer = Players.LocalPlayer
        local userId = localPlayer and localPlayer.UserId
        if userId == nil then
            return
        end
        DataHydration.Game.getGameDeveloperProductStore(false).fetchStatuses(tostring(userId), tostring(rootPlaceId))
    end
end

local function buildOnPurchaseComplete(edp: string?, rootPlaceId: string?, callback): (() -> ())? -- Luacid: Inlined by compiler; 1 call site recovered
    return if bool1 and edp == ProductPurchaseSurface.EDP and rootPlaceId then function()
        ExperienceService:LaunchExperience({ placeId = tonumber(rootPlaceId) })
        callback(CloseCentralOverlay())
    end else nil
end

local function buildOnLaunchAfterPurchase(sduiContext, analyticsContext, rootPlaceId: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    return function()
        local logger = sduiContext.dependencies.logger

        if rootPlaceId == nil then
            logger.reportError(
                SduiErrorType.InvalidActionParams,
                {
                    name = SduiActionType.OpenPurchasePrompt,
                    message = "Missing rootPlaceId for launch-after-purchase play attribution"
                },
                sduiContext.appPage
            )
            return
        end
        local analyticsFieldInAncestors = SduiCoreSystem.findAnalyticsFieldInAncestors("universeId", analyticsContext)
        if analyticsFieldInAncestors == nil or tostring(analyticsFieldInAncestors) == "" then
            logger.reportError(
                SduiErrorType.InvalidActionParams,
                {
                    name = SduiActionType.OpenPurchasePrompt,
                    message = "Missing universeId for launch-after-purchase play attribution"
                },
                sduiContext.appPage
            )
            return
        end
        sduiReportGamePlayIntent({
            sduiContext = sduiContext,
            analyticsContext = analyticsContext,
            universeId = tostring(analyticsFieldInAncestors),
            placeId = rootPlaceId,
            rootPlaceId = rootPlaceId,
            actionType = "PlayAfterPurchase"
        })
    end
end

local function buildOnFlowComplete(callback) -- Luacid: Inlined by compiler; 1 call site recovered
    return function()
        callback(CloseCentralOverlay())
    end
end

local function normalizeProductPayload(productPayload, kind: string?)
    if (kind == ProductKind.Gamepass or kind == ProductKind.Product) and typeof(productPayload.id) == "string" then
        local id = tonumber(productPayload.id)
        if id ~= nil then
            productPayload.id = id
        end
    end

    if kind ~= ProductKind.DeveloperSubscription then
        return
    end

    local expectedPrice = productPayload.expectedPrice
    if typeof(expectedPrice) == "string" then
        expectedPrice = tonumber(expectedPrice) or 0
        productPayload.expectedPrice = expectedPrice
    end
    if productPayload.isSubscriptionInRobux == nil then
        productPayload.isSubscriptionInRobux = typeof(expectedPrice) == "number" and expectedPrice > 0
    end
end

local tbl1 = {
    [ProductPurchaseSurface.HomePageGameItemShop] = "homePageGameItemShop",
    [ProductPurchaseSurface.SearchPageGameItemShop] = if FFlagEnableSearchGameItemOwnershipUpdate then "searchPageGameItemShop" else nil,
    [ProductPurchaseSurface.EDPPreview] = if FFlagEnableEdpPreviewPurchaseSurface then "experienceDetailPagePreview" else nil
}

local function buildPurchasePayload(locationType: string): string
    return HttpService:JSONEncode({ surface = { scopeType = "lua", location = { locationType = locationType } } })
end

return function(arg1, analyticsContext, sduiContext)
    local logger = sduiContext.dependencies.logger
    local appPage = sduiContext.appPage
    local dispatch = sduiContext.dependencies.dispatch

    local actionParams = arg1 and arg1.actionParams
    if actionParams == nil then
        logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenPurchasePrompt,
                message = "Missing action params"
            },
            appPage
        )

        return
    end

    local productPayload = actionParams.productPayload
    local displayInfo = actionParams.displayInfo
    local purchaseOptions = actionParams.purchaseOptions
    local purchaseAnalyticsMetadata = actionParams.purchaseAnalyticsMetadata
    local rootPlaceId = actionParams.rootPlaceId

    if productPayload == nil then
        logger.reportError(
            SduiErrorType.InvalidActionParams,
            {
                name = SduiActionType.OpenPurchasePrompt,
                message = "Missing productPayload"
            },
            appPage
        )

        return
    end

    local kind = productPayload.kind

    local var1 = productPayload.id or productPayload.subscriptionId
    normalizeProductPayload(productPayload, kind)
    local surface = purchaseAnalyticsMetadata and purchaseAnalyticsMetadata.surface

    if bool2 and surface ~= nil then
        local locationType = tbl1[surface]
        if locationType ~= nil then
            productPayload.purchasePayload = buildPurchasePayload(locationType)
        end
    end

    if purchaseOptions and purchaseOptions.enablePreloadedPurchaseUi ~= nil then
        purchaseOptions.enablePreloadedPurchaseUI = purchaseOptions.enablePreloadedPurchaseUi
        purchaseOptions.enablePreloadedPurchaseUi = nil
    end

    local tTiEventName = PurchasePromptLite.getTTIEventName(surface or "Unknown")
    TimeToInteractiveTracker.trackStart(tTiEventName)
    TimeToInteractiveTracker.updateMetadata(tTiEventName, { page = surface, category = "unified_purchase_modal" })

    dispatch(
        SetCentralOverlay(CentralOverlayType.UnifiedProductPurchaseModal, {
            productPayload = productPayload,
            purchaseCallbacks = {
                onPurchaseSuccess = buildOnPurchaseSuccess(surface, kind, var1, rootPlaceId),
                fetchProductInfo = buildFetchProductInfo(displayInfo, kind),
                onFlowComplete = buildOnFlowComplete(dispatch),
                onPurchaseComplete = buildOnPurchaseComplete(surface, rootPlaceId, dispatch),
                onLaunchAfterPurchase = if FFlagEnableLaunchAfterPurchase then buildOnLaunchAfterPurchase(sduiContext, analyticsContext, rootPlaceId) else nil
            },
            purchaseAnalyticsMetadata = purchaseAnalyticsMetadata,
            purchaseOptions = purchaseOptions
        })
    )
end

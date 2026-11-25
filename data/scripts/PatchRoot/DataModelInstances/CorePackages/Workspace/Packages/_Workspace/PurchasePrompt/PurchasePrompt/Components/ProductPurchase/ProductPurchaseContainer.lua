-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")

local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local PurchasePromptDeps = require(PurchasePromptParent.PurchasePromptDeps)
local Roact = PurchasePromptDeps.Roact
local React = require(PurchasePromptParent.React)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local CachedPolicyService = require(PurchasePromptParent.CachedPolicyService)
local RobloxTranslator = require(PurchasePromptParent.RobloxTranslator)

local UIBlox = PurchasePromptDeps.UIBlox
local InteractiveAlert = UIBlox.App.Dialog.Alert.InteractiveAlert
local ButtonType = UIBlox.App.Button.Enum.ButtonType
local Images = UIBlox.App.ImageSet.Images

local IAPExperience = require(PurchasePromptParent.IAPExperience)
local ProductPurchase = IAPExperience.ProductPurchase
local ProductPurchaseRobuxUpsell = IAPExperience.ProductPurchaseRobuxUpsell
local LeaveRobloxAlert = IAPExperience.LeaveRobloxAlert
local Animator = IAPExperience.Animator
local UnifiedProductPurchaseModal = IAPExperience.UnifiedProductPurchaseModal
local UnifiedProductPurchaseModalV2 = IAPExperience.UnifiedProductPurchaseModalV2

local RobloxSubscriptionPurchaseApp = require(PurchasePromptParent.RobloxSubscriptionPurchaseApp)
local getBlackbirdUpsellBannerProductInfo = require(PurchasePrompt.Utils.getBlackbirdUpsellBannerProductInfo)
local RobloxSubscriptionFlowCompleteReason = RobloxSubscriptionPurchaseApp.RobloxSubscriptionFlowCompleteReason
local SurfaceName = RobloxSubscriptionPurchaseApp.SurfaceName
local SurfaceContext = RobloxSubscriptionPurchaseApp.SurfaceContext
local PurchaseClientSessionIdType = RobloxSubscriptionPurchaseApp.PurchaseClientSessionIdType

local SetWindowState = require(PurchasePrompt.Actions.SetWindowState)
local PurchaseFlow = require(PurchasePrompt.Enums.PurchaseFlow)
local RequestType = require(PurchasePrompt.Enums.RequestType)
local PromptState = require(PurchasePrompt.Enums.PromptState)
local WindowState = require(PurchasePrompt.Enums.WindowState)
local PurchaseError = require(PurchasePrompt.Enums.PurchaseError)
local hideWindow = require(PurchasePrompt.Thunks.hideWindow)
local retryPurchaseAfterUpsell = require(PurchasePrompt.Thunks.retryPurchaseAfterUpsell)
local completeRequest = require(PurchasePrompt.Thunks.completeRequest)
local purchaseItem = require(PurchasePrompt.Thunks.purchaseItem)
local completePurchase = require(PurchasePrompt.Thunks.completePurchase)
local launchRobuxUpsell = require(PurchasePrompt.Thunks.launchRobuxUpsell)
local openSecuritySettings = require(PurchasePrompt.Thunks.openSecuritySettings)
local isMockingPurchases = require(PurchasePrompt.Utils.isMockingPurchases)
local connectToStore = require(PurchasePrompt.connectToStore)
local sendEvent = require(PurchasePrompt.Thunks.sendEvent)
local PublishAssetAnalytics = require(PurchasePrompt.Utils.PublishAssetAnalytics)

local ExternalEventConnection = require(PurchasePrompt.Components.Connection.ExternalEventConnection)
local LocalizationService = require(PurchasePrompt.Localization.LocalizationService)
local isGenericChallengeResponse = require(PurchasePrompt.Utils.isGenericChallengeResponse)
local SelectedRobuxPackage = require(PurchasePrompt.Utils.SelectedRobuxPackage)
local ProductPurchaseSurface = require(PurchasePromptParent.PurchasePromptLite).Enums.ProductPurchaseSurface
local logUnifiedPurchaseTelemetryCounter = require(PurchasePrompt.Utils.logUnifiedPurchaseTelemetryCounter)
local emitPerformanceMetrics = require(PurchasePrompt.Utils.emitPerformanceMetrics)

local initiateUserPurchaseSettingsPrecheck = require(PurchasePrompt.Thunks.initiateUserPurchaseSettingsPrecheck)
local VerifiedParentalConsentDialog = require(PurchasePromptParent.VerifiedParentalConsentDialog).VerifiedParentalConsentDialog
local VPCModalType = require(PurchasePrompt.Enums.VPCModalType)
local Animator2 = require(script.Parent.Animator)
local SharedFlags = require(PurchasePromptParent.SharedFlags)
local FFlagAddCursorProviderToPurchasePromptApp = SharedFlags.FFlagAddCursorProviderToPurchasePromptApp
local getUnifiedPurchaseModalType = require(PurchasePrompt.Utils.getUnifiedPurchaseModalType)
local selectProductPrice = require(PurchasePrompt.Selectors.selectProductPrice)
local selectPrice = require(PurchasePrompt.Selectors.selectPrice)
local SetPromptState = require(PurchasePrompt.Actions.SetPromptState)
local FFlagAddSurfaceAndProductTypeToPromptCounter = require(PurchasePrompt.Flags.FFlagAddSurfaceAndProductTypeToPromptCounter)

local HttpService = game:GetService("HttpService")
local SetPurchaseFlowUUID = require(PurchasePrompt.Actions.SetPurchaseFlowUUID)
local SetPostPurchaseActions = require(PurchasePrompt.Actions.SetPostPurchaseActions)
local sendUnifiedPurchaseEventLog = require(PurchasePrompt.Utils.sendUnifiedPurchaseEventLog)
local UnifiedPurchaseEventNameEnum = require(PurchasePrompt.Enums.UnifiedPurchaseEventNameEnum)
local Constants = require(PurchasePrompt.Misc.Constants)

local FFlagEnablePurchaseFlowUUIDMigration = require(PurchasePrompt.Flags.FFlagEnablePurchaseFlowUUIDMigration)
local FFlagEnableLaunchAfterPurchase = require(PurchasePromptParent.SharedFlags).FFlagEnableLaunchAfterPurchase
local ExperienceService = if FFlagEnableLaunchAfterPurchase then require(PurchasePromptParent.ExperienceService).ExperienceService else nil
local LoggingProtocol = require(PurchasePromptParent.LoggingProtocol)

local PurchaseFlowUUIDTelemetry = require(PurchasePrompt.Events.PurchaseFlowUUIDTelemetry)
local UnifiedPurchaseTelemetry = require(PurchasePrompt.Events.UnifiedPurchaseTelemetry)
local AppContext = require(PurchasePrompt.Utils.AppContext)
local fetchCartPricing = require(PurchasePrompt.Thunks.fetchCartPricing)
local fetchInGameItemCartPricing = require(PurchasePrompt.Thunks.fetchInGameItemCartPricing)
local selectCartPricingResponse = require(PurchasePrompt.Selectors.selectCartPricingResponse)
local selectIsCartPricingFetching = require(PurchasePrompt.Selectors.selectIsCartPricingFetching)

local FFlagPurchasePromptUnifiedEventsUseOfferAdjustedPrice = SharedFlags.FFlagPurchasePromptUnifiedEventsUseOfferAdjustedPrice

local FFlagPurchasePromptGamePausedOnlyHideShownWindow = require(PurchasePrompt.Flags.FFlagPurchasePromptGamePausedOnlyHideShownWindow)
local deriveCartPricingView = IAPExperience.deriveCartPricingView

local DesktopUpsellExperiment = IAPExperience.Utility.DesktopUpsellExperiment
local ProductPurchaseModal = IAPExperience.ProductPurchaseModal
local RobuxUpsellModal = IAPExperience.RobuxUpsellModal
local RobuxUpsellModalTooExpensiveFallback = IAPExperience.RobuxUpsellModalTooExpensiveFallback

local shouldShowBlackbirdUpsell = require(PurchasePrompt.Utils.shouldShowBlackbirdUpsell)
local var1 = Roact.Component:extend(script.Name)
local ProductPurchasePrompt = require(script.Parent.ProductPurchasePrompt)
local VIPServerPostPurchaseContainer = require(PurchasePrompt.Components.VIPServerPostPurchase.VIPServerPostPurchaseContainer)

local GetFFlagOpenVngTosForVngRobuxUpsell = require(PurchasePromptParent.SharedFlags).GetFFlagOpenVngTosForVngRobuxUpsell
local getAppFeaturePolicies = require(PurchasePromptParent.UniversalAppPolicy).getAppFeaturePolicies
local UnifiedPurchaseModalTypeEnum = IAPExperience.Enums.UnifiedPurchaseModalTypeEnum

local FFlagUnifiedPurchaseFlowMarketplaceUIImprovements = require(PurchasePromptParent.SharedFlags).FFlagUnifiedPurchaseFlowMarketplaceUIImprovements

local FFlagAddPerformanceMetricsToUnifiedPurchaseModal = require(PurchasePromptParent.SharedFlags).FFlagAddPerformanceMetricsToUnifiedPurchaseModal
local FFlagEnableUnifiedPurchaseFlowForDevSubs = require(PurchasePromptParent.SharedFlags).FFlagEnableUnifiedPurchaseFlowForDevSubs

local FFlagAddCenterDialogForUnifiedPurchaseModal = require(PurchasePromptParent.SharedFlags).FFlagAddCenterDialogForUnifiedPurchaseModal
local FFlagUnifiedPurchaseAddSkeleton = require(PurchasePromptParent.SharedFlags).FFlagUnifiedPurchaseAddSkeleton

local FFlagEnableSubscriptionUpsellUnifiedPurchaseEventTelemetry = require(PurchasePromptParent.SharedFlags).FFlagEnableSubscriptionUpsellUnifiedPurchaseEventTelemetry

local bool1 = game:DefineFastFlag("RemoveDelayedInputForUnifiedPurchaseModal", true)

local FFlagPurchasePromptSubtitleForTimedOptions = require(PurchasePromptParent.SharedFlags).FFlagPurchasePromptSubtitleForTimedOptions
local FFlagPurchaseModalTimedOptionExtension = require(PurchasePromptParent.SharedFlags).FFlagPurchaseModalTimedOptionExtension

local FFlagAddOnRobloxSubscriptionUpsellSuccessCallbackToUnifiedPurchaseModal = require(PurchasePromptParent.SharedFlags).FFlagAddOnRobloxSubscriptionUpsellSuccessCallbackToUnifiedPurchaseModal

local FFlagEnableBlackbirdUpsellImpressionGating = require(PurchasePromptParent.SharedFlags).FFlagEnableBlackbirdUpsellImpressionGating
local BlackbirdUpsellImpressionTracker = require(PurchasePrompt.Utils.BlackbirdUpsellImpressionTracker)
local FFlagBlackbirdUpsellGateResaleAndTimedOption = require(PurchasePrompt.Flags.FFlagBlackbirdUpsellGateResaleAndTimedOption)
local FFlagSetMenuOnPurchasePrompt = require(PurchasePrompt.Flags.FFlagSetMenuOnPurchasePrompt)
local FFlagSkipBuyDelayForExperienceShop = require(PurchasePrompt.Flags.FFlagSkipBuyDelayForExperienceShop)

local FFlagPurchasePromptIgnoreConfirmWhilePurchaseInProgress = require(PurchasePrompt.Flags.FFlagPurchasePromptIgnoreConfirmWhilePurchaseInProgress)

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(PurchasePromptParent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local function isRelevantRequestType(arg1, arg2, initializingPurchase)
    if FFlagUnifiedPurchaseAddSkeleton
        and initializingPurchase == PromptState.InitializingPurchase
        and arg2 == PurchaseFlow.RobuxUpsellV2
    then
        return true
    end

    if arg2 == PurchaseFlow.RobuxUpsellV2 or arg2 == PurchaseFlow.LargeRobuxUpsell then
        return false
    end

    return (arg1 == RequestType.Asset
        or arg1 == RequestType.Bundle
        or arg1 == RequestType.GamePass
        or arg1 == RequestType.Product
        or arg1 == RequestType.AvatarCreationFee
        or arg1 == RequestType.Experience
        or arg1 == RequestType.Look
        or FFlagEnableUnifiedPurchaseFlowForDevSubs and arg1 == RequestType.DeveloperSubscription)
        and true
        or FFlagLuaAppsEnablePromptVIPServerPurchase and arg1 == RequestType.VIPServer
end

local function isShowingVIPServerPostPurchase(props): boolean -- Luacid: Inlined by compiler; 3 call sites recovered
    return props.promptState == PromptState.PurchaseComplete and props.requestType == RequestType.VIPServer
end

local function getIsFiatProduct(developerSubscription, productInfo, productPrice: number): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if not FFlagEnableUnifiedPurchaseFlowForDevSubs or developerSubscription ~= RequestType.DeveloperSubscription then
        return false
    end

    return not (productInfo.displayPrice == nil) and productPrice == 0
end

local function promptStateToViewName(promptState) -- Luacid: Inlined by compiler; 1 call site recovered
    return ({
        [PromptState.RobuxUpsell] = "PurchaseModal",
        [PromptState.UpsellInProgress] = "RobuxPurchasePending"
    })[promptState]
end

function var1.init(arg1)
    arg1.state = {
        screenSize = Vector2.new(0, 0),
        isLuobu = false,
        analyticId = HttpService:GenerateGUID(false)
    }

    if not FFlagEnablePurchaseFlowUUIDMigration then
        arg1.props.setPurchaseFlowUUID(HttpService:GenerateGUID(false))
        LoggingProtocol.default:logRobloxTelemetryCounter(
            PurchaseFlowUUIDTelemetry.ProductPurchaseContainerMigrationCounter,
            1,
            { method = "ProductPurchaseContainerInit" }
        )
    end

    coroutine.wrap(function()
        if CachedPolicyService:IsSubjectToChinaPolicies() then
            arg1:setState({ isLuobu = true })
        end
    end)()

    function arg1.emitPurchaseFlowEvent(purchaseEventType, inputType)
        local viewName = promptStateToViewName(arg1.props.promptState)
        if not viewName then
            return
        end
        local tbl1 = {
            purchase_flow_uuid = arg1.props.purchaseFlowUUID,
            purchase_flow = "InGameRobuxUpsell",
            view_name = viewName,
            purchase_event_type = purchaseEventType,
            input_type = inputType,
            event_metadata = 0
        }
        local httpService = HttpService
        local input = {
            universe_id = tostring(game.GameId),
            item_product_id = tostring(arg1.props.productInfo.productId),
            item_name = arg1.props.productInfo.name,
            price = tostring(arg1.props.productInfo.price),
            user_balance = tostring(arg1.props.accountInfo.balance) or nil,
            package_robux_amount = tostring(arg1.props.robuxPurchaseAmount) or nil
        }
        tbl1.event_metadata = httpService:JSONEncode(input)

        arg1.props.onAnalyticEvent("UserPurchaseFlow", tbl1)
    end

    function arg1.emitUnifiedProductPurchaseFlowEvent(eventName)
        local purchaseAnalyticsMetadata = arg1.props.purchaseAnalyticsMetadata or {}
        local robuxPrice = if FFlagPurchasePromptUnifiedEventsUseOfferAdjustedPrice and arg1.props.productPrice ~= nil then arg1.props.productPrice else purchaseAnalyticsMetadata.price
        local tbl1 = {
            event_name = eventName,
            purchase_flow_uuid = purchaseAnalyticsMetadata.purchaseFlowUUID,
            product_id = purchaseAnalyticsMetadata.productId,
            product_type = purchaseAnalyticsMetadata.productType,
            product_target_id = purchaseAnalyticsMetadata.productTargetId,
            robux_price = robuxPrice,
            surface = purchaseAnalyticsMetadata.surface,
            user_roblox_balance = purchaseAnalyticsMetadata.userRobuxBalance,
            salelocation_universeid = purchaseAnalyticsMetadata.saleLocationUniverseId,
            product_universeid = purchaseAnalyticsMetadata.productUniverseId
        }
        sendUnifiedPurchaseEventLog(tbl1)
    end

    function arg1.changeScreenSize(arg2)
        if arg1.state.screenSize ~= arg2.AbsoluteSize then
            arg1:setState({ screenSize = arg2.AbsoluteSize })
        end
    end

    function arg1.isFromShopSkip(): boolean
        return not (arg1.props.productPayload == nil) and arg1.props.productPayload.isFromInExperienceShop == true
    end

    function arg1.hasDelayedInput(): boolean
        if not bool1 and arg1.props.isTestPurchase then
            return false
        end

        local promptState = arg1.props.promptState

        if promptState == PromptState.PromptPurchase
            and arg1.buyButtonUsesFoundationInputDelay
            and not (FFlagSkipBuyDelayForExperienceShop and arg1.isFromShopSkip())
        then
            return true
        end

        if bool1 then
            if FFlagSkipBuyDelayForExperienceShop
                and arg1.isFromShopSkip()
                and (promptState == PromptState.RobuxUpsell or promptState == PromptState.UpsellInProgress)
            then
                return false
            end

            return promptState == PromptState.PurchaseInProgress
                or promptState == PromptState.RobuxUpsell
                or promptState == PromptState.UpsellInProgress
        end

        if FFlagSkipBuyDelayForExperienceShop
            and arg1.isFromShopSkip()
            and (promptState == PromptState.PromptPurchase
                or promptState == PromptState.RobuxUpsell
                or promptState == PromptState.UpsellInProgress)
        then
            return false
        end

        return promptState == PromptState.PromptPurchase
            or promptState == PromptState.PurchaseInProgress
            or promptState == PromptState.RobuxUpsell
            or promptState == PromptState.UpsellInProgress
    end

    function arg1.isWindowShowAndDoneAnimating(): boolean
        return arg1.state.isAnimating == false
    end

    arg1.buyButtonUsesFoundationInputDelay = AppContext.get() == AppContext.Enum.IN_EXPERIENCE

    function arg1.canConfirmInput()
        if Players.LocalPlayer.GameplayPaused then
            return false
        end

        local var2 = arg1.isWindowShowAndDoneAnimating()

        if not arg1.hasDelayedInput() then
            return var2
        end

        local bool2 = if arg1.state.doneAnimatingTime then os.clock() - arg1.state.doneAnimatingTime > 2.5 else false
        return var2 and bool2
    end
    function arg1.getConfirmButtonAction(arg2, arg3, twoFactorNeededSettings)
        if arg2 == PromptState.None or not isRelevantRequestType(arg3) then
            return nil
        end
        if FFlagPurchasePromptIgnoreConfirmWhilePurchaseInProgress and arg2 == PromptState.PurchaseInProgress then
            return nil
        end

        if arg2 == PromptState.PromptPurchase or arg2 == PromptState.PurchaseInProgress then
            if arg1.props.isUserEligibleForUnifiedPurchaseFlow then
                local purchaseAnalyticsMetadata = arg1.props.purchaseAnalyticsMetadata or {}

                logUnifiedPurchaseTelemetryCounter(
                    UnifiedPurchaseTelemetry.UnifiedProductPurchaseModalBuyItemButtonClickedCounter,
                    purchaseAnalyticsMetadata.surface,
                    purchaseAnalyticsMetadata.productType
                )

                arg1.emitUnifiedProductPurchaseFlowEvent(UnifiedPurchaseEventNameEnum.BuyItemModalBuyClicked)
            end
            return arg1.props.onBuy
        end

        if FFlagPurchasePromptIgnoreConfirmWhilePurchaseInProgress and arg2 == PromptState.UpsellInProgress then
            return nil
        end

        if arg2 == PromptState.RobuxUpsell or arg2 == PromptState.UpsellInProgress or arg2 == PromptState.LeaveRobloxWarning then
            return arg1.props.onRobuxUpsell
        end

        if arg2 == PromptState.U13PaymentModal
            or arg2 == PromptState.U13MonthlyThreshold1Modal
            or arg2 == PromptState.U13MonthlyThreshold2Modal
            or arg2 == PromptState.ParentalConsentWarningPaymentModal13To17
        then
            return arg1.props.onScaryModalConfirm
        end

        if arg2 == PromptState.Error and twoFactorNeededSettings == PurchaseError.TwoFactorNeededSettings then
            return arg1.props.onOpenSecuritySettings
        end

        if isGenericChallengeResponse(twoFactorNeededSettings) then
            return function()
                arg1.props.onOpenSecuritySettings(twoFactorNeededSettings)
            end
        end

        return arg1.props.hideWindow
    end

    function arg1.getCancelButtonAction(none, arg2)
        return if none == PromptState.None or not isRelevantRequestType(arg2) then nil else arg1.props.hideWindow
    end

    function arg1.confirmButtonPressed()
        if arg1.props.requestType == RequestType.AvatarCreationFee and arg1.props.promptState == PromptState.PromptPurchase then
            PublishAssetAnalytics.sendButtonClicked(PublishAssetAnalytics.Section.BuyItemModal, PublishAssetAnalytics.Element.Buy)
        end

        local confirmButtonAction = arg1.getConfirmButtonAction(arg1.props.promptState, arg1.props.requestType, arg1.props.purchaseError)
        if confirmButtonAction ~= nil and arg1.canConfirmInput() then
            confirmButtonAction()
        end
    end

    function arg1.launchAfterPurchaseButtonShown()
        arg1.emitUnifiedProductPurchaseFlowEvent(UnifiedPurchaseEventNameEnum.LaunchAfterPurchaseButtonShown)
    end

    function arg1.launchAfterPurchaseButtonPressed()
        arg1.emitUnifiedProductPurchaseFlowEvent(UnifiedPurchaseEventNameEnum.LaunchAfterPurchaseButtonClicked)
        local launchAfterPurchaseRootPlaceId = arg1.props.launchAfterPurchaseRootPlaceId
        local onLaunchAfterPurchase = if FFlagEnableLaunchAfterPurchase then arg1.props.purchaseCallbacks and arg1.props.purchaseCallbacks.onLaunchAfterPurchase else nil
        arg1.confirmButtonPressed()
        task.defer(function()
            local placeId = tonumber(launchAfterPurchaseRootPlaceId)
            if placeId == nil or ExperienceService == nil then
                return
            end

            arg1.emitUnifiedProductPurchaseFlowEvent(UnifiedPurchaseEventNameEnum.ExperienceLaunchedAfterPurchase)
            if onLaunchAfterPurchase then
                onLaunchAfterPurchase()
            end
            ExperienceService:LaunchExperience({ placeId = placeId }, "PurchaseCompletionPlayButton")
        end)
    end

    function arg1.cancelButtonPressed()
        if arg1.props.requestType == RequestType.AvatarCreationFee and arg1.props.promptState == PromptState.PromptPurchase then
            PublishAssetAnalytics.sendButtonClicked(
                PublishAssetAnalytics.Section.BuyItemModal,
                PublishAssetAnalytics.Element.Cancel
            )
        end
        if arg1.props.isUserEligibleForUnifiedPurchaseFlow then
            logUnifiedPurchaseTelemetryCounter(
                UnifiedPurchaseTelemetry.UnifiedProductPurchaseModalCancelButtonClickedCounter,
                arg1.props.purchaseAnalyticsMetadata.surface,
                arg1.props.purchaseAnalyticsMetadata.productType
            )
        end
        local cancelButtonAction = arg1.getCancelButtonAction(arg1.props.promptState, arg1.props.requestType)
        if cancelButtonAction ~= nil then
            cancelButtonAction()
        end
    end

    function arg1.configContextActionService(shown)
        if shown ~= WindowState.Shown then
            ContextActionService:UnbindCoreAction("ProductPurchaseConfirmButtonBind")
            ContextActionService:UnbindCoreAction("ProductPurchaseCancelButtonBind")

            return
        end

        ContextActionService:BindCoreAction("ProductPurchaseConfirmButtonBind", function(_, userInputState, _)
            if FFlagLuaAppsEnablePromptVIPServerPurchase and isShowingVIPServerPostPurchase(arg1.props) then
                return Enum.ContextActionResult.Pass
            end
            if userInputState == Enum.UserInputState.Begin then
                arg1.confirmButtonPressed()
            end
        end, false, Enum.KeyCode.ButtonA)
        ContextActionService:BindCoreAction("ProductPurchaseCancelButtonBind", function(_, userInputState, _)
            if FFlagLuaAppsEnablePromptVIPServerPurchase and isShowingVIPServerPostPurchase(arg1.props) then
                return Enum.ContextActionResult.Pass
            end
            if userInputState == Enum.UserInputState.Begin then
                arg1.cancelButtonPressed()
            end
        end, false, Enum.KeyCode.ButtonB)
    end
    function arg1.getVPCModalType(enablePurchaseVpcModal)
        if enablePurchaseVpcModal == PromptState.EnablePurchaseVPCModal then
            return VPCModalType.toRawValue(VPCModalType.EnablePurchase)
        end
        return VPCModalType.toRawValue(VPCModalType.None)
    end

    function arg1.onBuyItemButtonMounted(arg2)
        local purchaseAnalyticsMetadata = arg1.props.purchaseAnalyticsMetadata or {}

        logUnifiedPurchaseTelemetryCounter(
            UnifiedPurchaseTelemetry.UnifiedProductPurchaseModalShownCounter,
            purchaseAnalyticsMetadata.surface,
            purchaseAnalyticsMetadata.productType
        )

        arg1.emitUnifiedProductPurchaseFlowEvent(UnifiedPurchaseEventNameEnum.BuyItemModalShown)

        if FFlagAddPerformanceMetricsToUnifiedPurchaseModal and purchaseAnalyticsMetadata and purchaseAnalyticsMetadata.surface then
            emitPerformanceMetrics(
                Constants.PerformanceMetrics.IntervalName.ProductPurchaseContainerShown,
                purchaseAnalyticsMetadata.surface
            )
        end

        if arg1.props.purchaseCallbacks and arg1.props.purchaseCallbacks.onBuyItemButtonMounted then
            arg1.props.purchaseCallbacks.onBuyItemButtonMounted(arg2)
        end
    end
end

function var1.didMount(arg1)
    local purchaseFlow = arg1.props.purchaseFlow
    local requestType = arg1.props.requestType

    if arg1.props.windowState ~= WindowState.Shown or not isRelevantRequestType(requestType, purchaseFlow) then
        return
    end

    arg1:setState({ isAnimating = true })

    arg1.configContextActionService(arg1.props.windowState)

    GuiService.SetPurchasePromptIsShown(true)
end

function var1.willUpdate(arg1, arg2)
    if arg1.props.expectedPrice ~= arg2.expectedPrice then
        arg1:setState({})
    end
end

function var1.didUpdate(arg1, arg2, _)
    if not FFlagEnablePurchaseFlowUUIDMigration
        and arg1.props.promptState ~= arg2.promptState
        and arg1.props.promptState == PromptState.None
    then
        local str1 = HttpService:GenerateGUID(false)
        arg1.props.setPurchaseFlowUUID(str1)

        LoggingProtocol.default:logRobloxTelemetryCounter(
            PurchaseFlowUUIDTelemetry.ProductPurchaseContainerMigrationCounter,
            1,
            { method = "ProductPurchaseContainerDidUpdate" }
        )
    end

    if FFlagPurchasePromptGamePausedOnlyHideShownWindow then
        if Players.LocalPlayer.GameplayPaused and arg1.props.windowState == WindowState.Shown then
            arg1.props.onAnalyticEvent("PurchasePromptGamePausedDetected", { place_id = game.PlaceId })
            arg1.props.hideWindow()
        end
    elseif Players.LocalPlayer.GameplayPaused then
        arg1.props.onAnalyticEvent("PurchasePromptGamePausedDetected", { place_id = game.PlaceId })
        arg1.props.hideWindow()
    end

    local purchaseFlow = arg1.props.purchaseFlow
    local requestType = arg1.props.requestType

    if arg2.windowState ~= arg1.props.windowState and isRelevantRequestType(requestType, purchaseFlow) then
        arg1:setState({ isAnimating = true })

        arg1.configContextActionService(arg1.props.windowState)

        GuiService:SetPurchasePromptIsShown(arg1.props.windowState == WindowState.Shown)

        if arg1.props.windowState == WindowState.Hidden then
            arg1.props.completeRequest()
        end
    end

    if requestType == RequestType.AvatarCreationFee
        and arg1.props.promptState == PromptState.PurchaseComplete
        and arg2.promptState ~= PromptState.PurchaseComplete
    then
        PublishAssetAnalytics.sendPageLoad(PublishAssetAnalytics.Section.ProcessCompleteModal)
    end

    if arg2.promptState ~= arg1.props.promptState then
        arg1.emitPurchaseFlowEvent("ViewShown")
    end
end

function var1.getMessageKeysFromPromptState(arg1)
    local promptState = arg1.props.promptState
    local productInfo = arg1.props.productInfo
    local purchaseError = arg1.props.purchaseError

    if promptState == PromptState.PurchaseComplete then
        return {
            messageText = {
                key = "CoreScripts.PurchasePrompt.PurchaseMessage.Succeeded",
                params = {
                    ITEM_NAME = productInfo.name
                }
            },
            okText = { key = "CoreScripts.PurchasePrompt.Button.OK" },
            titleText = { key = "CoreScripts.PurchasePrompt.Title.BuyItem" }
        }
    end

    if promptState == PromptState.U13PaymentModal then
        return {
            messageText = { key = "CoreScripts.PurchasePrompt.PurchaseDetails.ScaryModalOne" },
            okText = { key = "CoreScripts.PurchasePrompt.Button.OK" },
            titleText = { key = "CoreScripts.PurchasePrompt.Title.BuyItem" }
        }
    end

    if promptState == PromptState.U13MonthlyThreshold1Modal then
        return {
            messageText = { key = "CoreScripts.PurchasePrompt.PurchaseDetails.ScaryModalTwo" },
            okText = { key = "CoreScripts.PurchasePrompt.Button.OK" },
            titleText = { key = "CoreScripts.PurchasePrompt.Title.BuyItem" }
        }
    end

    if promptState == PromptState.U13MonthlyThreshold2Modal then
        return {
            messageText = { key = "CoreScripts.PurchasePrompt.PurchaseDetails.ScaryModalParental" },
            okText = { key = "CoreScripts.PurchasePrompt.Button.OK" },
            titleText = { key = "CoreScripts.PurchasePrompt.Title.BuyItem" }
        }
    end

    if promptState == PromptState.ParentalConsentWarningPaymentModal13To17 then
        return {
            messageText = { key = "CoreScripts.PurchasePrompt.PurchaseDetails.ParentalConsent" },
            okText = { key = "CoreScripts.PurchasePrompt.Button.OK" },
            titleText = { key = "CoreScripts.PurchasePrompt.Title.BuyItem" }
        }
    end

    if promptState ~= PromptState.Error then
        return
    end

    if purchaseError == PurchaseError.UnknownFailure then
        return {
            messageText = {
                key = LocalizationService.getErrorKey(purchaseError),
                params = {
                    ITEM_NAME = productInfo.name
                }
            },
            okText = { key = "CoreScripts.PurchasePrompt.Button.OK" },
            titleText = { key = "CoreScripts.PremiumModal.Title.Error" }
        }
    end

    if purchaseError ~= PurchaseError.TwoFactorNeededSettings and not isGenericChallengeResponse(purchaseError) then
        return {
            messageText = {
                key = LocalizationService.getErrorKey(purchaseError)
            },
            okText = { key = "CoreScripts.PurchasePrompt.Button.OK" },
            titleText = { key = "CoreScripts.PremiumModal.Title.Error" }
        }
    end

    return {
        messageText = { key = "CoreScripts.PurchasePrompt.PurchaseFailed.Enable2SVLogout" },
        okText = { key = "CoreScripts.PurchasePrompt.Button.Settings" },
        cancelText = { key = "CoreScripts.PurchasePrompt.CancelPurchase.Cancel" },
        titleText = { key = "CoreScripts.PurchasePrompt.Title.VerificationRequired" }
    }
end

function var1.determinePrompt(arg1)
    local purchaseFlow = arg1.props.purchaseFlow
    local promptState = arg1.props.promptState
    local requestType = arg1.props.requestType
    local purchaseError = arg1.props.purchaseError

    local productInfo = arg1.props.productInfo
    local accountInfo = arg1.props.accountInfo
    local isTestPurchase = arg1.props.isTestPurchase

    if arg1.props.windowState ~= WindowState.Shown then
        return nil
    end

    if promptState ~= PromptState.None then
        local func1 = isRelevantRequestType

        if func1(requestType, purchaseFlow, if FFlagUnifiedPurchaseAddSkeleton then promptState else nil) then
            if promptState ~= PromptState.PromptPurchase
                and promptState ~= PromptState.PurchaseInProgress
                and (not FFlagUnifiedPurchaseAddSkeleton or promptState ~= PromptState.InitializingPurchase)
            then
                if promptState == PromptState.RobuxUpsell or promptState == PromptState.UpsellInProgress then
                    if DesktopUpsellExperiment.shouldShowNewModal() then
                        local createElement = Roact.createElement
                        local var2 = RobuxUpsellModal
                        local tbl1 = {
                            screenSize = arg1.state.screenSize,
                            product = {
                                model = arg1.props.humanoidModel,
                                itemIcon = productInfo.imageUrl,
                                itemName = productInfo.name,
                                itemRobuxCost = arg1.props.productPrice
                            },
                            upsell = {
                                balanceAmount = accountInfo.balance,
                                robuxPurchaseAmount = arg1.props.robuxPurchaseAmount,
                                robuxPurchaseAmountBeforeBonus = arg1.props.robuxAmountBeforeBonus,
                                robuxPurchaseCost = arg1.props.robuxPurchaseCost
                            },
                            buttons = 0
                        }

                        local buttons = {
                            buyItemActivated = function()
                                arg1.confirmButtonPressed()
                                arg1.emitPurchaseFlowEvent("UserInput", "Buy")
                            end,
                            buyItemDisabled = promptState == PromptState.UpsellInProgress,
                            buyItemControllerIcon = if arg1.props.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png" else nil,
                            buyItemisDelayedInput = arg1.hasDelayedInput(),
                            buyItemEnableInputDelayed = arg1.isWindowShowAndDoneAnimating() and not (FFlagSkipBuyDelayForExperienceShop and arg1.isFromShopSkip()),
                            cancelPurchaseActivated = 0,
                            cancelControllerIcon = 0,
                            opensBuyRobuxPage = 0
                        }

                        function buttons.cancelPurchaseActivated()
                            arg1.cancelButtonPressed()
                            arg1.emitPurchaseFlowEvent("UserInput", "Cancel")
                        end
                        buttons.cancelControllerIcon = if arg1.props.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonB.png" else nil
                        buttons.opensBuyRobuxPage = DesktopUpsellExperiment.getVariant() == DesktopUpsellExperiment.variants.OpenRobuxStore
                        tbl1.buttons = buttons
                        return createElement(var2, tbl1)
                    end

                    local createElement = Roact.createElement
                    local var2 = ProductPurchaseRobuxUpsell
                    local tbl1 = {
                        screenSize = arg1.state.screenSize,
                        isDisabled = promptState == PromptState.UpsellInProgress,
                        model = arg1.props.humanoidModel,
                        itemIcon = productInfo.imageUrl,
                        itemName = productInfo.name,
                        itemRobuxCost = arg1.props.productPrice,
                        robuxPurchaseAmount = arg1.props.robuxPurchaseAmount,
                        robuxPurchaseAmountBeforeBonus = arg1.props.robuxAmountBeforeBonus,
                        balanceAmount = accountInfo.balance,
                        isDelayedInput = arg1.hasDelayedInput(),
                        enableInputDelayed = arg1.isWindowShowAndDoneAnimating() and not (FFlagSkipBuyDelayForExperienceShop and arg1.isFromShopSkip()),
                        buyItemControllerIcon = if arg1.props.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png" else nil,
                        cancelControllerIcon = if arg1.props.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonB.png" else nil,
                        buyItemActivated = 0,
                        cancelPurchaseActivated = 0,
                        isLuobu = 0,
                        isVng = 0
                    }
                    function tbl1.buyItemActivated()
                        arg1.confirmButtonPressed()
                        arg1.emitPurchaseFlowEvent("UserInput", "Buy")
                    end
                    function tbl1.cancelPurchaseActivated()
                        arg1.cancelButtonPressed()
                        arg1.emitPurchaseFlowEvent("UserInput", "Cancel")
                    end
                    tbl1.isLuobu = arg1.state.isLuobu
                    tbl1.isVng = GetFFlagOpenVngTosForVngRobuxUpsell() and getAppFeaturePolicies().getShowVNGTosForRobuxUpsell()
                    return createElement(var2, tbl1)
                end
                if promptState == PromptState.LeaveRobloxWarning then
                    return Roact.createElement(LeaveRobloxAlert, {
                        screenSize = arg1.state.screenSize,
                        cancelActivated = arg1.cancelButtonPressed,
                        continueActivated = arg1.confirmButtonPressed
                    })
                end

                if FFlagLuaAppsEnablePromptVIPServerPurchase and isShowingVIPServerPostPurchase(arg1.props) then
                    return React.createElement(VIPServerPostPurchaseContainer, { onClose = arg1.props.hideWindow })
                end
                if promptState == PromptState.PurchaseComplete and requestType == RequestType.AvatarCreationFee then
                    return Roact.createElement(InteractiveAlert, {
                        bodyText = RobloxTranslator:FormatByKey("CoreScripts.PublishAvatarPrompt.PurchaseCompleteDescription"),
                        buttonStackInfo = {
                            buttons = {{
                                buttonType = ButtonType.PrimarySystem,
                                props = {
                                    onActivated = arg1.confirmButtonPressed,
                                    text = RobloxTranslator:FormatByKey("CoreScripts.PublishAssetPrompt.ResultModalOk"),
                                    inputIcon = if arg1.props.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png" else nil
                                }
                            }}
                        },
                        screenSize = arg1.state.screenSize,
                        title = RobloxTranslator:FormatByKey("CoreScripts.BulkPurchasePrompt.CompletedPrompt.SuccessHeading")
                    })
                end
                if promptState == PromptState.Error and purchaseError == PurchaseError.TwoFactorNeededSettings
                    or isGenericChallengeResponse(purchaseError)
                then
                    return React.createElement(ProductPurchasePrompt, {
                        screenSize = arg1.state.screenSize,
                        titleIcon = Images["icons/status/error_large"],
                        promptState = promptState,
                        productInfo = productInfo,
                        purchaseError = purchaseError,
                        economicRestrictionError = arg1.props.economicRestrictionError or {},
                        isGamepadEnabled = arg1.props.isGamepadEnabled,
                        cancelButtonPressed = arg1.cancelButtonPressed,
                        confirmButtonPressed = arg1.confirmButtonPressed,
                        includeCancelButton = true,
                        isGenericChallengeResponse = isGenericChallengeResponse,
                        useUnifiedPurchaseCompletionModal = arg1.props.isUserEligibleForUnifiedPurchaseFlow,
                        surface = if FFlagAddSurfaceAndProductTypeToPromptCounter then arg1.props.purchaseAnalyticsMetadata and arg1.props.purchaseAnalyticsMetadata.surface else nil,
                        productType = if FFlagAddSurfaceAndProductTypeToPromptCounter then arg1.props.purchaseAnalyticsMetadata and arg1.props.purchaseAnalyticsMetadata.productType else nil
                    })
                end

                if promptState == PromptState.EnablePurchaseVPCModal then
                    return Roact.createElement(Animator, {
                        shouldAnimate = true,
                        shouldShow = promptState == PromptState.EnablePurchaseVPCModal,
                        renderChildren = function()
                            return Roact.createElement(VerifiedParentalConsentDialog, {
                                screenSize = arg1.state.screenSize,
                                isActionable = false,
                                modalType = arg1.getVPCModalType(promptState),
                                onDismiss = function()
                                    arg1.confirmButtonPressed()
                                end
                            })
                        end
                    })
                end
                if promptState == PromptState.Error
                    and purchaseError == PurchaseError.NotEnoughRobuxXbox
                    and DesktopUpsellExperiment.shouldShowNewModal()
                then
                    return Roact.createElement(RobuxUpsellModalTooExpensiveFallback, {
                        screenSize = arg1.state.screenSize,
                        product = {
                            itemIcon = productInfo.imageUrl,
                            itemName = productInfo.name,
                            itemRobuxCost = arg1.props.productPrice
                        },
                        balanceAmount = accountInfo.balance,
                        doneActivated = function()
                            arg1.cancelButtonPressed()
                            arg1.emitPurchaseFlowEvent("UserInput", "Cancel")
                        end
                    })
                end

                local bool2 = FFlagEnableLaunchAfterPurchase

                if bool2 then
                    if promptState == PromptState.PurchaseComplete then
                        bool2 = arg1.props.launchAfterPurchaseRootPlaceId ~= nil
                    else
                        bool2 = false
                    end
                end

                return React.createElement(ProductPurchasePrompt, {
                    screenSize = arg1.state.screenSize,
                    promptState = promptState,
                    productInfo = productInfo,
                    purchaseError = purchaseError,
                    economicRestrictionError = arg1.props.economicRestrictionError or {},
                    isGamepadEnabled = arg1.props.isGamepadEnabled,
                    cancelButtonPressed = arg1.cancelButtonPressed,
                    confirmButtonPressed = arg1.confirmButtonPressed,
                    includeCancelButton = false,
                    isGenericChallengeResponse = isGenericChallengeResponse,
                    useUnifiedPurchaseCompletionModal = arg1.props.isUserEligibleForUnifiedPurchaseFlow,
                    isMultiItem = getUnifiedPurchaseModalType(arg1.props.requestType) == UnifiedPurchaseModalTypeEnum.MultiItem,
                    timedOptionDays = if FFlagPurchasePromptSubtitleForTimedOptions then arg1.props.timedOptionDays else nil,
                    completionMessage = if FFlagPurchaseModalTimedOptionExtension then arg1.props.completionMessage else nil,
                    launchAfterPurchaseButtonPressed = if bool2 then arg1.launchAfterPurchaseButtonPressed else nil,
                    launchAfterPurchaseButtonShown = if bool2 then arg1.launchAfterPurchaseButtonShown else nil,
                    surface = if FFlagAddSurfaceAndProductTypeToPromptCounter then arg1.props.purchaseAnalyticsMetadata and arg1.props.purchaseAnalyticsMetadata.surface else nil,
                    productType = if FFlagAddSurfaceAndProductTypeToPromptCounter then arg1.props.purchaseAnalyticsMetadata and arg1.props.purchaseAnalyticsMetadata.productType else nil
                })
            end

            if arg1.props.isUserEligibleForUnifiedPurchaseFlow then
                local isFiatProduct = getIsFiatProduct(requestType, productInfo, arg1.props.productPrice)

                local function onBlackbirdUpsellActivated()
                    arg1.props.setPromptState(PromptState.BlackbirdUpsellInProgress)
                    arg1.props.setWindowState(WindowState.Suspended)

                    local purchaseFlowUuid = arg1.props.purchaseFlowUUID
                    local clientSessionId = purchaseFlowUuid and purchaseFlowUuid ~= "" and purchaseFlowUuid or nil
                    local var2 = clientSessionId
                        and {
                            clientSessionIdType = PurchaseClientSessionIdType.PurchaseFlowUUID,
                            clientSessionId = clientSessionId
                        }
                        or nil

                    RobloxSubscriptionPurchaseApp.initiateRobloxSubscriptionPurchase(
                        { showBackButton = true },
                        {
                            onFlowComplete = function(arg2)
                                if arg2 == RobloxSubscriptionFlowCompleteReason.UpsellPurchaseSucceeded then
                                    if FFlagAddOnRobloxSubscriptionUpsellSuccessCallbackToUnifiedPurchaseModal
                                        and arg1.props.purchaseCallbacks
                                        and arg1.props.purchaseCallbacks.onRobloxSubscriptionUpsellSuccess
                                    then
                                        arg1.props.purchaseCallbacks.onRobloxSubscriptionUpsellSuccess()
                                    end
                                    arg1.props.retryPurchaseAfterUpsell()
                                elseif arg2 == RobloxSubscriptionFlowCompleteReason.UpsellDismissed
                                    or arg2 == RobloxSubscriptionFlowCompleteReason.UpsellPurchaseFailed
                                then
                                    arg1.props.completeRequest()
                                else
                                    arg1.props.completeRequest()
                                end
                            end,
                            onBackButtonActivated = function()
                                arg1.props.setPromptState(PromptState.PromptPurchase)
                                arg1.props.setWindowState(WindowState.Shown)
                            end
                        },
                        nil,
                        SurfaceName.UnifiedProductPurchaseModal,
                        if AppContext.get() == AppContext.Enum.IN_APP then SurfaceContext.InApp else SurfaceContext.InGame,
                        nil,
                        var2 and { clientSessionId = var2 } or nil
                    )
                end

                local price = if isFiatProduct then nil else arg1.props.price
                local var2 = deriveCartPricingView(arg1.props.cartPricingResponse)
                local unifiedPurchaseModalType = getUnifiedPurchaseModalType(requestType)
                local productPrice = arg1.props.productPrice
                if not isFiatProduct and var2 ~= nil and unifiedPurchaseModalType == UnifiedPurchaseModalTypeEnum.MultiItem then
                    productPrice = var2.priceAfterDiscount
                end

                local blackbirdUpsellBannerProductInfo = if shouldShowBlackbirdUpsell(
                    price,
                    arg1.props.requestType,
                    isFiatProduct,
                    if FFlagBlackbirdUpsellGateResaleAndTimedOption then arg1.props.productPayload else nil
                )
                    and arg1.props.robloxSubscriptionProducts then getBlackbirdUpsellBannerProductInfo(arg1.props.robloxSubscriptionProducts) else nil

                local function func3(arg2)
                    arg1.onBuyItemButtonMounted(arg2)
                    if FFlagEnableSubscriptionUpsellUnifiedPurchaseEventTelemetry and blackbirdUpsellBannerProductInfo then
                        arg1.emitUnifiedProductPurchaseFlowEvent(UnifiedPurchaseEventNameEnum.SubscriptionUpsellBannerShown)
                    end
                    if FFlagEnableBlackbirdUpsellImpressionGating and blackbirdUpsellBannerProductInfo then
                        BlackbirdUpsellImpressionTracker.incrementImpressionCount()
                    end
                end

                if not (FFlagEnableSubscriptionUpsellUnifiedPurchaseEventTelemetry or FFlagEnableBlackbirdUpsellImpressionGating) then
                    func3 = arg1.onBuyItemButtonMounted
                end
                local function onCartOfferAppliedChanged(_: boolean, tbl1)
                    if tbl1 == nil then
                        return
                    end

                    local requestType2 = arg1.props.requestType
                    if requestType2 == RequestType.GamePass or requestType2 == RequestType.Product then
                        arg1.props.fetchInGameItemCartPricing(tbl1)
                        return
                    end
                    arg1.props.fetchCartPricing(tbl1)
                end

                if FFlagAddCenterDialogForUnifiedPurchaseModal and AppContext.get() == AppContext.Enum.IN_APP then
                    local createElement = Roact.createElement
                    local var3 = UnifiedProductPurchaseModalV2
                    local tbl1 = {
                        product = 0,
                        subtitleView = 0,
                        buttons = 0,
                        postPurchaseActions = 0,
                        setPostPurchaseActions = 0,
                        onBuyItemButtonMounted = 0,
                        purchaseModalType = 0,
                        robuxBalanceAmount = 0,
                        isTestPurchase = 0,
                        isLoading = 0,
                        isCartPricingLoading = 0,
                        onBlackbirdUpsellActivated = 0,
                        BlackbirdUpsellBannerProductInfo = 0,
                        cartPricingResponse = 0,
                        onCartOfferAppliedChanged = 0
                    }
                    local product = {
                        itemIcon = productInfo.imageUrl,
                        itemName = productInfo.name,
                        itemRobuxCost = 0,
                        itemDisplayPrice = 0,
                        itemPrice = 0,
                        model = 0
                    }

                    if isFiatProduct then
                        productPrice = nil
                    end

                    product.itemRobuxCost = productPrice
                    product.itemDisplayPrice = if isFiatProduct then productInfo.displayPrice else nil
                    product.itemPrice = price
                    product.model = arg1.props.humanoidModel
                    tbl1.product = product

                    tbl1.subtitleView = if FFlagPurchasePromptSubtitleForTimedOptions then arg1.props.subtitleView else nil
                    local buttons = {
                        buyItemActivated = arg1.confirmButtonPressed,
                        buyItemEnableInputDelayed = arg1.isWindowShowAndDoneAnimating()
                            and arg1.buyButtonUsesFoundationInputDelay
                            and not (FFlagSkipBuyDelayForExperienceShop and arg1.isFromShopSkip()),
                        cancelActivated = arg1.cancelButtonPressed,
                        isDisabled = promptState == PromptState.PurchaseInProgress
                    }
                    tbl1.buttons = buttons

                    tbl1.postPurchaseActions = arg1.props.postPurchaseActions
                    tbl1.setPostPurchaseActions = arg1.props.setPostPurchaseActions
                    tbl1.onBuyItemButtonMounted = func3
                    tbl1.purchaseModalType = getUnifiedPurchaseModalType(arg1.props.requestType)
                    tbl1.robuxBalanceAmount = accountInfo.balance
                    tbl1.isTestPurchase = isTestPurchase
                    tbl1.isLoading = if FFlagUnifiedPurchaseAddSkeleton then promptState == PromptState.InitializingPurchase else nil

                    tbl1.isCartPricingLoading = arg1.props.isCartPricingLoading
                    tbl1.onBlackbirdUpsellActivated = onBlackbirdUpsellActivated
                    tbl1.BlackbirdUpsellBannerProductInfo = blackbirdUpsellBannerProductInfo
                    tbl1.cartPricingResponse = arg1.props.cartPricingResponse
                    tbl1.onCartOfferAppliedChanged = onCartOfferAppliedChanged
                    return createElement(var3, tbl1)
                end

                local createElement = Roact.createElement
                local var3 = UnifiedProductPurchaseModal
                local tbl1 = {
                    product = {
                        itemIcon = productInfo.imageUrl,
                        itemName = productInfo.name,
                        itemRobuxCost = if isFiatProduct then nil else arg1.props.productPrice,
                        itemDisplayPrice = if isFiatProduct then productInfo.displayPrice else nil,
                        itemPrice = price,
                        model = arg1.props.humanoidModel
                    },
                    buttons = 0,
                    postPurchaseActions = 0,
                    setPostPurchaseActions = 0,
                    onBuyItemButtonMounted = 0,
                    purchaseModalType = 0,
                    robuxBalanceAmount = 0,
                    isTestPurchase = 0,
                    isMonthlyPrice = 0,
                    isFreeWithRobloxPlus = 0,
                    isCartPricingLoading = 0,
                    onBlackbirdUpsellActivated = 0,
                    BlackbirdUpsellBannerProductInfo = 0,
                    cartPricingResponse = 0,
                    onCartOfferAppliedChanged = 0,
                    hideUserRobuxBalance = 0
                }
                local buttons = {
                    buyItemActivated = arg1.confirmButtonPressed,
                    buyItemEnableInputDelayed = arg1.isWindowShowAndDoneAnimating()
                        and arg1.buyButtonUsesFoundationInputDelay
                        and not (FFlagSkipBuyDelayForExperienceShop and arg1.isFromShopSkip()),
                    cancelActivated = arg1.cancelButtonPressed,
                    isDisabled = promptState == PromptState.PurchaseInProgress
                }
                tbl1.buttons = buttons

                tbl1.postPurchaseActions = arg1.props.postPurchaseActions
                tbl1.setPostPurchaseActions = arg1.props.setPostPurchaseActions
                tbl1.onBuyItemButtonMounted = func3
                tbl1.purchaseModalType = getUnifiedPurchaseModalType(arg1.props.requestType)
                tbl1.robuxBalanceAmount = accountInfo.balance
                tbl1.isTestPurchase = isTestPurchase
                tbl1.isMonthlyPrice = if FFlagLuaAppsEnablePromptVIPServerPurchase then productInfo.isMonthlyPrice else nil
                tbl1.isFreeWithRobloxPlus = if FFlagLuaAppsEnablePromptVIPServerPurchase then productInfo.isFreeWithRobloxPlus else nil

                tbl1.isCartPricingLoading = arg1.props.isCartPricingLoading
                tbl1.onBlackbirdUpsellActivated = onBlackbirdUpsellActivated
                tbl1.BlackbirdUpsellBannerProductInfo = blackbirdUpsellBannerProductInfo
                tbl1.cartPricingResponse = arg1.props.cartPricingResponse
                tbl1.onCartOfferAppliedChanged = onCartOfferAppliedChanged

                if not isFiatProduct then
                    if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then
                        isFiatProduct = arg1.props.purchaseAnalyticsMetadata and arg1.props.purchaseAnalyticsMetadata.surface == ProductPurchaseSurface.Catalog
                    else
                        isFiatProduct = nil
                    end
                end

                tbl1.hideUserRobuxBalance = isFiatProduct
                return createElement(var3, tbl1)
            elseif DesktopUpsellExperiment.shouldShowNewModal() then
                return Roact.createElement(ProductPurchaseModal, {
                    screenSize = arg1.state.screenSize,
                    product = {
                        itemIcon = productInfo.imageUrl,
                        itemName = productInfo.name,
                        itemRobuxCost = arg1.props.productPrice
                    },
                    balanceAmount = accountInfo.balance,
                    balanceAmountValid = game:DefineFastFlag("BalanceNotShowingInExperimentIssueFix", false) and not accountInfo.hasFailed,
                    buttons = {
                        isDisabled = promptState == PromptState.PurchaseInProgress,
                        buyItemActivated = arg1.confirmButtonPressed,
                        buyItemControllerIcon = if arg1.props.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png" else nil,
                        buyItemIsDelayedInput = arg1.hasDelayedInput(),
                        buyItemEnableInputDelayed = arg1.isWindowShowAndDoneAnimating(),
                        cancelActivated = arg1.cancelButtonPressed
                    }
                })
            else
                return Roact.createElement(ProductPurchase, {
                    screenSize = arg1.state.screenSize,
                    isDisabled = promptState == PromptState.PurchaseInProgress,
                    model = arg1.props.humanoidModel,
                    itemIcon = productInfo.imageUrl,
                    itemName = productInfo.name,
                    itemRobuxCost = arg1.props.productPrice,
                    currentBalance = accountInfo.balance,
                    currentBalanceValid = not accountInfo.hasFailed,
                    testPurchase = isTestPurchase,
                    isDelayedInput = arg1.hasDelayedInput(),
                    enableInputDelayed = arg1.isWindowShowAndDoneAnimating(),
                    buyItemControllerIcon = if arg1.props.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonA.png" else nil,
                    cancelControllerIcon = if arg1.props.isGamepadEnabled then "rbxasset://textures/ui/Controls/DesignSystem/ButtonB.png" else nil,
                    buyItemActivated = arg1.confirmButtonPressed,
                    cancelPurchaseActivated = arg1.cancelButtonPressed,
                    isLuobu = arg1.state.isLuobu
                })
            end
        end
    end

    return nil
end

function var1.render(arg1)
    local promptState = arg1.props.promptState
    local prompt = arg1:determinePrompt()

    if FFlagSetMenuOnPurchasePrompt then
        if prompt ~= nil then
            arg1.menuOpenedBySelf = true
        end
        GuiService:SetMenuIsOpen(prompt ~= nil, "ProductPurchaseContainer")
    end

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 1, 0),
        [Roact.Change.AbsoluteSize] = arg1.changeScreenSize,
        BackgroundTransparency = 1
    }

    local tbl2 = {
        Animator = Roact.createElement(Animator2, {
            shouldShow = arg1.props.windowState == WindowState.Shown,
            onShown = function()
                if arg1.props.requestType == RequestType.AvatarCreationFee and promptState == PromptState.PromptPurchase then
                    PublishAssetAnalytics.sendPageLoad(PublishAssetAnalytics.Section.BuyItemModal)
                end
                arg1:setState({ isAnimating = false, doneAnimatingTime = os.clock() })
            end,
            onHidden = function()
                arg1:setState({ isAnimating = nil, doneAnimatingTime = nil })
            end,
            skipAnimation = arg1.props.isUserEligibleForUnifiedPurchaseFlow,
            [Roact.Ref] = arg1.animatorRef
        }, {
            Prompt = prompt,
            ModalFix = if prompt == nil then nil else Roact.createElement("ImageButton", { BackgroundTransparency = 0, Modal = true, Size = UDim2.new(0, 0, 0, 0) }) or nil
        }),
        OnCoreGuiMenuOpened = Roact.createElement(ExternalEventConnection, {
            event = GuiService.MenuOpened,
            callback = function()
                if FFlagSetMenuOnPurchasePrompt and arg1.menuOpenedBySelf then
                    arg1.menuOpenedBySelf = false
                    return
                end
                if arg1.props.hideWindow then
                    arg1.props.hideWindow()
                end
            end
        }),
        OnUserGuiRenderingChanged = Roact.createElement(ExternalEventConnection, {
            event = CoreGui.UserGuiRenderingChanged,
            callback = function(arg2, arg3)
                if not (arg2 and arg3) then
                    arg1.props.hideWindow()
                end
            end
        })
    }

    return createElement(str1, tbl1, tbl2)
end

return (connectToStore(function(arg1) -- name: mapStateToProps
    local isTestPurchase = isMockingPurchases(arg1.promptRequest.requestType)
    local desktopUpsellExpVariant = if arg1.abVariations then arg1.abVariations.DesktopUpsellExpVariant else nil
    return {
        purchaseFlowUUID = arg1.purchaseFlowUUID,
        purchaseFlow = arg1.purchaseFlow,
        promptState = arg1.promptState,
        requestType = arg1.promptRequest.requestType,
        humanoidModel = arg1.promptRequest.humanoidModel,
        expectedPrice = arg1.promptRequest.expectedPrice,
        windowState = arg1.windowState,
        purchaseError = arg1.purchaseError,
        economicRestrictionError = arg1.economicRestrictionError,
        productInfo = arg1.productInfo,
        accountInfo = arg1.accountInfo,
        robuxPurchaseAmount = SelectedRobuxPackage.getRobuxPurchaseAmount(arg1),
        robuxAmountBeforeBonus = SelectedRobuxPackage.getRobuxAmountBeforeBonus(arg1),
        robuxPurchaseCost = SelectedRobuxPackage.getPrice(arg1),
        isTestPurchase = isTestPurchase,
        isGamepadEnabled = arg1.gamepadEnabled,
        desktopUpsellExpVariant = desktopUpsellExpVariant,
        postPurchaseActions = arg1.postPurchaseActions,
        purchaseCallbacks = arg1.purchaseCallbacks,
        isUserEligibleForUnifiedPurchaseFlow = arg1.isUserEligibleForUnifiedPurchaseFlow,
        purchaseAnalyticsMetadata = arg1.purchaseAnalyticsMetadata,
        productPrice = selectProductPrice(arg1),
        price = if selectPrice then selectPrice(arg1) else nil,
        timedOptionDays = if FFlagPurchasePromptSubtitleForTimedOptions and arg1.productPayload then arg1.productPayload.timedOptionDays else nil,
        completionMessage = if FFlagPurchaseModalTimedOptionExtension and arg1.purchaseOptions then arg1.purchaseOptions.completionMessage else nil,
        launchAfterPurchaseRootPlaceId = if FFlagEnableLaunchAfterPurchase
            and arg1.purchaseOptions
            and arg1.purchaseOptions.launchAfterPurchaseRootPlaceId ~= nil
            and arg1.purchaseOptions.launchAfterPurchaseRootPlaceId ~= "" then arg1.purchaseOptions.launchAfterPurchaseRootPlaceId else nil,
        robloxSubscriptionProducts = arg1.robloxSubscriptionProducts,
        productPayload = if FFlagBlackbirdUpsellGateResaleAndTimedOption or FFlagSkipBuyDelayForExperienceShop then arg1.productPayload else nil,
        cartPricingResponse = selectCartPricingResponse(arg1),
        isCartPricingLoading = selectIsCartPricingFetching(arg1)
    }
end, function(callback) -- name: mapDispatchToProps
    return {
        setPurchaseFlowUUID = function(arg1)
            callback(SetPurchaseFlowUUID(arg1))
        end,
        onBuy = function()
            callback(purchaseItem())
        end,
        completePurchase = function()
            callback(completePurchase())
        end,
        onScaryModalConfirm = function()
            callback(launchRobuxUpsell())
        end,
        onOpenSecuritySettings = function(str1: string?)
            if str1 then
                callback(openSecuritySettings(str1))
                return
            end
            callback(openSecuritySettings())
        end,
        onRobuxUpsell = function()
            callback(initiateUserPurchaseSettingsPrecheck())
        end,
        hideWindow = function()
            callback(hideWindow())
        end,
        retryPurchaseAfterUpsell = function()
            callback(retryPurchaseAfterUpsell())
        end,
        setWindowState = function(arg1)
            callback(SetWindowState(arg1))
        end,
        completeRequest = function()
            if FFlagAddCursorProviderToPurchasePromptApp then
                GuiService.SelectedCoreObject = nil
            end
            callback(completeRequest())
        end,
        onAnalyticEvent = function(arg1, arg2)
            callback(sendEvent(arg1, arg2))
        end,
        setPostPurchaseActions = function(arg1)
            callback(SetPostPurchaseActions(arg1))
        end,
        setPromptState = function(arg1)
            callback(SetPromptState(arg1))
        end,
        fetchCartPricing = function(tbl1)
            callback(fetchCartPricing(tbl1))
        end,
        fetchInGameItemCartPricing = function(tbl1)
            callback(fetchInGameItemCartPricing(tbl1))
        end
    }
end)(var1))

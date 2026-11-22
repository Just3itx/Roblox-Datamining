-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local ContextActionService = game:GetService("ContextActionService")

local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)

local RobuxUpsellFlowState = require(scriptParent.RobuxUpsellFlowState)

local _VirtualItemBadgeType = require(scriptParentParentParent.Enums.VirtualItemBadgeType)

local Animator = require(scriptParentParentParent.Generic.Animator)
local Constants = require(scriptParentParentParent.Generic.Constants)
local LoadingOverlay = require(scriptParentParentParent.Generic.LoadingOverlay)
local LoadingOverlayState = require(scriptParentParentParent.Generic.LoadingOverlayState)
local PurchaseErrorPrompt = require(scriptParentParentParent.Generic.PurchaseErrorPrompt)
local PurchaseErrorType = require(scriptParentParentParent.Enums.PurchaseErrorType)
local U13ConfirmPrompt = require(scriptParentParentParent.Generic.U13ConfirmPrompt)
local TwoStepReqPrompt = require(scriptParentParentParent.Generic.TwoStepReqPrompt)
local InsufficientRobuxPrompt = require(scriptParentParentParent.Generic.InsufficientRobuxPrompt)

local InsufficientRobuxProductPrompt = require(scriptParentParentParent.ProductPurchaseRobuxUpsell.InsufficientRobuxProductPrompt)
local LeaveRobloxPrompt = require(scriptParentParentParent.Generic.LeaveRobloxPrompt)
local RobuxUpsellSuccessPrompt = require(scriptParentParentParent.ProductPurchaseRobuxUpsell.RobuxUpsellSuccessPrompt)
local RobuxUpsellPrompt = require(scriptParentParentParent.ProductPurchaseRobuxUpsell.RobuxUpsellPrompt)
local RobuxUpsellModal = require(scriptParentParentParent.ProductPurchaseRobuxUpsell.v2.RobuxUpsellModal)

local RobuxUpsellModalMultiplePackage = require(scriptParentParentParent.ProductPurchaseRobuxUpsell.v2.RobuxUpsellModalMultiplePackage)

local RobuxUpsellModalTooExpensive = require(scriptParentParentParent.ProductPurchaseRobuxUpsell.v2.RobuxUpsellModalTooExpensive)

local RobuxUpsellModalTooExpensiveFallback = require(scriptParentParentParent.ProductPurchaseRobuxUpsell.v2.RobuxUpsellModalTooExpensiveFallback)
local UnifiedRobuxUpsellModal = require(scriptParentParentParent.ProductPurchaseRobuxUpsell.v3.UnifiedRobuxUpsellModal)

local UnifiedRobuxUpsellModalTooExpensive = require(scriptParentParentParent.ProductPurchaseRobuxUpsell.v3.UnifiedRobuxUpsellModalTooExpensive)
local PurchasePromptLite = require(scriptParentParentParentParent.PurchasePromptLite)
local getTTIEventName = PurchasePromptLite.getTTIEventName
local TimeToInteractiveTracker = require(scriptParentParentParentParent.TimeToInteractiveTracker).TimeToInteractiveTracker
local ProductPurchaseSurface = PurchasePromptLite.Enums.ProductPurchaseSurface
local getModalShownEventData = require(scriptParentParentParent.Utility.getModalShownEventData)
local getUserInputEventData = require(scriptParentParentParent.Utility.getUserInputEventData)

local shouldShowNewUpsellModalExperiment = require(scriptParentParentParent.Utility.Experiments.shouldShowNewUpsellModalExperiment)
local overlayInGameMenu = require(scriptParentParentParent.Utility.overlayInGameMenu)

local DesktopUpsellExperiment = require(scriptParentParentParent.Utility.Experiments.DesktopUpsellExperiment)

local getEnableCentralOverlayForUpsellPrompt = require(scriptParentParentParent.Flags.getEnableCentralOverlayForUpsellPrompt)
local getAppContext = require(scriptParentParentParent.Utility.getAppContext)

local FFlagMobilePopularItemBadgingExperimentEnabled = require(scriptParentParentParent.Flags.FFlagMobilePopularItemBadgingExperimentEnabled)
local UnifiedPurchaseCompletionModalV2 = require(scriptParentParentParent.Generic.UnifiedPurchaseCompletionModalV2)

local var1 = Roact.Component:extend(script.Name)

local default = require(scriptParentParentParentParent.LoggingProtocol).default
local InGameRobuxUpsellEvent = require(scriptParent.Events.InGameRobuxUpsellEvent)
local Players = game:GetService("Players")
local IntervalPerformanceTracker = require(scriptParentParentParentParent.IntervalPerformanceTracker).IntervalPerformanceTracker

local VerifiedParentalConsentDialog = require(scriptParentParentParentParent.VerifiedParentalConsentDialog).VerifiedParentalConsentDialog
local UnifiedRobuxUpsellModalV2 = require(scriptParentParentParent.ProductPurchaseRobuxUpsell.v4.UnifiedRobuxUpsellModalV2)

local UnifiedRobuxUpsellModalTooExpensiveV2 = require(scriptParentParentParent.ProductPurchaseRobuxUpsell.v4.UnifiedRobuxUpsellModalTooExpensiveV2)
local _cartPricingResponseLineItem = require(scriptParentParentParent.ProductPurchase.v4.cartPricingResponseLineItem)

local UnifiedPurchaseModalTypeEnum = require(scriptParentParentParent.Enums.UnifiedPurchaseModalTypeEnum)
local UnifiedPurchaseCompletionModal = require(scriptParentParentParent.Generic.UnifiedPurchaseCompletionModal)

local FFlagUnifiedPurchaseFlowMarketplaceUIImprovements = require(scriptParentParentParentParent.SharedFlags).FFlagUnifiedPurchaseFlowMarketplaceUIImprovements

local FFlagLuaAppsEnablePromptVIPServerPurchase = require(scriptParentParentParentParent.SharedFlags).FFlagLuaAppsEnablePromptVIPServerPurchase

local FFlagAddPerformanceMetricsToUnifiedPurchaseModal = require(scriptParentParentParentParent.SharedFlags).FFlagAddPerformanceMetricsToUnifiedPurchaseModal
local FIntLegacyPurchaseFPSTrackingTimeout = require(scriptParentParentParentParent.SharedFlags).FIntLegacyPurchaseFPSTrackingTimeout
local FIntTTIUnifiedPurchaseSamplingRate = require(scriptParentParentParentParent.SharedFlags).FIntTTIUnifiedPurchaseSamplingRate

local FFlagAddCenterDialogForUnifiedPurchaseModal = require(scriptParentParentParentParent.SharedFlags).FFlagAddCenterDialogForUnifiedPurchaseModal

game:DefineFastFlag("DisableNonSchematizedInGameRobuxUpsellEvent", false)

local bool1 = game:DefineFastFlag("FixUnifiedUpsellCompletionModal", false)
local _PricingTypes = require(scriptParentParentParent.ProductPurchase.PricingTypes)
local _UnifiedProductPurchaseModalTypes = require(scriptParentParentParent.ProductPurchase.v3.UnifiedProductPurchaseModalTypes)

local _GetUpsellSuggestionsTypes = require(scriptParentParentParent.Api.PaymentsGateway.GetUpsellSuggestionsTypes)

function var1.init(arg1)
    local props = arg1.props

    arg1.state = {
        analyticId = if props.analyticId then props.analyticId else HttpService:GenerateGUID(false),
        isDelayedInput = props.isDelayedInput,
        enableInputDelayed = false
    }

    function arg1.closeModal()
        local props2 = arg1.props
        arg1:reportUserInput("Cancel")
        props2.cancelPurchase()

        arg1:closeCentralOverlay()
        arg1:UnbindActions()
    end
end

function var1.didMount(arg1)
    if not FFlagAddPerformanceMetricsToUnifiedPurchaseModal or (arg1.props or {}).eventPrefix ~= "UACatalog" then
        return
    end

    IntervalPerformanceTracker:startTracking(
        "PurchaseModal_RobuxUpsellModalShown_Catalog",
        FIntLegacyPurchaseFPSTrackingTimeout,
        nil,
        true,
        true
    )
    IntervalPerformanceTracker:startTracking(
        "PurchaseModal_LegacyFlowRobuxUpsellModalShown_Catalog",
        FIntLegacyPurchaseFPSTrackingTimeout,
        nil,
        true,
        true
    )
    local tTiEventName = getTTIEventName(ProductPurchaseSurface.Catalog)
    TimeToInteractiveTracker.trackEnd(tTiEventName, { samplingRateOverride = FIntTTIUnifiedPurchaseSamplingRate })
end

function var1.didUpdate(tbl1, tbl2, _)
    local props = tbl1.props

    if tbl2.purchaseState ~= props.purchaseState then
        tbl1:reportModalShown()
        tbl1:dispatchCentralOverlayAndRenderModal(props)
    end
end

function var1.UnbindActions(arg1)
    if getEnableCentralOverlayForUpsellPrompt() and arg1.props.dispatchCentralOverlay then
        ContextActionService:UnbindAction(Constants.CLOSE_MODAL_ACTION)
    end
end

function var1.BindCancelAction(arg1)
    if getEnableCentralOverlayForUpsellPrompt() and arg1.props.dispatchCentralOverlay then
        ContextActionService:BindAction(
            Constants.CLOSE_MODAL_ACTION,
            arg1.closeModal,
            false,
            Enum.KeyCode.ButtonB,
            Enum.KeyCode.Escape
        )
    end
end

function var1.closeCentralOverlay(arg1)
    local props = arg1.props

    if getEnableCentralOverlayForUpsellPrompt() and props.dispatchCentralOverlay then
        props.dispatchCentralOverlay()
    end
end

function var1.constructRobuxUpsellPromptAnimatorObj(arg1)
    local props = arg1.props
    local state = arg1.state

    arg1:BindCancelAction()

    local module = {
        shouldAnimate = props.shouldAnimate,
        shouldShow = props.purchaseState == RobuxUpsellFlowState.PurchaseModal,
        skipAnimation = props.useUnifiedProductPurchaseModal,
        onShown = if props.isDelayedInput then function()
            arg1:setState({ enableInputDelayed = true })

            delay(3, function()
                arg1:setState({ isDelayedInput = false, enableInputDelayed = false })

                if props.onDelayedInputComplete then
                    props.onDelayedInputComplete()
                end
            end)
        end or nil else nil,
        onHidden = if props.isDelayedInput then function()
            arg1:setState({ isDelayedInput = props.isDelayedInput, enableInputDelayed = false })
        end or nil else nil,
        renderChildren = 0
    }

    function module.renderChildren()
        if props.useUnifiedProductPurchaseModal then
            if not FFlagAddCenterDialogForUnifiedPurchaseModal or getAppContext() ~= "UA" then
                return Roact.createElement(UnifiedRobuxUpsellModal, {
                    product = {
                        model = props.model,
                        itemIcon = props.itemIcon,
                        itemName = props.itemName,
                        itemRobuxCost = props.itemRobuxCost,
                        badgeType = props.virtualItemBadgeType,
                        itemPrice = props.virtualItemPrice
                    },
                    userBalance = props.beforeRobuxBalance,
                    upsellSuggestions = props.upsellSuggestions,
                    selectedUpsellIndex = props.selectedUpsellIndex,
                    onUpsellSuggestionsSelected = props.onUpsellSuggestionsSelected,
                    purchaseModalType = props.unifiedProductPurchaseModalType,
                    onBuyItemButtonMounted = props.onBuyItemButtonMounted,
                    hideUserRobuxBalance = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then props.hideUserRobuxBalance else nil,
                    cartPricingResponse = props.cartPricingResponse,
                    isCartPricingLoading = props.isCartPricingLoading,
                    onCartOfferAppliedChanged = props.onCartOfferAppliedChanged,
                    onRobloxPlusButtonActivated = props.onRobloxPlusButtonActivated,
                    robloxPlusDiscountPercentage = props.robloxPlusDiscountPercentage,
                    isMonthlyPrice = if FFlagLuaAppsEnablePromptVIPServerPurchase then props.isMonthlyPrice else nil,
                    buttons = {
                        buyItemActivated = function()
                            arg1:reportUserInput("Buy")
                            props.purchaseRobux()
                            arg1:closeCentralOverlay()
                        end,
                        buyItemControllerIcon = props.acceptControllerIcon,
                        buyItemisDelayedInput = state.isDelayedInput,
                        buyItemEnableInputDelayed = state.enableInputDelayed and getAppContext() == "IN_EXPERIENCE",
                        cancelPurchaseActivated = function()
                            arg1:reportUserInput("Cancel")
                            props.cancelPurchase()
                            arg1:closeCentralOverlay()
                        end,
                        cancelControllerIcon = props.cancelControllerIcon
                    },
                    termsOfUseActivated = props.showTermsOfUse and function()
                        arg1:reportUserInput("TermsOfService")
                        props.showTermsOfUse()
                        props.flowComplete()
                    end or nil,
                    screenSize = props.screenSize
                })
            end

            return Roact.createElement(UnifiedRobuxUpsellModalV2, {
                product = {
                    model = props.model,
                    itemIcon = props.itemIcon,
                    itemName = props.itemName,
                    itemRobuxCost = props.itemRobuxCost,
                    badgeType = props.virtualItemBadgeType,
                    itemPrice = props.virtualItemPrice
                },
                userBalance = props.beforeRobuxBalance,
                upsellSuggestions = props.upsellSuggestions,
                selectedUpsellIndex = props.selectedUpsellIndex,
                onUpsellSuggestionsSelected = props.onUpsellSuggestionsSelected,
                purchaseModalType = props.unifiedProductPurchaseModalType,
                onBuyItemButtonMounted = props.onBuyItemButtonMounted,
                hideUserRobuxBalance = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then props.hideUserRobuxBalance else nil,
                cartPricingResponse = props.cartPricingResponse,
                collectibleItemId = props.collectibleItemId,
                isCartPricingLoading = props.isCartPricingLoading,
                onCartOfferAppliedChanged = props.onCartOfferAppliedChanged,
                postPurchaseActions = props.postPurchaseActions,
                setPostPurchaseActions = props.setPostPurchaseActions,
                onRobloxPlusButtonActivated = props.onRobloxPlusButtonActivated,
                robloxPlusDiscountPercentage = props.robloxPlusDiscountPercentage,
                buttons = {
                    buyItemActivated = function()
                        arg1:reportUserInput("Buy")
                        props.purchaseRobux()
                        arg1:closeCentralOverlay()
                    end,
                    buyItemControllerIcon = props.acceptControllerIcon,
                    buyItemisDelayedInput = state.isDelayedInput,
                    buyItemEnableInputDelayed = state.enableInputDelayed and getAppContext() == "IN_EXPERIENCE",
                    cancelPurchaseActivated = function()
                        arg1:reportUserInput("Cancel")
                        props.cancelPurchase()
                        arg1:closeCentralOverlay()
                    end,
                    cancelControllerIcon = props.cancelControllerIcon
                },
                termsOfUseActivated = props.showTermsOfUse and function()
                    arg1:reportUserInput("TermsOfService")
                    props.showTermsOfUse()
                    props.flowComplete()
                end or nil,
                screenSize = props.screenSize
            })
        elseif props.useUpsellSuggestions then
            return overlayInGameMenu(
                Roact.createElement(RobuxUpsellModalMultiplePackage, {
                    product = {
                        model = props.model,
                        itemIcon = props.itemIcon,
                        itemName = props.itemName,
                        itemRobuxCost = props.itemRobuxCost,
                        badgeType = props.virtualItemBadgeType
                    },
                    userBalance = props.beforeRobuxBalance,
                    upsellSuggestions = props.upsellSuggestions,
                    selectedUpsellIndex = props.selectedUpsellIndex,
                    onUpsellSuggestionsSelected = props.onUpsellSuggestionsSelected,
                    buttons = {
                        buyItemActivated = function()
                            arg1:reportUserInput("Buy")
                            props.purchaseRobux()
                            arg1:closeCentralOverlay()
                        end,
                        buyItemControllerIcon = props.acceptControllerIcon,
                        buyItemisDelayedInput = state.isDelayedInput,
                        buyItemEnableInputDelayed = state.enableInputDelayed,
                        cancelPurchaseActivated = function()
                            arg1:reportUserInput("Cancel")
                            props.cancelPurchase()
                            arg1:closeCentralOverlay()
                        end,
                        cancelControllerIcon = props.cancelControllerIcon
                    },
                    isQuest = props.isQuest,
                    isVng = props.isVng,
                    screenSize = props.screenSize
                })
            )
        elseif shouldShowNewUpsellModalExperiment() or DesktopUpsellExperiment.shouldShowNewModal() then
            return overlayInGameMenu(
                Roact.createElement(RobuxUpsellModal, {
                    product = {
                        model = props.model,
                        itemIcon = props.itemIcon,
                        itemName = props.itemName,
                        itemRobuxCost = props.itemRobuxCost,
                        badgeType = props.virtualItemBadgeType
                    },
                    upsell = {
                        balanceAmount = props.beforeRobuxBalance,
                        robuxPurchaseAmount = props.iapRobuxAmount,
                        robuxPurchaseCost = props.iapCostStr,
                        robuxPurchaseAmountBeforeBonus = props.iapRobuxAmountBeforeBonus
                    },
                    buttons = {
                        buyItemActivated = function()
                            arg1:reportUserInput("Buy")
                            props.purchaseRobux()
                            arg1:closeCentralOverlay()
                        end,
                        buyItemControllerIcon = props.acceptControllerIcon,
                        buyItemisDelayedInput = state.isDelayedInput,
                        buyItemEnableInputDelayed = state.enableInputDelayed,
                        cancelPurchaseActivated = function()
                            arg1:reportUserInput("Cancel")
                            props.cancelPurchase()
                            arg1:closeCentralOverlay()
                        end,
                        cancelControllerIcon = props.cancelControllerIcon,
                        opensBuyRobuxPage = DesktopUpsellExperiment.getVariant() == DesktopUpsellExperiment.variants.OpenRobuxStore
                    },
                    isQuest = props.isQuest,
                    isVng = props.isVng,
                    termsOfUseActivated = props.showTermsOfUse and function()
                        arg1:reportUserInput("TermsOfService")
                        props.showTermsOfUse()
                    end or nil,
                    screenSize = props.screenSize
                })
            )
        else
            return Roact.createElement(RobuxUpsellPrompt, {
                screenSize = props.screenSize,
                isDelayedInput = state.isDelayedInput,
                enableInputDelayed = state.enableInputDelayed,
                model = props.model,
                itemIcon = props.itemIcon,
                itemName = props.itemName,
                itemRobuxCost = props.itemRobuxCost,
                robuxPurchaseAmount = props.iapRobuxAmount,
                robuxPurchaseAmountBeforeBonus = props.iapRobuxAmountBeforeBonus,
                balanceAmount = props.beforeRobuxBalance,
                buyItemControllerIcon = props.acceptControllerIcon,
                cancelControllerIcon = props.cancelControllerIcon,
                itemProductId = FFlagMobilePopularItemBadgingExperimentEnabled and tostring(props.itemProductId) or nil,
                buyItemActivated = function()
                    arg1:reportUserInput("Buy")
                    props.purchaseRobux()
                    arg1:closeCentralOverlay()
                end,
                cancelPurchaseActivated = function()
                    arg1:reportUserInput("Cancel")
                    props.cancelPurchase()
                    arg1:closeCentralOverlay()
                end,
                termsOfUseActivated = props.showTermsOfUse and function()
                    arg1:reportUserInput("TermsOfService")
                    props.showTermsOfUse()
                end or nil,
                isQuest = arg1.props.isQuest,
                isVng = arg1.props.isVng
            })
        end
    end

    return module
end

function var1.constructU13ConfirmPromptAnimatorObj(arg1)
    local props = arg1.props

    arg1:BindCancelAction()

    return {
        shouldAnimate = props.shouldAnimate,
        shouldShow = props.purchaseState == RobuxUpsellFlowState.PurchaseWarning,
        renderChildren = function()
            return Roact.createElement(U13ConfirmPrompt, {
                screenSize = props.screenSize,
                modalType = props.u13ConfirmType,
                doneControllerIcon = props.acceptControllerIcon,
                cancelControllerIcon = props.cancelControllerIcon,
                doneActivated = function()
                    arg1:reportUserInput("Confirm")
                    props.acceptPurchaseWarning()
                    arg1:closeCentralOverlay()
                end,
                cancelActivated = function()
                    arg1:reportUserInput("Cancel")
                    props.cancelPurchase()
                    arg1:closeCentralOverlay()
                end
            })
        end
    }
end

function var1.constructPurchaseErrorPromptAnimatorObj(arg1)
    local props = arg1.props

    arg1:BindCancelAction()

    return {
        shouldAnimate = props.shouldAnimate,
        shouldShow = props.purchaseState == RobuxUpsellFlowState.Error,
        renderChildren = function()
            if props.errorType == PurchaseErrorType.NotEnoughRobuxInApp then
                if FFlagAddCenterDialogForUnifiedPurchaseModal then
                    return (Roact.createElement(UnifiedRobuxUpsellModalTooExpensiveV2, {
                        product = {
                            model = props.model,
                            itemIcon = props.itemIcon,
                            itemName = props.itemName,
                            itemRobuxCost = props.itemRobuxCost
                        },
                        balanceAmount = props.beforeRobuxBalance,
                        buttons = {
                            buyItemActivated = function()
                                arg1:reportUserInput("Buy Robux")
                                props.openBuyRobux()
                                props.flowComplete()
                                arg1:closeCentralOverlay()
                            end,
                            cancelPurchaseActivated = function()
                                arg1:reportUserInput("Cancel")
                                props.flowComplete()
                                arg1:closeCentralOverlay()
                            end
                        },
                        purchaseModalType = props.unifiedProductPurchaseModalType,
                        screenSize = props.screenSize
                    }))
                end

                return (Roact.createElement(UnifiedRobuxUpsellModalTooExpensive, {
                    product = {
                        model = props.model,
                        itemIcon = props.itemIcon,
                        itemName = props.itemName,
                        itemRobuxCost = props.itemRobuxCost
                    },
                    balanceAmount = props.beforeRobuxBalance,
                    hideUserRobuxBalance = if FFlagUnifiedPurchaseFlowMarketplaceUIImprovements then props.hideUserRobuxBalance else nil,
                    buttons = {
                        buyItemActivated = function()
                            arg1:reportUserInput("Buy Robux")
                            props.openBuyRobux()
                            props.flowComplete()
                            arg1:closeCentralOverlay()
                        end,
                        cancelPurchaseActivated = function()
                            arg1:reportUserInput("Cancel")
                            props.flowComplete()
                            arg1:closeCentralOverlay()
                        end
                    },
                    isQuest = props.isQuest,
                    screenSize = props.screenSize,
                    purchaseModalType = props.unifiedProductPurchaseModalType
                }))
            elseif props.errorType == PurchaseErrorType.NotEnoughRobux
                and (shouldShowNewUpsellModalExperiment() or DesktopUpsellExperiment.shouldShowNewModal())
            then
                return Roact.createElement(RobuxUpsellModalTooExpensiveFallback, {
                    product = {
                        model = props.model,
                        itemIcon = props.itemIcon,
                        itemName = props.itemName,
                        itemRobuxCost = props.itemRobuxCost
                    },
                    balanceAmount = props.beforeRobuxBalance,
                    doneActivated = function()
                        arg1:reportUserInput("Done")
                        props.flowComplete()
                        arg1:closeCentralOverlay()
                    end,
                    doneControllerIcon = props.acceptControllerIcon,
                    isQuest = props.isQuest,
                    screenSize = props.screenSize
                })
            else
                return Roact.createElement(PurchaseErrorPrompt, {
                    screenSize = props.screenSize,
                    errorType = props.errorType,
                    economicRestrictionError = props.economicRestrictionError,
                    doneControllerIcon = props.acceptControllerIcon,
                    doneActivated = function()
                        arg1:reportUserInput("Done")
                        props.flowComplete()
                        arg1:closeCentralOverlay()
                    end
                })
            end
        end
    }
end

function var1.constructTwoStepRequiredAnimatorObj(arg1)
    local props = arg1.props

    arg1:BindCancelAction()

    return {
        shouldAnimate = props.shouldAnimate,
        shouldShow = props.purchaseState == RobuxUpsellFlowState.TwoStepRequired,
        renderChildren = function()
            return Roact.createElement(TwoStepReqPrompt, {
                screenSize = props.screenSize,
                doneControllerIcon = props.acceptControllerIcon,
                openSecuritySettings = function()
                    arg1:reportUserInput("GoToSecuritySettings")
                    props.openSecuritySettings()
                    props.flowComplete()
                    arg1:closeCentralOverlay()
                end,
                closePrompt = function()
                    arg1:reportUserInput("Cancel")
                    props.flowComplete()
                    arg1:closeCentralOverlay()
                end
            })
        end
    }
end

function var1.constructRobuxUpsellSuccessPromptAnimatorObj(arg1)
    local props = arg1.props

    arg1:BindCancelAction()

    return {
        shouldAnimate = props.shouldAnimate,
        shouldShow = props.purchaseState == RobuxUpsellFlowState.Success,
        renderChildren = function()
            local var2 = props.beforeRobuxBalance - props.itemRobuxCost

            if var2 < 0 then
                var2 += props.iapRobuxAmount
            end
            if not props.useUnifiedProductPurchaseModal then
                return Roact.createElement(RobuxUpsellSuccessPrompt, {
                    screenSize = props.screenSize,
                    model = props.model,
                    itemIcon = props.itemIcon,
                    itemName = props.itemName,
                    balance = var2,
                    confirmControllerIcon = props.acceptControllerIcon,
                    cancelControllerIcon = props.cancelControllerIcon,
                    doneActivated = function()
                        arg1:reportUserInput("Done")
                        props.flowComplete()
                        arg1:closeCentralOverlay()
                    end,
                    equipActivated = props.equipItem and function()
                        arg1:reportUserInput("Equip")
                        props.equipItem()
                        arg1:closeCentralOverlay()
                    end or nil
                })
            end

            if bool1 and getAppContext() == "UA" then
                return Roact.createElement(UnifiedPurchaseCompletionModalV2, {
                    buttons = {
                        onActivated = function()
                            arg1:reportUserInput("Done")
                            props.flowComplete()
                            arg1:closeCentralOverlay()
                        end
                    },
                    isMultiItem = props.unifiedProductPurchaseModalType == UnifiedPurchaseModalTypeEnum.MultiItem,
                    itemName = props.itemName
                })
            end
            return Roact.createElement(UnifiedPurchaseCompletionModal, {
                buttons = {
                    onActivated = function()
                        arg1:reportUserInput("Done")
                        props.flowComplete()
                        arg1:closeCentralOverlay()
                    end
                },
                isMultiItem = props.unifiedProductPurchaseModalType == UnifiedPurchaseModalTypeEnum.MultiItem,
                itemName = props.itemName
            })
        end
    }
end

function var1.constructInsufficientRobuxAnimatorObj(arg1)
    local props = arg1.props

    arg1:BindCancelAction()

    return {
        shouldAnimate = props.shouldAnimate,
        shouldShow = props.purchaseState == RobuxUpsellFlowState.GenericPurchaseModal,
        renderChildren = function()
            if not (shouldShowNewUpsellModalExperiment() or DesktopUpsellExperiment.shouldShowNewModal()) then
                return Roact.createElement(InsufficientRobuxPrompt, {
                    screenSize = props.screenSize,
                    robuxBalance = props.beforeRobuxBalance,
                    buyRobux = function()
                        arg1:reportUserInput("Buy Robux")
                        props.openBuyRobux()
                        props.flowComplete()
                        arg1:closeCentralOverlay()
                    end,
                    closePrompt = function()
                        arg1:reportUserInput("Cancel")
                        props.flowComplete()
                        arg1:closeCentralOverlay()
                    end
                })
            end

            return Roact.createElement(RobuxUpsellModalTooExpensive, {
                product = {
                    model = props.model,
                    itemIcon = props.itemIcon,
                    itemName = props.itemName,
                    itemRobuxCost = props.itemRobuxCost
                },
                balanceAmount = props.beforeRobuxBalance,
                buttons = {
                    buyItemActivated = function()
                        arg1:reportUserInput("Buy Robux")
                        props.openBuyRobux()
                        props.flowComplete()
                        arg1:closeCentralOverlay()
                    end,
                    buyItemControllerIcon = props.acceptControllerIcon,
                    cancelPurchaseActivated = function()
                        arg1:reportUserInput("Cancel")
                        props.flowComplete()
                        arg1:closeCentralOverlay()
                    end,
                    cancelControllerIcon = props.cancelControllerIcon
                },
                isQuest = props.isQuest,
                screenSize = props.screenSize
            })
        end
    }
end

function var1.constructInsufficientRobuxProductAnimatorObj(arg1)
    local props = arg1.props

    arg1:BindCancelAction()

    return {
        shouldAnimate = props.shouldAnimate,
        shouldShow = props.purchaseState == RobuxUpsellFlowState.LargeRobuxPurchaseModal,
        renderChildren = function()
            return Roact.createElement(InsufficientRobuxProductPrompt, {
                screenSize = props.screenSize,
                model = props.model,
                itemIcon = props.itemIcon,
                itemName = props.itemName,
                itemRobuxCost = props.itemRobuxCost,
                balanceAmount = props.beforeRobuxBalance,
                acceptControllerIcon = props.acceptControllerIcon,
                cancelControllerIcon = props.cancelControllerIcon,
                robuxStoreActivated = function()
                    arg1:reportUserInput("Go to Robux store")
                    props.openBuyRobux()
                    arg1:closeCentralOverlay()
                end,
                cancelPurchaseActivated = function()
                    arg1:reportUserInput("Cancel")
                    props.flowComplete()
                    arg1:closeCentralOverlay()
                end
            })
        end
    }
end

function var1.constructLeaveRobloxPromptAnimatorObj(arg1)
    local props = arg1.props

    arg1:BindCancelAction()

    return {
        shouldAnimate = props.shouldAnimate,
        shouldShow = props.purchaseState == RobuxUpsellFlowState.LeaveRobloxWarning,
        renderChildren = function()
            return Roact.createElement(LeaveRobloxPrompt, {
                screenSize = props.screenSize,
                cancelActivated = function()
                    arg1:closeCentralOverlay()
                end,
                continueActivated = function()
                    props.openVngShop()
                end
            })
        end
    }
end

function var1.constructPurchaseVPCPromptAnimatorObj(arg1)
    local props = arg1.props

    arg1:BindCancelAction()

    return {
        shouldAnimate = props.shouldAnimate,
        shouldShow = props.purchaseState == RobuxUpsellFlowState.PurchaseVPCModal,
        renderChildren = function()
            return Roact.createElement(VerifiedParentalConsentDialog, {
                screenSize = props.screenSize,
                isActionable = props.openSettingsPage ~= nil,
                modalType = props.purchaseVPCType,
                onAction = props.openSettingsPage and function()
                    arg1:reportUserInput("Confirm")
                    props.openSettingsPage()
                    props.flowComplete()
                end,
                onDismiss = function()
                    arg1:reportUserInput("Cancel")
                    props.cancelPurchase()
                    arg1:closeCentralOverlay()
                end
            })
        end
    }
end

function var1.dispatchCentralOverlayAndRenderModal(tbl1, tbl2)
    if not (getEnableCentralOverlayForUpsellPrompt() and tbl2.dispatchCentralOverlay) then
        return
    end

    local purchaseState = tbl2.purchaseState

    if purchaseState == RobuxUpsellFlowState.PurchaseModal then
        tbl2.dispatchCentralOverlay(Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR, tbl1:constructRobuxUpsellPromptAnimatorObj())

        return
    end

    if purchaseState == RobuxUpsellFlowState.PurchaseWarning then
        tbl2.dispatchCentralOverlay(Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR, tbl1:constructU13ConfirmPromptAnimatorObj())
    end

    if purchaseState == RobuxUpsellFlowState.Error then
        tbl2.dispatchCentralOverlay(Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR, tbl1:constructPurchaseErrorPromptAnimatorObj())
    end

    if purchaseState == RobuxUpsellFlowState.TwoStepRequired then
        tbl2.dispatchCentralOverlay(Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR, tbl1:constructTwoStepRequiredAnimatorObj())
    end

    if purchaseState == RobuxUpsellFlowState.Success then
        tbl2.dispatchCentralOverlay(
            Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR,
            tbl1:constructRobuxUpsellSuccessPromptAnimatorObj()
        )
    end

    if purchaseState == RobuxUpsellFlowState.GenericPurchaseModal then
        tbl2.dispatchCentralOverlay(Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR, tbl1:constructInsufficientRobuxAnimatorObj())
    end

    if purchaseState == RobuxUpsellFlowState.LargeRobuxPurchaseModal then
        tbl2.dispatchCentralOverlay(
            Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR,
            tbl1:constructInsufficientRobuxProductAnimatorObj()
        )
    end

    if purchaseState == RobuxUpsellFlowState.LeaveRobloxWarning then
        tbl2.dispatchCentralOverlay(Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR, tbl1:constructLeaveRobloxPromptAnimatorObj())
    end

    if purchaseState == RobuxUpsellFlowState.PurchaseVPCModal then
        tbl2.dispatchCentralOverlay(Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR, tbl1:constructPurchaseVPCPromptAnimatorObj())
    end
end

function var1.reportModalShown(arg1)
    local props = arg1.props
    local state = arg1.state

    if not arg1.props.onAnalyticEvent then
        return
    end

    local var2 = getModalShownEventData
    local analyticId = state.analyticId
    local eventPrefix = props.eventPrefix

    local var3 = RobuxUpsellFlowState.toRawValue(props.purchaseState)
    local httpService = HttpService
    local input = {
        universe_id = tostring(game.GameId),
        item_product_id = tostring(props.itemProductId),
        item_name = props.itemName,
        price = tostring(props.itemRobuxCost),
        user_balance = tostring(props.beforeRobuxBalance) or nil,
        package_robux_amount = tostring(props.iapRobuxAmount) or nil,
        package_cost = props.iapCostStr or nil
    }
    local var4 = var2(analyticId, eventPrefix, "RobuxUpsell", var3, httpService:JSONEncode(input))

    props.onAnalyticEvent("UserPurchaseFlow", var4)
end

function var1.reportUserInput(tbl1, inputType: string)
    local props = tbl1.props
    local state = tbl1.state

    local var2 = getUserInputEventData
    local analyticId = state.analyticId
    local eventPrefix = props.eventPrefix

    local var3 = RobuxUpsellFlowState.toRawValue(props.purchaseState)

    local httpService = HttpService
    local input = {
        universe_id = tostring(game.GameId),
        item_product_id = tostring(props.itemProductId),
        item_name = props.itemName,
        price = tostring(props.itemRobuxCost),
        user_balance = tostring(props.beforeRobuxBalance) or nil,
        package_robux_amount = tostring(props.iapRobuxAmount) or nil,
        package_cost = props.iapCostStr or nil
    }
    local var4 = var2(analyticId, eventPrefix, "RobuxUpsell", var3, inputType, httpService:JSONEncode(input))

    if not game:GetFastFlag("DisableNonSchematizedInGameRobuxUpsellEvent") and tbl1.props.onAnalyticEvent then
        props.onAnalyticEvent("UserPurchaseFlow", var4)
    end

    local userId = if Players.LocalPlayer and Players.LocalPlayer.UserId > 0 then Players.LocalPlayer.UserId else nil
    default:logRobloxTelemetryEvent(
        InGameRobuxUpsellEvent,
        { default.StandardizedFields.addOsInfo, default.StandardizedFields.addSessionId },
        {
            universe_id = game.GameId,
            price = props.itemRobuxCost,
            view_name = var4.view_name,
            purchase_event_type = var4.purchase_event_type,
            input_type = inputType,
            user_id = tostring(userId)
        }
    )
end

function var1.purchaseStateToOverlayState(_, arg1)
    if arg1 == RobuxUpsellFlowState.Loading then
        return LoadingOverlayState.Loading
    end

    if arg1 == RobuxUpsellFlowState.RobuxPurchasePending then
        return LoadingOverlayState.PurchasingRobux
    end

    if arg1 == RobuxUpsellFlowState.RobuxGrantPending then
        return LoadingOverlayState.WaitingForRobux
    end

    if arg1 == RobuxUpsellFlowState.ItemPurchasePending then
        return LoadingOverlayState.PurchasingItem
    end

    if arg1 == RobuxUpsellFlowState.None then
        return nil
    end

    return LoadingOverlayState.None
end

function var1.getChildrenElements(arg1)
    return {
        RobuxUpsellPromptAnimator = Roact.createElement(Animator, arg1:constructRobuxUpsellPromptAnimatorObj()),
        U13ConfirmPromptAnimator = Roact.createElement(Animator, arg1:constructU13ConfirmPromptAnimatorObj()),
        PurchaseErrorPromptAnimator = Roact.createElement(Animator, arg1:constructPurchaseErrorPromptAnimatorObj()),
        TwoStepRequiredAnimator = Roact.createElement(Animator, arg1:constructTwoStepRequiredAnimatorObj()),
        RobuxUpsellSuccessPromptAnimator = Roact.createElement(Animator, arg1:constructRobuxUpsellSuccessPromptAnimatorObj()),
        InsufficientRobuxAnimator = Roact.createElement(Animator, arg1:constructInsufficientRobuxAnimatorObj()),
        InsufficientRobuxProductAnimator = Roact.createElement(Animator, arg1:constructInsufficientRobuxProductAnimatorObj()),
        PurchaseVPCPromptAnimator = Roact.createElement(Animator, arg1:constructPurchaseVPCPromptAnimatorObj())
    }
end

function var1.render(arg1)
    local props = arg1.props

    local var2 = getEnableCentralOverlayForUpsellPrompt() and props.dispatchCentralOverlay and {} or arg1:getChildrenElements()

    return Roact.createElement(
        LoadingOverlay,
        {
            shouldAnimate = props.shouldAnimate,
            loadingState = arg1:purchaseStateToOverlayState(props.purchaseState)
        },
        var2
    )
end

return var1

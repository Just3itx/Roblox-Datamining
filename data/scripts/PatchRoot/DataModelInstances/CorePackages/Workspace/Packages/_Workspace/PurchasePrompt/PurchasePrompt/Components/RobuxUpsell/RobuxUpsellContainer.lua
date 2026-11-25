-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local PurchasePromptDeps = require(PurchasePromptParent.PurchasePromptDeps)
local IAPExperience = require(PurchasePromptParent.IAPExperience)
local Roact = PurchasePromptDeps.Roact
local React = require(PurchasePromptParent.React)

local CoreScriptsRootProvider = require(PurchasePromptParent.CoreScriptsRoactCommon).CoreScriptsRootProvider
local FocusNavigationUtils = require(PurchasePromptParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local Navigation = require(PurchasePromptParent.Navigation)
local Cryo = require(PurchasePromptParent.Cryo)
local selectPrice = require(PurchasePrompt.Selectors.selectPrice)

local PromptNativeUpsellSuggestions = require(PurchasePrompt.Actions.PromptNativeUpsellSuggestions)
local SetPostPurchaseActions = require(PurchasePrompt.Actions.SetPostPurchaseActions)
local SetPromptState = require(PurchasePrompt.Actions.SetPromptState)
local SetWindowState = require(PurchasePrompt.Actions.SetWindowState)

local PurchaseFlow = require(PurchasePrompt.Enums.PurchaseFlow)
local PromptState = require(PurchasePrompt.Enums.PromptState)

local _RobuxUpsell = require(PurchasePrompt.Models.RobuxUpsell)

local GetUpsellSuggestionsTypes = IAPExperience.Api.PaymentsGateway.GetUpsellSuggestionsTypes

local completeRequest = require(PurchasePrompt.Thunks.completeRequest)
local purchaseItem = require(PurchasePrompt.Thunks.purchaseItem)
local launchRobuxUpsell = require(PurchasePrompt.Thunks.launchRobuxUpsell)
local openRobuxStore = require(PurchasePrompt.Thunks.openRobuxStore)
local openSecuritySettings = require(PurchasePrompt.Thunks.openSecuritySettings)
local openTermsOfUse = require(PurchasePrompt.Thunks.openTermsOfUse)
local initiateUserPurchaseSettingsPrecheck = require(PurchasePrompt.Thunks.initiateUserPurchaseSettingsPrecheck)
local retryPurchaseAfterUpsell = require(PurchasePrompt.Thunks.retryPurchaseAfterUpsell)
local fetchCartPricing = require(PurchasePrompt.Thunks.fetchCartPricing)
local fetchInGameItemCartPricing = require(PurchasePrompt.Thunks.fetchInGameItemCartPricing)
local RequestType = require(PurchasePrompt.Enums.RequestType)
local selectCartPricingResponse = require(PurchasePrompt.Selectors.selectCartPricingResponse)
local selectIsCartPricingFetching = require(PurchasePrompt.Selectors.selectIsCartPricingFetching)
local sendEvent = require(PurchasePrompt.Thunks.sendEvent)
local isMockingPurchases = require(PurchasePrompt.Utils.isMockingPurchases)
local getPlayerPrice = require(PurchasePrompt.Utils.getPlayerPrice)
local isLinksAllowed = require(PurchasePrompt.Utils.isLinksAllowed)
local SelectedRobuxPackage = require(PurchasePrompt.Utils.SelectedRobuxPackage)
local connectToStore = require(PurchasePrompt.connectToStore)

local ExternalEventConnection = require(PurchasePrompt.Components.Connection.ExternalEventConnection)

local GetFFLagUseCoreScriptsRootProviderForUpsellModal = require(PurchasePrompt.Flags.GetFFLagUseCoreScriptsRootProviderForUpsellModal)
local FFlagSetMenuOnPurchasePrompt = require(PurchasePrompt.Flags.FFlagSetMenuOnPurchasePrompt)
local UpsellSuggestionsAPIMaxPackages = require(PurchasePromptParent.SharedFlags).UpsellSuggestionsAPIMaxPackages
local RobuxUpsellOverlay = require(script.Parent.RobuxUpsellOverlay)
local AppPage = require(PurchasePromptParent.RobloxAppEnums).AppPage

local SharedFlags = require(PurchasePromptParent.SharedFlags)
local FFlagLuaAppsEnablePromptVIPServerPurchase = SharedFlags.FFlagLuaAppsEnablePromptVIPServerPurchase
local FFlagEnableRobuxUpsellPlusButtonExperiment = IAPExperience.Flags.FFlagEnableRobuxUpsellPlusButtonExperiment

local FFlagAddOnRobloxSubscriptionUpsellSuccessCallbackToUnifiedPurchaseModal = SharedFlags.FFlagAddOnRobloxSubscriptionUpsellSuccessCallbackToUnifiedPurchaseModal
local FFlagSkipBuyDelayForExperienceShop = require(PurchasePrompt.Flags.FFlagSkipBuyDelayForExperienceShop)
local getBlackbirdUpsellBannerProductInfo = require(PurchasePrompt.Utils.getBlackbirdUpsellBannerProductInfo)
local startRobuxUpsellPlusPurchase = require(PurchasePrompt.Utils.startRobuxUpsellPlusPurchase)
local var1 = Roact.Component:extend(script.Name)

function var1.init(arg1)
    arg1.state = {
        screenSize = Vector2.new(0, 0)
    }
    arg1.isRobloxPlusUpsellStarting = false

    function arg1.changeScreenSize(arg2)
        if arg1.state.screenSize ~= arg2.AbsoluteSize then
            arg1:setState({ screenSize = arg2.AbsoluteSize })
        end
    end

    function arg1.fetchCartPricingForPurchasePrompt(_: boolean, tbl1)
        if tbl1 == nil then
            return nil
        end

        local requestType = arg1.props.requestType
        if requestType == RequestType.GamePass or requestType == RequestType.Product then
            return arg1.props.fetchInGameItemCartPricing(tbl1)
        end
        return arg1.props.fetchCartPricing(tbl1)
    end

    function arg1.navigateToBuyRobux()
        arg1.props.navigation.navigate(AppPage.PurchaseRobux)
    end

    function arg1.navigateToTermsOfUse()
        arg1.props.openTermsOfUse(arg1.props.navigation)
    end

    function arg1.openRobloxPlusUpsell()
        if arg1.isRobloxPlusUpsellStarting then
            return
        end
        arg1.isRobloxPlusUpsellStarting = true

        startRobuxUpsellPlusPurchase({
            purchaseFlowUUID = arg1.props.purchaseFlowUUID,
            setPromptState = arg1.props.setPromptState,
            setWindowState = arg1.props.setWindowState,
            onRobloxSubscriptionUpsellSuccess = arg1.props.onRobloxSubscriptionUpsellSuccess,
            retryPurchaseAfterUpsell = arg1.props.retryPurchaseAfterUpsell,
            completeRequest = arg1.props.completeRequest,
            onFlowEnded = function()
                arg1.isRobloxPlusUpsellStarting = false
            end
        })
    end
end

function var1.getRobloxPlusPromptKey(arg1)
    local purchaseFlowUuid = arg1.props.purchaseFlowUUID
    if type(purchaseFlowUuid) == "string" and purchaseFlowUuid ~= "" then
        return purchaseFlowUuid
    end
    local productPayload = arg1.props.productPayload
    local id = if type(productPayload) == "table" then productPayload.id else nil

    if id ~= nil then
        return tostring(id)
    end
    return nil
end

function var1.isRobuxUpsellModalVisible(arg1): boolean
    local purchaseFlow = arg1.props.purchaseFlow

    return (purchaseFlow == PurchaseFlow.RobuxUpsellV2 or purchaseFlow == PurchaseFlow.LargeRobuxUpsell)
        and arg1.props.promptState == PromptState.RobuxUpsell
end

function var1.createElement(arg1)
    local props = arg1.props
    local state = arg1.state
    local var2 = not ((if arg1:isRobuxUpsellModalVisible() then arg1:getRobloxPlusPromptKey() else nil) == nil)
        and props.isUserEligibleForUnifiedPurchaseFlow
        and props.experimentVariant == GetUpsellSuggestionsTypes.ExperimentVariant.PlusPromotion
    local blackbirdUpsellBannerProductInfo = getBlackbirdUpsellBannerProductInfo(props.robloxSubscriptionProducts)
    local initialDiscountPercentage = if blackbirdUpsellBannerProductInfo then blackbirdUpsellBannerProductInfo.initialDiscountPercentage else nil

    if type(initialDiscountPercentage) ~= "number" then
        initialDiscountPercentage = nil
    end

    if props.purchaseFlow ~= PurchaseFlow.RobuxUpsellV2 and props.purchaseFlow ~= PurchaseFlow.LargeRobuxUpsell then
        return nil
    end
    if FFlagEnableRobuxUpsellPlusButtonExperiment and props.promptState == PromptState.BlackbirdUpsellInProgress then
        return nil
    end

    local var3 = isLinksAllowed()

    local imageUrl = props.productInfo.imageUrl
    if string.find(props.productInfo.imageUrl, "assetid=0") then
        imageUrl = nil
    end

    local createElement2 = Roact.createElement
    local str1 = "Frame"
    local tbl1 = {
        Size = UDim2.new(1, 0, 1, 0),
        [Roact.Change.AbsoluteSize] = arg1.changeScreenSize,
        BackgroundTransparency = 1
    }

    local tbl2 = {
        Prompt = Roact.createElement(RobuxUpsellOverlay, {
            screenSize = state.screenSize,
            virtualItemPrice = props.virtualItemPrice,
            requestType = props.requestType,
            promptState = props.promptState,
            purchaseFlow = props.purchaseFlow,
            purchaseError = props.purchaseError,
            economicRestrictionError = props.economicRestrictionError,
            useUpsellSuggestions = UpsellSuggestionsAPIMaxPackages > 1,
            upsellSuggestions = props.robuxSuggestions,
            selectedUpsellIndex = props.robuxPackageSelection,
            virtualItemBadgeType = props.virtualItemBadgeType,
            onUpsellSuggestionsSelected = function(num1: number)
                props.onUpsellSuggestionsSelected(props.robuxSuggestions, num1, props.virtualItemBadgeType, props.experimentVariant)
            end,
            useUnifiedProductPurchaseModal = arg1.props.isUserEligibleForUnifiedPurchaseFlow,
            purchaseAnalyticsMetadata = arg1.props.purchaseAnalyticsMetadata,
            cartPricingResponse = props.cartPricingResponse,
            collectibleItemId = props.collectibleItemId,
            isCartPricingLoading = props.isCartPricingLoading,
            onCartOfferAppliedChanged = arg1.fetchCartPricingForPurchasePrompt,
            postPurchaseActions = props.postPurchaseActions,
            setPostPurchaseActions = props.setPostPurchaseActions,
            onRobloxPlusButtonActivated = if var2 then arg1.openRobloxPlusUpsell else nil,
            robloxPlusDiscountPercentage = initialDiscountPercentage,
            isMonthlyPrice = if FFlagLuaAppsEnablePromptVIPServerPurchase then props.productInfo.isMonthlyPrice else nil,
            robuxProviderId = props.robuxProductId,
            robuxProductId = props.productId,
            itemIcon = imageUrl,
            itemProductId = props.productInfo.productId,
            itemName = props.productInfo.name,
            itemRobuxCost = getPlayerPrice(props.productInfo, props.accountInfo.membershipType == 4, props.expectedPrice),
            iapRobuxAmount = props.robuxPurchaseAmount or 0,
            iapCostStr = props.price,
            beforeRobuxBalance = props.accountInfo.balance,
            isTestPurchase = props.isTestPurchase,
            isGamepadEnabled = props.isGamepadEnabled,
            isFromInExperienceShop = if FFlagSkipBuyDelayForExperienceShop then props.isFromInExperienceShop else nil,
            purchaseItem = props.purchaseItem,
            promptRobuxPurchase = props.promptRobuxPurchase,
            openRobuxStore = if arg1.props.isUserEligibleForUnifiedPurchaseFlow then arg1.navigateToBuyRobux else props.openRobuxStore,
            openTermsOfUse = if var3 then arg1.navigateToTermsOfUse or nil else nil,
            openSecuritySettings = if var3 then props.openSecuritySettings or nil else nil,
            dispatchFetchPurchaseWarning = props.dispatchFetchPurchaseWarning,
            endPurchase = props.completeRequest,
            onAnalyticEvent = props.onAnalyticEvent,
            humanoidModel = props.humanoidModel
        }),
        ModalFix = Roact.createElement("ImageButton", { BackgroundTransparency = 0, Modal = true, Size = UDim2.new(0, 0, 0, 0) }),
        OnCoreGuiMenuOpened = Roact.createElement(ExternalEventConnection, {
            event = GuiService.MenuOpened,
            callback = function()
                if FFlagSetMenuOnPurchasePrompt and arg1.menuOpenedBySelf then
                    arg1.menuOpenedBySelf = false
                    return
                end
                props.completeRequest()
            end
        })
    }

    return createElement2(str1, tbl1, tbl2)
end

function var1.render(arg1)
    local robuxUpsellContainer = arg1:createElement()
    if FFlagSetMenuOnPurchasePrompt then
        if robuxUpsellContainer ~= nil then
            arg1.menuOpenedBySelf = true
        end
        GuiService:SetMenuIsOpen(robuxUpsellContainer ~= nil, "RobuxUpsellContainer")
    end

    if not GetFFLagUseCoreScriptsRootProviderForUpsellModal() then
        return robuxUpsellContainer
    end

    return Roact.createElement(CoreScriptsRootProvider, {}, {
        FocusNavigationCoreScriptsWrapper = React.createElement(
            FocusRoot,
            {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                isIsolated = true,
                isAutoFocusRoot = true
            },
            { RobuxUpsellContainer = robuxUpsellContainer }
        )
    })
end
return (connectToStore(function(arg1)
    local isTestPurchase = isMockingPurchases(arg1.promptRequest.requestType)

    local collectibleItemId = arg1.productInfo.collectibleItemId
    if type(collectibleItemId) ~= "string" or collectibleItemId == "" then
        collectibleItemId = arg1.promptRequest.collectibleItemId
        if type(collectibleItemId) ~= "string" or collectibleItemId == "" then
            collectibleItemId = nil
        end
    end
    return {
        purchaseFlow = arg1.purchaseFlow,
        requestType = arg1.promptRequest.requestType,
        expectedPrice = arg1.promptRequest.expectedPrice,
        promptState = arg1.promptState,
        purchaseError = arg1.purchaseError,
        economicRestrictionError = arg1.economicRestrictionError,
        productInfo = arg1.productInfo,
        accountInfo = arg1.accountInfo,
        robuxSuggestions = arg1.robuxUpsellSuggestions.products,
        robuxPackageSelection = arg1.robuxUpsellSuggestions.selection,
        virtualItemBadgeType = arg1.robuxUpsellSuggestions.virtualItemBadgeType,
        experimentVariant = arg1.robuxUpsellSuggestions.experimentVariant,
        robuxProductId = SelectedRobuxPackage.getRobuxProductId(arg1),
        productId = SelectedRobuxPackage.getProductId(arg1),
        robuxPurchaseAmount = SelectedRobuxPackage.getRobuxPurchaseAmount(arg1),
        robuxAmountBeforeBonus = SelectedRobuxPackage.getRobuxAmountBeforeBonus(arg1),
        price = SelectedRobuxPackage.getPrice(arg1),
        isTestPurchase = isTestPurchase,
        isGamepadEnabled = arg1.gamepadEnabled,
        isFromInExperienceShop = if FFlagSkipBuyDelayForExperienceShop then arg1.productPayload and arg1.productPayload.isFromInExperienceShop else nil,
        humanoidModel = arg1.promptRequest.humanoidModel,
        isUserEligibleForUnifiedPurchaseFlow = arg1.isUserEligibleForUnifiedPurchaseFlow,
        purchaseAnalyticsMetadata = arg1.purchaseAnalyticsMetadata,
        purchaseFlowUUID = arg1.purchaseFlowUUID,
        virtualItemPrice = selectPrice(arg1),
        collectibleItemId = collectibleItemId,
        cartPricingResponse = selectCartPricingResponse(arg1),
        isCartPricingLoading = selectIsCartPricingFetching(arg1),
        postPurchaseActions = arg1.postPurchaseActions,
        productPayload = arg1.productPayload,
        robloxSubscriptionProducts = arg1.robloxSubscriptionProducts,
        onRobloxSubscriptionUpsellSuccess = if FFlagAddOnRobloxSubscriptionUpsellSuccessCallbackToUnifiedPurchaseModal and arg1.purchaseCallbacks then arg1.purchaseCallbacks.onRobloxSubscriptionUpsellSuccess else nil
    }
end, function(arg1)
    return {
        purchaseItem = function()
            return arg1(purchaseItem())
        end,
        fetchCartPricing = function(tbl1)
            return arg1(fetchCartPricing(tbl1))
        end,
        fetchInGameItemCartPricing = function(tbl1)
            return arg1(fetchInGameItemCartPricing(tbl1))
        end,
        promptRobuxPurchase = function()
            return arg1(launchRobuxUpsell())
        end,
        openRobuxStore = function()
            return arg1(openRobuxStore())
        end,
        openSecuritySettings = function()
            return arg1(openSecuritySettings())
        end,
        openTermsOfUse = function(arg2)
            return arg1(openTermsOfUse(arg2))
        end,
        dispatchFetchPurchaseWarning = function()
            return arg1(initiateUserPurchaseSettingsPrecheck())
        end,
        completeRequest = function()
            GuiService.SelectedCoreObject = nil
            return arg1(completeRequest())
        end,
        retryPurchaseAfterUpsell = function()
            return arg1(retryPurchaseAfterUpsell())
        end,
        setPromptState = function(arg2)
            return arg1(SetPromptState(arg2))
        end,
        setWindowState = function(arg2)
            return arg1(SetWindowState(arg2))
        end,
        onUpsellSuggestionsSelected = function(tbl1, num1: number, str1: string, str2: string?)
            return arg1(PromptNativeUpsellSuggestions(tbl1, num1, str1, str2))
        end,
        onAnalyticEvent = function(arg2, arg3)
            return arg1(sendEvent(arg2, arg3))
        end,
        setPostPurchaseActions = function(arg2)
            arg1(SetPostPurchaseActions(arg2))
        end
    }
end)(function(arg1)
    local navigation = Navigation.useNavigation()

    return Roact.createElement(var1, Cryo.Dictionary.join(arg1, { navigation = navigation }))
end))

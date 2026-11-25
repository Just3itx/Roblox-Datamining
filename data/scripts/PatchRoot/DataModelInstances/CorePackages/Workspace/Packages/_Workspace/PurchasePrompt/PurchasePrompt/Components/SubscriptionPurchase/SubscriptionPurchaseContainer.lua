-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local PurchasePrompt = script:FindFirstAncestor("PurchasePrompt")
local PurchasePromptParent = PurchasePrompt.Parent
local Roact = require(PurchasePromptParent.PurchasePromptDeps).Roact
local React = require(PurchasePromptParent.React)
local ToastRodux = require(PurchasePromptParent.ToastRodux)

local CoreGui = game:GetService("CoreGui")
local _RobloxGui = CoreGui:WaitForChild("RobloxGui")
local CoreScriptsRootProvider = require(PurchasePromptParent.CoreScriptsRoactCommon).CoreScriptsRootProvider
local FocusNavigationUtils = require(PurchasePromptParent.FocusNavigationUtils)
local FocusRoot = FocusNavigationUtils.FocusRoot
local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum

local RequestType = require(PurchasePrompt.Enums.RequestType)

local completeRequest = require(PurchasePrompt.Thunks.completeRequest)
local launchSubscriptionPurchase = require(PurchasePrompt.Thunks.launchSubscriptionPurchase)
local sendEvent = require(PurchasePrompt.Thunks.sendEvent)
local connectToStore = require(PurchasePrompt.connectToStore)

local ExternalEventConnection = require(PurchasePrompt.Components.Connection.ExternalEventConnection)
local SubscriptionPurchaseOverlay = require(script.Parent.SubscriptionPurchaseOverlay)

local SetCurrentToastMessage = ToastRodux.Actions.SetCurrentToastMessage

local var1 = Roact.Component:extend(script.Name)

local GetFFlagEnableSubscriptionPurchaseToast = require(PurchasePrompt.Flags.GetFFlagEnableSubscriptionPurchaseToast)
local FFlagSetMenuOnPurchasePrompt = require(PurchasePrompt.Flags.FFlagSetMenuOnPurchasePrompt)

function var1.init(arg1)
    arg1.state = {
        screenSize = Vector2.new(0, 0)
    }

    function arg1.changeScreenSize(arg2)
        if arg1.state.screenSize ~= arg2.AbsoluteSize then
            arg1:setState({ screenSize = arg2.AbsoluteSize })
        end
    end

    arg1.savedSelectedCoreObject = nil
    function arg1.endPurchase()
        arg1:restoreSelectedObject()
        arg1.props.completeRequest()
    end
end

function var1.saveSelectedObject(arg1)
    arg1.savedSelectedCoreObject = GuiService.SelectedCoreObject
    GuiService.SelectedCoreObject = nil
end

function var1.restoreSelectedObject(arg1)
    if arg1.savedSelectedCoreObject == nil or arg1.savedSelectedCoreObject:IsDescendantOf(CoreGui) then
        GuiService.SelectedCoreObject = arg1.savedSelectedCoreObject
    end
end

function var1.createElement(arg1)
    local props = arg1.props
    local state = arg1.state

    arg1:saveSelectedObject()

    local subscriptionPurchaseInfo = props.subscriptionPurchaseInfo
    local primaryPaymentProviderType, var2

    if subscriptionPurchaseInfo == nil then
        primaryPaymentProviderType = nil
        var2 = nil
    else
        primaryPaymentProviderType = subscriptionPurchaseInfo.PrimaryPaymentProviderType
        if subscriptionPurchaseInfo.AllPaymentProviderTypes then
            var2 = subscriptionPurchaseInfo.AllPaymentProviderTypes[2]
        else
            var2 = nil
        end
    end
    local createElement2 = Roact.createElement
    local tbl1 = {
        Size = UDim2.new(1, 0, 1, 0),
        [Roact.Change.AbsoluteSize] = arg1.changeScreenSize,
        BackgroundTransparency = 1
    }

    return createElement2("Frame", tbl1, {
        Prompt = Roact.createElement(SubscriptionPurchaseOverlay, {
            screenSize = state.screenSize,
            promptState = props.promptState,
            purchaseError = props.purchaseError,
            economicRestrictionError = props.economicRestrictionError,
            subscriptionId = props.subscriptionId,
            name = props.subscriptionPurchaseInfo.Name,
            subscriptionProviderId = props.subscriptionPurchaseInfo.SubscriptionProviderId,
            subscriptionProviderName = props.subscriptionPurchaseInfo.SubscriptionProviderName,
            priceTier = props.subscriptionPurchaseInfo.PriceTier,
            displayPrice = props.subscriptionPurchaseInfo.DisplayPrice,
            period = props.subscriptionPurchaseInfo.DisplaySubscriptionPeriod,
            disclaimerText = props.subscriptionPurchaseInfo.DisclaimerText,
            description = props.subscriptionPurchaseInfo.Description,
            itemIcon = props.subscriptionPurchaseInfo.ImageUrl,
            primaryPaymentMethod = primaryPaymentProviderType,
            secondaryPaymentMethod = var2,
            isGamepadEnabled = props.isGamepadEnabled,
            isTestingMode = props.subscriptionPurchaseInfo.IsTestingMode,
            promptSubscriptionPurchase = props.promptSubscriptionPurchase,
            endPurchase = arg1.endPurchase,
            onAnalyticEvent = props.onAnalyticEvent,
            setCurrentToastMessage = props.setCurrentToastMessage
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
    })
end

function var1.render(arg1)
    if arg1.props.requestType ~= RequestType.Subscription then
        if FFlagSetMenuOnPurchasePrompt then
            GuiService:SetMenuIsOpen(false, "SubscriptionUpsellContainer")
        end
        return nil
    end

    local subscriptionPurchaseContainer = arg1:createElement()
    if FFlagSetMenuOnPurchasePrompt then
        if subscriptionPurchaseContainer ~= nil then
            arg1.menuOpenedBySelf = true
        end
        GuiService:SetMenuIsOpen(subscriptionPurchaseContainer ~= nil, "SubscriptionUpsellContainer")
    end

    return Roact.createElement(CoreScriptsRootProvider, {}, {
        FocusNavigationCoreScriptsWrapper = React.createElement(
            FocusRoot,
            {
                surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.CentralOverlay,
                isIsolated = true,
                isAutoFocusRoot = true
            },
            { SubscriptionPurchaseContainer = subscriptionPurchaseContainer }
        )
    })
end

return (connectToStore(function(arg1)
    return {
        requestType = arg1.promptRequest.requestType,
        promptState = arg1.promptState,
        purchaseError = arg1.purchaseError,
        economicRestrictionError = arg1.economicRestrictionError,
        subscriptionPurchaseInfo = arg1.subscriptionPurchaseInfo,
        subscriptionId = arg1.promptRequest.id,
        isGamepadEnabled = arg1.gamepadEnabled
    }
end, function(arg1)
    return {
        promptSubscriptionPurchase = function(arg2)
            return arg1(launchSubscriptionPurchase(arg2))
        end,
        completeRequest = function()
            return arg1(completeRequest())
        end,
        onAnalyticEvent = function(arg2, arg3)
            return arg1(sendEvent(arg2, arg3))
        end,
        setCurrentToastMessage = GetFFlagEnableSubscriptionPurchaseToast() and function(arg2)
            arg1(SetCurrentToastMessage(arg2))
        end or nil
    }
end)(var1))

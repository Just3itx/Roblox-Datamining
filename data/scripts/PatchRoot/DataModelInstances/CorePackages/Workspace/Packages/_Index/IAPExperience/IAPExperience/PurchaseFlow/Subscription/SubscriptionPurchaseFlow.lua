-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)

local getPartialPageModalMiddleContentWidth = require(scriptParentParentParentParent.UIBlox).App.Dialog.Modal.getPartialPageModalMiddleContentWidth

local SubscriptionPurchaseFlowState = require(scriptParent.SubscriptionPurchaseFlowState)

local Animator = require(scriptParentParentParent.Generic.Animator)
local PurchaseErrorPrompt = require(scriptParentParentParent.Generic.PurchaseErrorPrompt)

local SubscriptionPurchasePrompt = require(scriptParentParentParent.Subscription.SubscriptionPurchasePrompt)

local formatSubscriptionPurchaseEventData = require(scriptParentParentParent.Utility.formatSubscriptionPurchaseEventData)

local var1 = Roact.Component:extend(script.Name)

local Generic = scriptParentParentParent.Generic
local PurchaseFlowType = require(Generic.PurchaseFlowType)

local VerifiedParentalConsentDialog = require(scriptParentParentParentParent.VerifiedParentalConsentDialog).VerifiedParentalConsentDialog

function var1.init(arg1)
    arg1.state = {
        analyticId = HttpService:GenerateGUID(false)
    }
end

function var1.didUpdate(tbl1, tbl2, _)
    local props = tbl1.props

    if tbl2.purchaseState ~= props.purchaseState then
        tbl1:reportPurchaseEvent("ViewShown")
    end
end

function var1.reportUserInput(tbl1, str1: string)
    tbl1:reportPurchaseEvent("UserInput", str1)
end

function var1.reportPurchaseEvent(tbl1, str1: string, str2: string?)
    local props = tbl1.props

    if not props.onAnalyticEvent then
        return
    end

    local var2 = formatSubscriptionPurchaseEventData(
        tbl1.state.analyticId,
        str1,
        SubscriptionPurchaseFlowState.toRawValue(props.purchaseState),
        str2,
        props.subscriptionProviderId,
        props.subscriptionId,
        props.name,
        props.description,
        props.period,
        props.priceTier,
        props.displayPrice
    )
    props.onAnalyticEvent("SubscriptionPurchase", var2)
end

function var1.render(arg1)
    local props = arg1.props
    local purchaseState = props.purchaseState

    local partialPageModalMiddleContentWidth = getPartialPageModalMiddleContentWidth(props.screenSize.X)

    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }, {
        SubscriptionPurchasePromptAnimator = Roact.createElement(Animator, {
            shouldShow = purchaseState == SubscriptionPurchaseFlowState.PurchaseModal,
            shouldAnimate = true,
            animateDown = partialPageModalMiddleContentWidth == 492,
            renderChildren = function()
                return Roact.createElement(SubscriptionPurchasePrompt, {
                    name = props.name,
                    subscriptionProviderName = props.subscriptionProviderName,
                    displayPrice = props.displayPrice,
                    period = props.period,
                    disclaimerText = props.disclaimerText,
                    description = props.description,
                    itemIcon = props.itemIcon,
                    disablePurchase = props.disablePurchase,
                    disablePurchaseText = props.disablePurchaseText,
                    shouldUseNewModalDesign = props.shouldUseNewModalDesign,
                    isRobuxSubscription = props.isRobuxSubscription,
                    creatorName = props.creatorName,
                    creatorVerified = props.creatorVerified,
                    primaryPaymentMethod = props.primaryPaymentMethod,
                    secondaryPaymentMethod = props.secondaryPaymentMethod,
                    isTestingMode = props.isTestingMode,
                    screenSize = props.screenSize,
                    purchaseSubscriptionActivated = function(str1: string)
                        arg1:reportUserInput("Subscribe")
                        props.purchaseSubscription(str1)
                        if props.isTestingMode then
                            props.flowComplete()
                        end
                    end,
                    cancelPurchaseActivated = function()
                        arg1:reportUserInput("Cancel")
                        props.cancelPurchase()
                    end,
                    onReport = if props.shouldUseNewModalDesign then props.onReport else nil,
                    onShare = if props.shouldUseNewModalDesign then props.onShare else nil
                })
            end
        }),
        PurchaseErrorPromptAnimator = Roact.createElement(Animator, {
            shouldShow = purchaseState == SubscriptionPurchaseFlowState.Error,
            shouldAnimate = true,
            renderChildren = function()
                return Roact.createElement(PurchaseErrorPrompt, {
                    screenSize = props.screenSize,
                    errorType = props.errorType,
                    economicRestrictionError = props.economicRestrictionError,
                    flowType = PurchaseFlowType.Subscription,
                    doneControllerIcon = props.acceptControllerIcon,
                    doneActivated = function()
                        arg1:reportUserInput("Done")
                        props.flowComplete()
                    end
                })
            end
        }),
        PurchaseVPCPromptAnimator = Roact.createElement(Animator, {
            shouldShow = purchaseState == SubscriptionPurchaseFlowState.PurchaseVPCModal,
            shouldAnimate = true,
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
                    end
                })
            end
        })
    })
end

return var1

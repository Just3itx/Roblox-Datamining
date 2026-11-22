-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local ContextActionService = game:GetService("ContextActionService")

local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)

local getPartialPageModalMiddleContentWidth = require(scriptParentParentParentParent.UIBlox).App.Dialog.Modal.getPartialPageModalMiddleContentWidth

local PremiumUpsellFlowState = require(scriptParent.PremiumUpsellFlowState)

local Animator = require(scriptParentParentParent.Generic.Animator)
local Constants = require(scriptParentParentParent.Generic.Constants)

local PurchaseErrorPrompt = require(scriptParentParentParent.Generic.PurchaseErrorPrompt)
local PremiumUpsellPrompt = require(scriptParentParentParent.PremiumUpsell.PremiumUpsellPrompt)

local getModalShownEventData = require(scriptParentParentParent.Utility.getModalShownEventData)
local getUserInputEventData = require(scriptParentParentParent.Utility.getUserInputEventData)

local getEnableCentralOverlayForUpsellPrompt = require(scriptParentParentParent.Flags.getEnableCentralOverlayForUpsellPrompt)

local VerifiedParentalConsentDialog = require(scriptParentParentParentParent.VerifiedParentalConsentDialog).VerifiedParentalConsentDialog

local bool1 = game:DefineFastFlag("CompleteFlowInStudioAccept", false)

local var1 = Roact.Component:extend(script.Name)

function var1.init(arg1)
    arg1.state = {
        analyticId = HttpService:GenerateGUID(false)
    }

    function arg1.closeModal()
        local props = arg1.props
        arg1:reportUserInput("Cancel")
        props.cancelPurchase()
        arg1:closeCentralOverlay()

        arg1:UnbindActions()
    end
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

function var1.constructPremiumUpsellPromptAnimatorObj(arg1)
    local props = arg1.props

    local partialPageModalMiddleContentWidth = getPartialPageModalMiddleContentWidth(props.screenSize.X)

    return {
        shouldShow = props.purchaseState == PremiumUpsellFlowState.PurchaseModal,
        shouldAnimate = true,
        animateDown = partialPageModalMiddleContentWidth == 492,
        renderChildren = function()
            return Roact.createElement(PremiumUpsellPrompt, {
                screenSize = props.screenSize,
                isCatalog = props.isCatalog,
                currencySymbol = props.currencySymbol,
                robuxPrice = props.robuxPrice,
                robuxAmount = props.robuxAmount,
                acceptControllerIcon = props.acceptControllerIcon,
                purchasePremiumActivated = function()
                    arg1:reportUserInput("Subscribe")
                    props.purchasePremium()
                    if bool1 and game:GetService("RunService"):IsStudio() then
                        props.flowComplete()
                    end
                    arg1:closeCentralOverlay()
                end,
                cancelPurchaseActivated = function()
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

    return {
        shouldShow = props.purchaseState == PremiumUpsellFlowState.Error,
        shouldAnimate = true,
        renderChildren = function()
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
    }
end

function var1.constructPurchaseVPCPromptAnimatorObj(arg1)
    local props = arg1.props

    arg1:BindCancelAction()

    return {
        shouldShow = props.purchaseState == PremiumUpsellFlowState.PurchaseVPCModal,
        shouldAnimate = true,
        renderChildren = function()
            return Roact.createElement(VerifiedParentalConsentDialog, {
                screenSize = props.screenSize,
                isActionable = false,
                modalType = props.purchaseVPCType,
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

    if purchaseState == PremiumUpsellFlowState.PurchaseModal then
        tbl2.dispatchCentralOverlay(Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR, tbl1:constructPremiumUpsellPromptAnimatorObj())
    end

    if purchaseState == PremiumUpsellFlowState.Error then
        tbl2.dispatchCentralOverlay(Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR, tbl1:constructPurchaseErrorPromptAnimatorObj())
    end

    if purchaseState == PremiumUpsellFlowState.PurchaseVPCModal then
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

    local var3 = PremiumUpsellFlowState.toRawValue(props.purchaseState)
    local httpService = HttpService
    local input = {
        universe_id = tostring(game.GameId)
    }
    local var4 = var2(analyticId, eventPrefix, "PremiumUpsell", var3, httpService:JSONEncode(input))

    props.onAnalyticEvent("UserPurchaseFlow", var4)
end

function var1.reportUserInput(tbl1, str1: string)
    local props = tbl1.props
    local state = tbl1.state

    if not tbl1.props.onAnalyticEvent then
        return
    end

    local var2 = getUserInputEventData
    local analyticId = state.analyticId
    local eventPrefix = props.eventPrefix

    local var3 = PremiumUpsellFlowState.toRawValue(props.purchaseState)

    local httpService = HttpService
    local input = {
        universe_id = tostring(game.GameId)
    }
    local var4 = var2(analyticId, eventPrefix, "PremiumUpsell", var3, str1, httpService:JSONEncode(input))

    props.onAnalyticEvent("UserPurchaseFlow", var4)
end

function var1.getChildrenElements(arg1)
    return {
        PremiumUpsellPromptAnimator = Roact.createElement(Animator, arg1:constructPremiumUpsellPromptAnimatorObj()),
        PurchaseErrorPromptAnimator = Roact.createElement(Animator, arg1:constructPurchaseErrorPromptAnimatorObj()),
        PurchaseVPCPromptAnimator = Roact.createElement(Animator, arg1:constructPurchaseVPCPromptAnimatorObj())
    }
end

function var1.render(arg1)
    local props = arg1.props

    local var2 = getEnableCentralOverlayForUpsellPrompt() and props.dispatchCentralOverlay and {} or arg1:getChildrenElements()

    return Roact.createElement("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 }, var2)
end

return var1

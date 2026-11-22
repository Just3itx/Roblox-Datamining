-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")

local scriptParent = script.Parent
local scriptParentParentParent = scriptParent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent

local Roact = require(scriptParentParentParentParent.Roact)

local BuyRobuxFlowState = require(scriptParent.BuyRobuxFlowState)

local Constants = require(scriptParentParentParent.Generic.Constants)
local LoadingOverlay = require(scriptParentParentParent.Generic.LoadingOverlay)
local LoadingOverlayState = require(scriptParentParentParent.Generic.LoadingOverlayState)
local BuyRobuxPage = require(scriptParentParentParent.BuyRobux.BuyRobuxPage)
local PurchaseErrorPrompt = require(scriptParentParentParent.Generic.PurchaseErrorPrompt)
local U13ConfirmPrompt = require(scriptParentParentParent.Generic.U13ConfirmPrompt)

local getModalShownEventData = require(scriptParentParentParent.Utility.getModalShownEventData)
local getUserInputEventData = require(scriptParentParentParent.Utility.getUserInputEventData)

local VerifiedParentalConsentDialog = require(scriptParentParentParentParent.VerifiedParentalConsentDialog).VerifiedParentalConsentDialog

local var1 = Roact.Component:extend(script.Name)

function var1.init(arg1)
    arg1.state = {
        analyticId = if arg1.props.analyticId then arg1.props.analyticId else HttpService:GenerateGUID(false)
    }
end

function var1.didUpdate(tbl1, tbl2, _)
    local props = tbl1.props

    if tbl2.purchaseState ~= props.purchaseState then
        tbl1:reportModalShown()
        tbl1:dispatchAndRenderModal(props)
    end
end

function var1.dispatchAndRenderModal(tbl1, tbl2)
    if tbl2.purchaseState == BuyRobuxFlowState.Error then
        tbl2.dispatchCentralOverlay(Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR, {
            shouldAnimate = tbl2.shouldAnimate,
            shouldShow = tbl2.purchaseState == BuyRobuxFlowState.Error,
            renderChildren = function()
                return Roact.createElement(PurchaseErrorPrompt, {
                    screenSize = tbl2.screenSize,
                    errorType = tbl2.errorType,
                    economicRestrictionError = tbl2.economicRestrictionError,
                    doneControllerIcon = tbl2.acceptControllerIcon,
                    doneActivated = function()
                        tbl1:reportUserInput("Done")
                        tbl2.flowComplete()
                        tbl2.dispatchCentralOverlay()
                    end
                })
            end
        })

        return
    end

    if tbl2.purchaseState == BuyRobuxFlowState.PurchaseWarning then
        tbl2.dispatchCentralOverlay(Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR, {
            shouldAnimate = tbl2.shouldAnimate,
            shouldShow = tbl2.purchaseState == BuyRobuxFlowState.PurchaseWarning,
            renderChildren = function()
                return Roact.createElement(U13ConfirmPrompt, {
                    screenSize = tbl2.screenSize,
                    modalType = tbl2.u13ConfirmType,
                    doneActivated = function()
                        tbl1:reportUserInput("Confirm")
                        tbl2.acceptPurchaseWarning()
                        tbl2.dispatchCentralOverlay()
                    end,
                    cancelActivated = function()
                        tbl1:reportUserInput("Cancel")
                        tbl2.cancelPurchase()
                        tbl2.dispatchCentralOverlay()
                    end
                })
            end
        })
    elseif tbl2.purchaseState == BuyRobuxFlowState.PurchaseVPC then
        tbl2.dispatchCentralOverlay(Constants.CENTRAL_OVERLAY_TYPE_ANIMATOR, {
            shouldAnimate = tbl2.shouldAnimate,
            shouldShow = tbl2.purchaseState == BuyRobuxFlowState.PurchaseVPC,
            renderChildren = function()
                return Roact.createElement(VerifiedParentalConsentDialog, {
                    screenSize = tbl2.screenSize,
                    isActionable = false,
                    modalType = tbl2.purchaseVPCType,
                    onDismiss = function()
                        tbl1:reportUserInput("Close")
                        tbl2.flowComplete()
                        tbl2.dispatchCentralOverlay()
                    end
                })
            end
        })
    end
end

function var1.reportModalShown(arg1)
    local props = arg1.props
    local state = arg1.state

    if not arg1.props.onAnalyticEvent then
        return
    end

    local modalShownEventData = getModalShownEventData(state.analyticId, "", "BuyRobux", BuyRobuxFlowState.toRawValue(props.purchaseState))

    props.onAnalyticEvent("UserPurchaseFlow", modalShownEventData)
end

function var1.reportUserInput(tbl1, str1: string)
    local props = tbl1.props
    local state = tbl1.state

    if not tbl1.props.onAnalyticEvent then
        return
    end

    local userInputEventData = getUserInputEventData(state.analyticId, "", "BuyRobux", BuyRobuxFlowState.toRawValue(props.purchaseState), str1)

    props.onAnalyticEvent("UserPurchaseFlow", userInputEventData)
end

function var1.purchaseStateToOverlayState(_, arg1)
    if arg1 == BuyRobuxFlowState.Loading then
        return LoadingOverlayState.Loading
    end

    if arg1 == BuyRobuxFlowState.RobuxPurchasePending then
        return LoadingOverlayState.PurchasingRobux
    end

    if arg1 == BuyRobuxFlowState.RobuxGrantPending then
        return LoadingOverlayState.WaitingForRobux
    end

    if arg1 == BuyRobuxFlowState.PurchaseWarning then
        return LoadingOverlayState.None
    end

    if arg1 == BuyRobuxFlowState.None then
        return LoadingOverlayState.None
    end

    return nil
end

function var1.render(arg1)
    local props = arg1.props
    local state = arg1.state
    local purchaseState = props.purchaseState

    local loadingState = arg1:purchaseStateToOverlayState(props.purchaseState)

    return Roact.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }, {
        BuyRobuxFrame = Roact.createElement(BuyRobuxPage, {
            showCloseButton = props.showCloseButton,
            showBackground = props.showBackground,
            isConsoleSize = props.isConsoleSize,
            robuxBalance = props.robuxBalance,
            robuxPackages = props.robuxPackages,
            robuxPackageActivated = function(str1: string)
                arg1:reportUserInput("Confirm")
                props.purchaseRobux(str1)
            end,
            onPageClose = props.onPageClose,
            hasNativePurchaseSucceeded = purchaseState == BuyRobuxFlowState.Succeed,
            shouldAnimate = props.shouldAnimate,
            analyticId = state.analyticId,
            onAnalyticEvent = props.onAnalyticEvent
        }),
        LoadingOverlay = Roact.createElement(
            LoadingOverlay,
            {
                shouldAnimate = false,
                showOverlay = loadingState ~= nil,
                loadingState = loadingState
            }
        )
    })
end
return var1

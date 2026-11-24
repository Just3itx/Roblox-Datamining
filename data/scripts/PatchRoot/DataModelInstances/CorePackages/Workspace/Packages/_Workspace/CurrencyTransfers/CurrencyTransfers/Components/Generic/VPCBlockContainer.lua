-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)
local TransferLocalizationKeys = require(CurrencyTransfers.Localization.TransferLocalizationKeys)

local Foundation = require(CurrencyTransfersParent.Foundation)
local ButtonVariant = Foundation.Enums.ButtonVariant
local Dialog = Foundation.Dialog
local DialogSize = Foundation.Enums.DialogSize
local EnumsOrientation = Foundation.Enums.Orientation

local useLocalization = require(CurrencyTransfersParent.Localization).Hooks.useLocalization

local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)
local useDispatch = require(CurrencyTransfersParent.RoactUtils).Hooks.RoactRodux.useDispatch

local processTransfer = require(CurrencyTransfers.Actions.Send.processTransfer)
local acceptTransfer = require(CurrencyTransfers.Actions.Receive.acceptTransfer)
local initiateTransfer = require(CurrencyTransfers.Actions.Send.initiateTransfer)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)
local TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)
local TransferRetryOrigin = require(CurrencyTransfers.Enums.TransferRetryOrigin)

local AmpUpsell = require(CurrencyTransfersParent.AmpUpsell)
local AccessResponseEnum = AmpUpsell.AmpEnums.AccessResponseEnum
local ActionTypeEnum = AmpUpsell.AmpEnums.ActionTypeEnum
local ActionStatusEnum = AmpUpsell.AmpEnums.ActionStatusEnum
local InExpAmpWizardController = AmpUpsell.InExpAmpWizardController
local OpenAmpWizardContainer = AmpUpsell.OpenAmpWizardContainer

local FFlagEnableCurrencyTransferWizardVPCPrologue = require(CurrencyTransfers.Flags.FFlagEnableCurrencyTransferWizardVPCPrologue)

local FFlagCurrencyTransferVPCUseAmpWizardContainerForInApp = require(CurrencyTransfers.Flags.FFlagCurrencyTransferVPCUseAmpWizardContainerForInApp)
local FFlagCurrencyTransferVpcUfoDirect = require(CurrencyTransfers.Flags.FFlagCurrencyTransferVpcUfoDirect)

local AmpWizardTransferConstants = require(CurrencyTransfers.Constants.AmpWizardTransferConstants)
local getCounterUserId = require(CurrencyTransfers.Utils.getCounterUserId)
local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local RobuxTransferFlowEventName = require(CurrencyTransfers.Enums.RobuxTransferFlowEventName)
local logCurrencyTransferCounter = require(CurrencyTransfers.Utils.logCurrencyTransferCounter)
local logRobuxTransferFlowEvent = require(CurrencyTransfers.Utils.logRobuxTransferFlowEvent)
local getTransferRequestInternalId = require(CurrencyTransfers.Utils.getTransferRequestInternalId)

local function isVpcRequestSubmitted(arg1): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return type(arg1) == "table"
        and (arg1[ActionTypeEnum.ParentConsent] == ActionStatusEnum.Success
            or arg1[ActionTypeEnum.ParentLink] == ActionStatusEnum.Success)
end

local function WizardPrologueOpener(tbl1)
    local openAmpWizard = tbl1.openAmpWizard

    local var1 = React.useRef(false)
    React.useEffect(function()
        if not var1.current then
            var1.current = true
            openAmpWizard()
        end
        return nil
    end, { openAmpWizard })

    return nil
end

local function VPCBlockContainer(tbl1)
    local var1 = useLocalization(TransferLocalizationKeys.Presets.VPCBlockContainer)

    local var2 = useTransferStore()
    local var3 = if FFlagCurrencyTransferVPCUseAmpWizardContainerForInApp then useDispatch() else nil
    local direction = tbl1.direction
    local triggerOnClose = var2.triggerOnClose
    local selectedAmount = var2.getSelectedAmount(false)
    local transferRetryOrigin = var2.getTransferRetryOrigin(false)
    local transferRequestId = var2.getTransferRequestId(false)
    local bool1 = FFlagCurrencyTransferVPCUseAmpWizardContainerForInApp
        and var2.getTransferOrigination(false) == TransferOrigination.InExperience

    if FFlagCurrencyTransferVpcUfoDirect and not FFlagCurrencyTransferVPCUseAmpWizardContainerForInApp then
        bool1 = var2.getTransferOrigination(false) == TransferOrigination.InExperience
    end

    local var4 = if direction == TransferDirection.Send then var1.AskParentBodySend else var1.AskParentBodyReceive
    local fFlagEnableReusableVpcPrologue = FFlagEnableCurrencyTransferWizardVPCPrologue
        and AmpUpsell.GetFFlagEnableAmpVPCPrologue()
        and AmpUpsell.GetFFlagEnableReusableVPCPrologue()

    React.useEffect(function()
        logCurrencyTransferCounter(
            var2,
            CurrencyTransferTelemetry.CurrencyTransferVPCBlockDialogShownCounter,
            { recourseSurface = "vpc" }
        )

        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(var2, RobuxTransferFlowEventName.vpc_block_shown)
        end
        return nil
    end, { var2 })

    local function logAskClicked() -- Luacid: Inlined by compiler; 2 call sites recovered
        logCurrencyTransferCounter(
            var2,
            CurrencyTransferTelemetry.CurrencyTransferVPCBlockAskClickedCounter,
            { recourseSurface = "vpc" }
        )

        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(var2, RobuxTransferFlowEventName.vpc_ask_clicked)
        end
    end

    local function logCancelClicked() -- Luacid: Inlined by compiler; 2 call sites recovered
        logCurrencyTransferCounter(
            var2,
            CurrencyTransferTelemetry.CurrencyTransferVPCBlockCancelClickedCounter,
            { recourseSurface = "vpc" }
        )

        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(var2, RobuxTransferFlowEventName.vpc_cancel_clicked)
        end
    end

    local function onCancelClicked()
        logCancelClicked()
        triggerOnClose()
    end

    local var5 = nil
    if FFlagCurrencyTransferVpcUfoDirect then
        local useAmpUpsellLauncher = require(CurrencyTransfersParent.AmpV2Wizard).useAmpUpsellLauncher
        local onEvent = React.useCallback(function(arg1)
            if not fFlagEnableReusableVpcPrologue or arg1.node ~= "Prologue" then
                return
            end

            if arg1.outcome == "ODP" or arg1.outcome == "Remote" then
                logAskClicked()
            elseif arg1.outcome == "Cancel" then
                logCancelClicked()
            end
        end, { var2, fFlagEnableReusableVpcPrologue })

        var5 = useAmpUpsellLauncher({
            surface = AmpWizardTransferConstants.ENTRY_POINT_EVENT_CTX,
            odpEventContext = AmpWizardTransferConstants.ENTRY_POINT_EVENT_CTX,
            onEvent = onEvent
        })
    end

    local function openAmpWizard()
        if not fFlagEnableReusableVpcPrologue then
            logAskClicked()
        end

        if not tbl1.ampFeatureCheck then
            triggerOnClose()
            return
        end

        local promptState = var2.getPromptState(false)
        var2.setPreviousPromptState(promptState)
        var2.setPromptState(PromptState.Hidden)

        local requestDetails = {
            transferType = "Robux",
            transferId = getTransferRequestInternalId(transferRequestId),
            robuxTransferAmount = tostring(selectedAmount or 0)
        }

        local counterUserId = getCounterUserId(var2, direction)

        local var6 = counterUserId and {{
            name = "targetUser",
            value = tostring(counterUserId),
            type = "UserId"
        }} or nil

        if FFlagCurrencyTransferVpcUfoDirect
            and SharedFlags.FFlagEnableAmpV2Wizard
            and not bool1
            and var5
            and require(CurrencyTransfersParent.AmpV2Wizard).FFlagAmpV2WizardTerminalOutcome
        then
            local var7 = require(CurrencyTransfersParent.UniversalAppPolicy).getAppFeaturePolicies()
            local vpcRequestTypeEnum = AmpUpsell.AmpEnums.VPCRequestTypeEnum
            local requestType = if direction == TransferDirection.Receive then vpcRequestTypeEnum.ReceiveTransfer else vpcRequestTypeEnum.SendTransfer

            if var7.getUseAmpV2WizardForVpc() and table.find(var7.getAmpV2VpcExcludedRequestTypes(), requestType) == nil then
                local function handleVpcSubmitted() -- Luacid: Inlined by compiler; 1 call site recovered
                    if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
                        logRobuxTransferFlowEvent(var2, RobuxTransferFlowEventName.vpc_submitted)
                    end

                    if SharedFlags.FFlagSduiOpenIncomingTransferUpsellAction and direction == TransferDirection.Receive then
                        var2.triggerOnPromptOptimisticHide()
                    end
                end

                local extraProps = {
                    usePrologue = fFlagEnableReusableVpcPrologue == true
                }
                if fFlagEnableReusableVpcPrologue then
                    extraProps.prologueCopy = {
                        title = var1.AskParentTitle,
                        description = var4,
                        confirmLabel = var1.Ask
                    }
                end
                var5({
                    flow = {
                        name = "VPC",
                        props = { requestType = requestType, requestDetails = requestDetails }
                    },
                    extraProps = extraProps
                }):andThen(
                    function(arg1)
                        if arg1.reason == "Completed" and (arg1.outcome == "Done" or arg1.outcome == "Success") then
                            handleVpcSubmitted()
                        end

                        triggerOnClose()
                    end
                )

                return
            end
        end

        if FFlagCurrencyTransferVPCUseAmpWizardContainerForInApp and not bool1 then
            var3(OpenAmpWizardContainer(tbl1.ampFeatureCheck, function(granted, arg1)
                local bool2 = isVpcRequestSubmitted(arg1)

                if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest and bool2 then
                    logRobuxTransferFlowEvent(var2, RobuxTransferFlowEventName.vpc_submitted)
                end

                if SharedFlags.FFlagSduiOpenIncomingTransferUpsellAction and bool2 and direction == TransferDirection.Receive then
                    var2.triggerOnPromptOptimisticHide()
                end

                if granted ~= AccessResponseEnum.Granted then
                    triggerOnClose()

                    return
                end

                local previousPromptState = var2.getPreviousPromptState(false)
                if previousPromptState then
                    var2.setPromptState(previousPromptState)
                end

                if transferRetryOrigin == TransferRetryOrigin.AcceptTransfer then
                    acceptTransfer(var2)
                elseif transferRetryOrigin == TransferRetryOrigin.InitiateTransfer then
                    initiateTransfer(var2)
                elseif transferRetryOrigin == TransferRetryOrigin.ProcessTransfer then
                    processTransfer(var2, selectedAmount or 0)
                elseif direction == TransferDirection.Receive then
                    acceptTransfer(var2)
                else
                    processTransfer(var2, selectedAmount or 0)
                end
            end, requestDetails, AmpWizardTransferConstants.ENTRY_POINT_EVENT_CTX, var6, AmpWizardTransferConstants.NAMESPACE_NAME, nil, nil, nil, if fFlagEnableReusableVpcPrologue then true else nil, fFlagEnableReusableVpcPrologue
                and {
                    config = {
                        titleText = var1.AskParentTitle,
                        bodyText = var4,
                        confirmText = var1.Ask,
                        hideCancel = true,
                        actionOrientation = "Vertical",
                        hasBackdrop = true,
                        closeOnClickOutside = true,
                        onCloseCancels = true
                    },
                    onConfirm = logAskClicked,
                    onCancel = logCancelClicked
                }
                or nil))

            return
        end

        InExpAmpWizardController.OpenAmpWizardContainerInExp(tbl1.ampFeatureCheck, function(granted, arg1)
            local bool2 = isVpcRequestSubmitted(arg1)

            if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest and bool2 then
                logRobuxTransferFlowEvent(var2, RobuxTransferFlowEventName.vpc_submitted)
            end

            if SharedFlags.FFlagSduiOpenIncomingTransferUpsellAction and bool2 and direction == TransferDirection.Receive then
                var2.triggerOnPromptOptimisticHide()
            end

            if granted ~= AccessResponseEnum.Granted then
                triggerOnClose()

                return
            end

            local previousPromptState = var2.getPreviousPromptState(false)
            if previousPromptState then
                var2.setPromptState(previousPromptState)
            end

            if transferRetryOrigin == TransferRetryOrigin.AcceptTransfer then
                acceptTransfer(var2)
            elseif transferRetryOrigin == TransferRetryOrigin.InitiateTransfer then
                initiateTransfer(var2)
            elseif transferRetryOrigin == TransferRetryOrigin.ProcessTransfer then
                processTransfer(var2, selectedAmount or 0)
            elseif direction == TransferDirection.Receive then
                acceptTransfer(var2)
            else
                processTransfer(var2, selectedAmount or 0)
            end
        end, requestDetails, AmpWizardTransferConstants.ENTRY_POINT_EVENT_CTX, var6, AmpWizardTransferConstants.NAMESPACE_NAME, nil, nil, nil, if fFlagEnableReusableVpcPrologue then true else nil, fFlagEnableReusableVpcPrologue
            and {
                config = {
                    titleText = var1.AskParentTitle,
                    bodyText = var4,
                    confirmText = var1.Ask,
                    hideCancel = true,
                    actionOrientation = "Vertical",
                    hasBackdrop = true,
                    closeOnClickOutside = true,
                    onCloseCancels = true
                },
                onConfirm = logAskClicked,
                onCancel = logCancelClicked
            }
            or nil)
    end

    if fFlagEnableReusableVpcPrologue then
        return React.createElement(WizardPrologueOpener, { openAmpWizard = openAmpWizard })
    end

    return React.createElement(
        Dialog.Root,
        {
            size = DialogSize.Small,
            hasBackdrop = true,
            closeOnClickOutside = true,
            onClose = onCancelClicked
        },
        {
            DialogTitle = React.createElement(Dialog.Title, { text = var1.AskParentTitle }),
            DialogContent = React.createElement(Dialog.Content, nil, { DialogText = React.createElement(Dialog.Text, { Text = var4 }) }),
            DialogActions = React.createElement(Dialog.Actions, {
                orientation = EnumsOrientation.Vertical,
                actions = {{
                    text = var1.Ask,
                    variant = ButtonVariant.Emphasis,
                    onActivated = openAmpWizard
                }}
            })
        }
    )
end

return VPCBlockContainer

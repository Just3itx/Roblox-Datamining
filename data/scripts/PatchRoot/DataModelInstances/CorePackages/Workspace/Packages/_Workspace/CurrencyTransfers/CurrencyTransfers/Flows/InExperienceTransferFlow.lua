-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local HttpService = game:GetService("HttpService")

local React = require(CurrencyTransfersParent.React)
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)

local TransferRobuxApp = require(CurrencyTransfers.Components.TransferRobuxApp)
local createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)
local TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)

local GetFFlagCurrencyTransferUseBackendTransferLimits = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferUseBackendTransferLimits)
local handleTransferError = require(CurrencyTransfers.Actions.Send.handleTransferError)
local handleTransferBlock = require(CurrencyTransfers.Actions.Send.handleTransferBlock)
local FailureReason = require(CurrencyTransfers.Enums.FailureReason)
local ErrorTransferModel = require(CurrencyTransfers.Models.ErrorTransferModel)
local TransferRetryOrigin = require(CurrencyTransfers.Enums.TransferRetryOrigin)
local AmpWizardTransferConstants = require(CurrencyTransfers.Constants.AmpWizardTransferConstants)
local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local RobuxTransferFlowEventName = require(CurrencyTransfers.Enums.RobuxTransferFlowEventName)
local logCurrencyTransferCounter = require(CurrencyTransfers.Utils.logCurrencyTransferCounter)
local logRobuxTransferFlowEvent = require(CurrencyTransfers.Utils.logRobuxTransferFlowEvent)

local function InExperienceTransferFlow(tbl1)
    local initiateResponse = tbl1.initiateResponse
    assert(type(initiateResponse) == "table", "[InExperienceTransferFlow] initiateResponse must be a table")

    local transferStore = createTransferStore()
    if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
        transferStore.setTransferClientSessionId(HttpService:GenerateGUID(false))
    end

    transferStore.setDirection(TransferDirection.Send)
    transferStore.setTransferOrigination(TransferOrigination.InExperience)

    logCurrencyTransferCounter(transferStore, CurrencyTransferTelemetry.CurrencyTransferFlowOpenedCounter)
    if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
        logRobuxTransferFlowEvent(transferStore, RobuxTransferFlowEventName.in_experience_flow_open)
    end

    if tbl1.onClose then
        transferStore.setOnClose(tbl1.onClose)
    end

    if GetFFlagCurrencyTransferUseBackendTransferLimits() then
        if initiateResponse.minimumTransferAmount then
            transferStore.setMinimumTransferAmount(initiateResponse.minimumTransferAmount)
        end
        if initiateResponse.maximumTransferAmount then
            transferStore.setMaximumTransferAmount(initiateResponse.maximumTransferAmount)
        end
    end

    if initiateResponse.failureReason ~= nil then
        local var1 = ErrorTransferModel.format(initiateResponse)

        if var1.failureReason == FailureReason.AmpRecourseAvailable and var1.ampRecourseActions and var1.ampFeatureCheck then
            if not table.find(var1.ampRecourseActions, AmpWizardTransferConstants.RECOURSE_PLUS_SUBSCRIPTION)
                or var1.ampFeatureCheck ~= "CanInitiateRobuxTransfer"
            then
                handleTransferBlock(transferStore, var1.ampRecourseActions, var1.ampFeatureCheck, TransferRetryOrigin.ProcessTransfer)
            end
        else
            handleTransferError(transferStore, var1)
        end

        return React.createElement(TransferRobuxApp, { transferStore = transferStore })
    end

    assert(initiateResponse.transferRequestId, "[InExperienceTransferFlow] Missing initiateResponse.transferRequestId")
    local transferAmount = initiateResponse.robuxTransfer.transferAmount
    assert(
        type(transferAmount) == "number" and transferAmount > 0,
        "[InExperienceTransferFlow] transferAmount must be a positive number"
    )

    transferStore.setTransferRequestId(initiateResponse.transferRequestId)
    transferStore.setRobuxBalanceAmount(initiateResponse.senderRobuxBalance)
    transferStore.setBalanceReceivedFromApi(true)
    transferStore.setUserRelationshipDetail(initiateResponse.userRelationshipDetail)
    transferStore.setRecipient(initiateResponse.robuxTransfer.recipient)
    transferStore.setSender(initiateResponse.robuxTransfer.sender)
    transferStore.setSelectedAmount(transferAmount)

    transferStore.setPromptState(PromptState.TransferConfirm)

    return React.createElement(TransferRobuxApp, { transferStore = transferStore })
end

return InExperienceTransferFlow

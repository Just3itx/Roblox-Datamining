-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:20:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)

local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local acceptTransferRequest = require(CurrencyTransfers.NetworkRequests.acceptTransferRequest)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local _AcceptTransferModel = require(CurrencyTransfers.Models.AcceptTransferModel)
local _ErrorTransferModel = require(CurrencyTransfers.Models.ErrorTransferModel)
local FailureReason = require(CurrencyTransfers.Enums.FailureReason)
local handleReceiveSuccess = require(CurrencyTransfers.Actions.Receive.handleReceiveSuccess)
local handleReceiveError = require(CurrencyTransfers.Actions.Receive.handleReceiveError)
local handleReceiveBlock = require(CurrencyTransfers.Actions.Receive.handleReceiveBlock)
local TransferRetryOrigin = require(CurrencyTransfers.Enums.TransferRetryOrigin)
local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local RobuxTransferFlowEventName = require(CurrencyTransfers.Enums.RobuxTransferFlowEventName)
local logCurrencyTransferCounter = require(CurrencyTransfers.Utils.logCurrencyTransferCounter)
local logRobuxTransferFlowEvent = require(CurrencyTransfers.Utils.logRobuxTransferFlowEvent)

local function acceptTransfer(arg1)
    local networkImpl = arg1.getNetworkImpl()
    local setPromptState = arg1.setPromptState
    local setRobuxTransfer = arg1.setRobuxTransfer
    local setIsAlreadyAccepted = arg1.setIsAlreadyAccepted

    local transferRequestId = arg1.getTransferRequestId(false)

    if not transferRequestId then
        logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferAcceptFailedCounter)
        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.accept_failed)
        end
        handleReceiveError(arg1, nil)
        return
    end

    setPromptState(PromptState.ReceiveRequested)

    local tbl1 = { transferRequestId = transferRequestId }

    logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferAcceptAttemptedCounter)
    if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
        logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.accept_attempted)
    end

    return acceptTransferRequest(tbl1, nil, networkImpl):andThen(function(arg2)
        setPromptState(PromptState.ReceiveStarted)
        if not (arg2 and arg2.robuxTransfer) then
            logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferAcceptFailedCounter)
            if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
                logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.accept_failed)
            end
            handleReceiveError(arg1, nil)

            return
        end

        setRobuxTransfer(arg2.robuxTransfer)
        setIsAlreadyAccepted(arg2.isAlreadyAccepted == true)

        logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferAcceptSucceededCounter)

        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.accept_succeeded)
        end

        if SharedFlags.FFlagSduiOpenIncomingTransferUpsellAction then
            arg1.triggerOnPromptDismissCommitted()
        end
        handleReceiveSuccess(arg1)
    end):catch(function(arg2)
        logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferAcceptFailedCounter)
        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.accept_failed)
        end

        if typeof(arg2) ~= "table" or not arg2.errorMessage then
            handleReceiveError(arg1, nil)

            return
        end

        if arg2.failureReason == FailureReason.AmpRecourseAvailable and arg2.ampRecourseActions and arg2.ampFeatureCheck then
            handleReceiveBlock(arg1, arg2.ampRecourseActions, arg2.ampFeatureCheck, TransferRetryOrigin.AcceptTransfer)
            return
        end

        handleReceiveError(arg1, arg2)
    end)
end
return acceptTransfer

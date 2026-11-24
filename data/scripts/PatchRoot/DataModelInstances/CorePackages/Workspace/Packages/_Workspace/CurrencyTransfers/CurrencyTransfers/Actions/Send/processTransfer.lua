-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)

local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local processTransferRequest = require(CurrencyTransfers.NetworkRequests.processTransferRequest)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local _ProcessTransferModel = require(CurrencyTransfers.Models.ProcessTransferModel)
local _ErrorTransferModel = require(CurrencyTransfers.Models.ErrorTransferModel)
local FailureReason = require(CurrencyTransfers.Enums.FailureReason)
local handleTransferSuccess = require(CurrencyTransfers.Actions.Send.handleTransferSuccess)
local handleTransferError = require(CurrencyTransfers.Actions.Send.handleTransferError)
local handleTransferBlock = require(CurrencyTransfers.Actions.Send.handleTransferBlock)
local TransferRetryOrigin = require(CurrencyTransfers.Enums.TransferRetryOrigin)
local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local RobuxTransferFlowEventName = require(CurrencyTransfers.Enums.RobuxTransferFlowEventName)
local logCurrencyTransferCounter = require(CurrencyTransfers.Utils.logCurrencyTransferCounter)
local logRobuxTransferFlowEvent = require(CurrencyTransfers.Utils.logRobuxTransferFlowEvent)

local function processTransfer(arg1, robuxAmount: number)
    local networkImpl = arg1.getNetworkImpl()
    local setPromptState = arg1.setPromptState

    local transferRequestId = arg1.getTransferRequestId(false)

    if not transferRequestId then
        logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferProcessFailedCounter)
        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.process_failed)
        end
        handleTransferError(arg1)
        return
    end

    setPromptState(PromptState.TransferProcessing)
    logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferProcessAttemptedCounter)
    if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
        logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.process_attempted)
    end

    return processTransferRequest({ transferRequestId = transferRequestId, robuxAmount = robuxAmount }, nil, networkImpl):andThen(
        function(arg2)
            if arg2 and arg2.success then
                logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferProcessSucceededCounter)

                if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
                    logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.process_succeeded)
                end
                handleTransferSuccess(arg1)
                return
            end
            logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferProcessFailedCounter)

            if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
                logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.process_failed)
            end
            handleTransferError(arg1)
        end
    ):catch(
        function(arg2)
            logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferProcessFailedCounter)
            if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
                logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.process_failed)
            end

            if typeof(arg2) ~= "table" or not arg2.errorMessage then
                handleTransferError(arg1, nil)

                return
            end

            if arg2.failureReason == FailureReason.AmpRecourseAvailable and arg2.ampRecourseActions and arg2.ampFeatureCheck then
                handleTransferBlock(arg1, arg2.ampRecourseActions, arg2.ampFeatureCheck, TransferRetryOrigin.ProcessTransfer)
                return
            end

            handleTransferError(arg1, arg2)
        end
    )
end

return processTransfer

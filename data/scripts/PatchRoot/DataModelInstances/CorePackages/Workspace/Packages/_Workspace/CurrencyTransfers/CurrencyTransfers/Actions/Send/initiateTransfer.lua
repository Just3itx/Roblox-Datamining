-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)

local GetFFlagCurrencyTransferUseBackendTransferLimits = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferUseBackendTransferLimits)

local FFlagCurrencyTransferNoFreeTransfersRemainingUpsell = require(CurrencyTransfers.Flags.FFlagCurrencyTransferNoFreeTransfersRemainingUpsell)
local FFlagShowRemainingTransfersForNonPlus = require(CurrencyTransfers.Flags.FFlagShowRemainingTransfersForNonPlus)

local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local initiateTransferRequest = require(CurrencyTransfers.NetworkRequests.initiateTransferRequest)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local _InitiateTransferModel = require(CurrencyTransfers.Models.InitiateTransferModel)
local _ErrorTransferModel = require(CurrencyTransfers.Models.ErrorTransferModel)
local FailureReason = require(CurrencyTransfers.Enums.FailureReason)
local handleTransferError = require(CurrencyTransfers.Actions.Send.handleTransferError)
local handleTransferBlock = require(CurrencyTransfers.Actions.Send.handleTransferBlock)
local setTransferPromptState = require(CurrencyTransfers.Actions.Send.setTransferPromptState)
local TransferRetryOrigin = require(CurrencyTransfers.Enums.TransferRetryOrigin)
local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local RobuxTransferFlowEventName = require(CurrencyTransfers.Enums.RobuxTransferFlowEventName)
local logCurrencyTransferCounter = require(CurrencyTransfers.Utils.logCurrencyTransferCounter)
local logRobuxTransferFlowEvent = require(CurrencyTransfers.Utils.logRobuxTransferFlowEvent)

local function initiateTransfer(arg1)
    local networkImpl = arg1.getNetworkImpl()
    local setPromptState = arg1.setPromptState
    local setTransferRequestId = arg1.setTransferRequestId
    local setRobuxBalanceAmount = arg1.setRobuxBalanceAmount
    local setBalanceReceivedFromApi = arg1.setBalanceReceivedFromApi
    local setUserRelationshipDetail = arg1.setUserRelationshipDetail
    local setRecipient = arg1.setRecipient
    local setSender = arg1.setSender
    local setMinimumTransferAmount = arg1.setMinimumTransferAmount
    local setMaximumTransferAmount = arg1.setMaximumTransferAmount
    local setTransferBenefitSource = arg1.setTransferBenefitSource
    local setNumFreeTransfersRemaining = arg1.setNumFreeTransfersRemaining
    local recipientId = arg1.getRecipientUserId(false)
    setPromptState(PromptState.TransferRequested)
    if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
        logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.initiate_attempted)
    end

    local tbl1 = { recipientId = recipientId }

    local transferOrigination = arg1.getTransferOrigination()
    if transferOrigination then
        tbl1.transferOrigination = transferOrigination
    end
    initiateTransferRequest(tbl1, nil, networkImpl):andThen(function(arg2)
        setTransferPromptState(arg1, PromptState.TransferStarted)
        if not arg2 or not arg2.transferRequestId or not arg2.robuxTransfer then
            return
        end

        setTransferRequestId(arg2.transferRequestId)
        setRobuxBalanceAmount(arg2.senderRobuxBalance)
        setBalanceReceivedFromApi(true)
        setUserRelationshipDetail(arg2.userRelationshipDetail)
        setRecipient(arg2.robuxTransfer.recipient)
        setSender(arg2.robuxTransfer.sender)
        if GetFFlagCurrencyTransferUseBackendTransferLimits() then
            if arg2.minimumTransferAmount then
                setMinimumTransferAmount(arg2.minimumTransferAmount)
            end
            if arg2.maximumTransferAmount then
                setMaximumTransferAmount(arg2.maximumTransferAmount)
            end
        end
        if FFlagShowRemainingTransfersForNonPlus then
            setTransferBenefitSource(arg2.transferBenefitSource)
            setNumFreeTransfersRemaining(arg2.numFreeTransfersRemaining)
        end

        setTransferPromptState(arg1, PromptState.TransferInput)
        logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferInitiateSucceededCounter)

        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.initiate_succeeded)
        end
    end):catch(function(arg2)
        logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferInitiateFailedCounter)
        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.initiate_failed)
        end

        if typeof(arg2) ~= "table" or not arg2.errorMessage then
            handleTransferError(arg1, nil)

            return
        end

        local var1 = FFlagCurrencyTransferNoFreeTransfersRemainingUpsell and arg2.failureReason == FailureReason.NoFreeTransfersRemaining

        if (arg2.failureReason == FailureReason.AmpRecourseAvailable or var1) and arg2.ampRecourseActions and arg2.ampFeatureCheck then
            handleTransferBlock(arg1, arg2.ampRecourseActions, arg2.ampFeatureCheck, TransferRetryOrigin.InitiateTransfer, var1)
            return
        end

        handleTransferError(arg1, arg2)
    end)
end
return initiateTransfer

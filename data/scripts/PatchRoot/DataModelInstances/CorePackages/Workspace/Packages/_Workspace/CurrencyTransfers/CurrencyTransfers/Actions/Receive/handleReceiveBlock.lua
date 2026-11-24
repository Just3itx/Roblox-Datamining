-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:20:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)

local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local getTransferRequestByIdRequest = require(CurrencyTransfers.NetworkRequests.getTransferRequestByIdRequest)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local _TransferRetryOrigin = require(CurrencyTransfers.Enums.TransferRetryOrigin)
local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local RobuxTransferFlowEventName = require(CurrencyTransfers.Enums.RobuxTransferFlowEventName)
local logCurrencyTransferCounter = require(CurrencyTransfers.Utils.logCurrencyTransferCounter)
local logRobuxTransferFlowEvent = require(CurrencyTransfers.Utils.logRobuxTransferFlowEvent)

local function handleReceiveBlock(arg1, tbl1, str1: string?, arg2)
    local setPromptState = arg1.setPromptState
    local setAmpRecourseActions = arg1.setAmpRecourseActions
    local setAmpFeatureCheck = arg1.setAmpFeatureCheck
    local setTransferRetryOrigin = arg1.setTransferRetryOrigin
    local setSender = arg1.setSender
    local getSender = arg1.getSender
    local getTransferRequestId = arg1.getTransferRequestId

    local function applyBlockState()
        logCurrencyTransferCounter(arg1, CurrencyTransferTelemetry.CurrencyTransferAmpRecourseRequiredCounter)
        if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
            logRobuxTransferFlowEvent(arg1, RobuxTransferFlowEventName.amp_recourse_required)
        end
        if tbl1 then
            setAmpRecourseActions(tbl1)
        end
        if str1 then
            setAmpFeatureCheck(str1)
        end
        if arg2 then
            setTransferRetryOrigin(arg2)
        end
        setPromptState(PromptState.ReceiveBlocked)
    end

    if getSender(false) then
        applyBlockState()
        return
    end

    local transferRequestId = getTransferRequestId(false)
    if not transferRequestId then
        applyBlockState()
        return
    end

    getTransferRequestByIdRequest({ transferRequestId = transferRequestId }, nil, arg1.getNetworkImpl()):andThen(function(arg3)
        if arg3 and arg3.transfer and arg3.transfer.sender then
            setSender(arg3.transfer.sender)
        end
        applyBlockState()
    end):catch(
        function()
            applyBlockState()
        end
    )
end
return handleReceiveBlock

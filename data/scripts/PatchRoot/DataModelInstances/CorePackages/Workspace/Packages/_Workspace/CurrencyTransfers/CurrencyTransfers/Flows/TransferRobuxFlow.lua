-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local HttpService = game:GetService("HttpService")

local React = require(CurrencyTransfersParent.React)
local SharedFlags = require(CurrencyTransfersParent.SharedFlags)

local TransferRobuxApp = require(CurrencyTransfers.Components.TransferRobuxApp)
local createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local initiateTransfer = require(CurrencyTransfers.Actions.Send.initiateTransfer)
local acceptTransfer = require(CurrencyTransfers.Actions.Receive.acceptTransfer)
local TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)
local TransferOrigination = require(CurrencyTransfers.Enums.TransferOrigination)
local CurrencyTransferTelemetry = require(CurrencyTransfers.Events.CurrencyTransferTelemetry)
local RobuxTransferFlowEventName = require(CurrencyTransfers.Enums.RobuxTransferFlowEventName)
local logCurrencyTransferCounter = require(CurrencyTransfers.Utils.logCurrencyTransferCounter)
local logRobuxTransferFlowEvent = require(CurrencyTransfers.Utils.logRobuxTransferFlowEvent)

local GetFFlagCurrencyTransferUseRoactNetworking = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferUseRoactNetworking)

local function normalizeTransferOrigination(transferOrigination: string) -- Luacid: Inlined by compiler; 1 call site recovered
    local str1 = string.lower(transferOrigination)

    if str1 == "unknown" then
        return TransferOrigination.Unknown
    elseif str1 == "profile" then
        return TransferOrigination.Profile
    elseif str1 == "chat" then
        return TransferOrigination.Chat
    elseif str1 == "buyrobux" then
        return TransferOrigination.BuyRobux
    elseif str1 == "inexperience" then
        return TransferOrigination.InExperience
    end

    return TransferOrigination.Unknown
end

local function validateParams(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    if tbl1.direction ~= TransferDirection.Send and tbl1.direction ~= TransferDirection.Receive then
        error(
            string.format(
                "[TransferRobuxFlow] Invalid direction: '%s'. Must be either TransferDirection.Send or TransferDirection.Receive.",
                tostring(tbl1.direction)
            )
        )
    end
end

local function initializeTransferStore(transferStore, tbl1)
    local networkImpl = if GetFFlagCurrencyTransferUseRoactNetworking() then tbl1.networkImpl else nil
    transferStore.setNetworkImpl(networkImpl)

    if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
        transferStore.setTransferClientSessionId(HttpService:GenerateGUID(false))
    end
    transferStore.setOnClose(tbl1.onClose)
    if SharedFlags.FFlagSduiOpenIncomingTransferUpsellAction then
        transferStore.setOnPromptOptimisticHide(tbl1.onPromptOptimisticHide)
        transferStore.setOnPromptDismissCommitted(tbl1.onPromptDismissCommitted)
    end
    transferStore.setDirection(tbl1.direction)
    if tbl1.transferOrigination then
        transferStore.setTransferOrigination((normalizeTransferOrigination(tbl1.transferOrigination)))
    end

    if tbl1.direction == TransferDirection.Send then
        if tbl1.recipientUserId then
            transferStore.setRecipientUserId(tbl1.recipientUserId)
        end
        initiateTransfer(transferStore)
    elseif tbl1.direction == TransferDirection.Receive then
        if tbl1.transferId then
            transferStore.setTransferRequestId(tbl1.transferId)
        end
        acceptTransfer(transferStore)
    end

    logCurrencyTransferCounter(transferStore, CurrencyTransferTelemetry.CurrencyTransferFlowOpenedCounter)
    if SharedFlags.FFlagEnableRobuxTransferFlowEventIngest then
        logRobuxTransferFlowEvent(transferStore, RobuxTransferFlowEventName.in_app_flow_open)
    end
end

local function renderTransferRobuxFlowImmediate(tbl1)
    local transferStore = createTransferStore()
    initializeTransferStore(transferStore, tbl1)
    return React.createElement(TransferRobuxApp, { transferStore = transferStore })
end

local function TransferRobuxFlowContainer(tbl1)
    local var1 = React.useRef(nil)
    local var2 = React.useRef(false)

    if var1.current == nil then
        var1.current = createTransferStore()
    end
    local current = var1.current

    if not var2.current then
        var2.current = true
        initializeTransferStore(current, tbl1)
    end

    return React.createElement(TransferRobuxApp, { transferStore = current })
end

local function TransferRobuxFlow(tbl1)
    validateParams(tbl1)

    if SharedFlags.FFlagSduiOpenIncomingTransferUpsellAction then
        return React.createElement(TransferRobuxFlowContainer, tbl1)
    end
    return renderTransferRobuxFlowImmediate(tbl1)
end

return TransferRobuxFlow

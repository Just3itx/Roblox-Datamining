-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local SignalsReact = require(CurrencyTransfersParent.SignalsReact)

local PromptState = require(CurrencyTransfers.Enums.PromptState)
local TransferRobuxInputSheet = require(CurrencyTransfers.Components.Send.TransferRobuxInputSheet)
local TransferRobuxConfirmSheet = require(CurrencyTransfers.Components.Send.TransferRobuxConfirmSheet)
local TransferRobuxErrorSheet = require(CurrencyTransfers.Components.Send.TransferRobuxErrorSheet)
local InsufficientBalanceSheet = require(CurrencyTransfers.Components.Send.InsufficientBalanceSheet)
local TransferRobuxSuccessToast = require(CurrencyTransfers.Components.Send.TransferRobuxSuccessToast)
local TransferRobuxSuccessModal = require(CurrencyTransfers.Components.Send.TransferRobuxSuccessModal)
local TransferBlockSheet = require(CurrencyTransfers.Components.Send.TransferBlockSheet)
local ReceiveRobuxSuccessToast = require(CurrencyTransfers.Components.Receive.ReceiveRobuxSuccessToast)
local ReceiveBlockSheet = require(CurrencyTransfers.Components.Receive.ReceiveBlockSheet)
local ReceiveErrorSheet = require(CurrencyTransfers.Components.Receive.ReceiveErrorSheet)

local GetFFlagCurrencyTransferSuccessModal = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferSuccessModal)

local useTransferStore = require(CurrencyTransfers.Hooks.useTransferStore)

local function TransferRobuxContainer(_)
    local var1 = useTransferStore()
    local var2 = SignalsReact.useSignalState(var1.getPromptState)

    if var2 == PromptState.TransferInput then
        return React.createElement(TransferRobuxInputSheet, {})
    elseif var2 == PromptState.TransferInsufficientBalance then
        return React.createElement(InsufficientBalanceSheet, {})
    elseif var2 == PromptState.TransferConfirm then
        return React.createElement(TransferRobuxConfirmSheet, {})
    elseif var2 == PromptState.TransferSuccess then
        if GetFFlagCurrencyTransferSuccessModal() then
            return React.createElement(TransferRobuxSuccessModal, {})
        end
        return React.createElement(TransferRobuxSuccessToast, {})
    elseif var2 == PromptState.TransferError then
        return React.createElement(TransferRobuxErrorSheet, {})
    elseif var2 == PromptState.TransferBlocked then
        return React.createElement(TransferBlockSheet)
    elseif var2 == PromptState.ReceiveSuccess then
        return React.createElement(ReceiveRobuxSuccessToast, {})
    elseif var2 == PromptState.ReceiveBlocked then
        return React.createElement(ReceiveBlockSheet)
    elseif var2 == PromptState.ReceiveError then
        return React.createElement(ReceiveErrorSheet, {})
    else
        return nil
    end
end
return TransferRobuxContainer

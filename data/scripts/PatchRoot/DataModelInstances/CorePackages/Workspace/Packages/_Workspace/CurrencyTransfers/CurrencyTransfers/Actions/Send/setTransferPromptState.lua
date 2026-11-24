-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local _InitiateTransferModel = require(CurrencyTransfers.Models.InitiateTransferModel)

local tbl1 = {
    [PromptState.TransferRequested] = { PromptState.TransferStarted },
    [PromptState.TransferStarted] = { PromptState.TransferInput },
    [PromptState.TransferInput] = { PromptState.TransferConfirm, PromptState.TransferInsufficientBalance },
    [PromptState.TransferInsufficientBalance] = { PromptState.TransferInput, PromptState.TransferConfirm },
    [PromptState.TransferConfirm] = {
        PromptState.TransferInput,
        PromptState.TransferProcessing,
        PromptState.TransferConfirm,
        PromptState.TransferInsufficientBalance
    },
    [PromptState.TransferProcessing] = { PromptState.TransferSuccess }
}

local function isValidPromptStateTransition(promptState, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = tbl1[promptState]
    for _, value in ipairs(var1) do
        if value == arg1 then
            return true
        end
    end
    return false
end

local function setTransferPromptState(arg1, arg2)
    local setPromptState = arg1.setPromptState

    if not isValidPromptStateTransition(arg1.getPromptState(false), arg2) then
        setPromptState(PromptState.TransferError)
        return
    end

    setPromptState(arg2)
end

return setTransferPromptState

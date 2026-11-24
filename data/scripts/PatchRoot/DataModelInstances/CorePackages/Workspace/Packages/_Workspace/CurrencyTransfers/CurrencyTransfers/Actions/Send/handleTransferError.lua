-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local _ErrorTransferModel = require(CurrencyTransfers.Models.ErrorTransferModel)

local function handleTransferError(arg1, arg2)
    local setPromptState = arg1.setPromptState
    local setErrorTransferModel = arg1.setErrorTransferModel

    if arg2 then
        setErrorTransferModel(arg2)
    else
        setErrorTransferModel(nil)
    end

    setPromptState(PromptState.TransferError)
end

return handleTransferError

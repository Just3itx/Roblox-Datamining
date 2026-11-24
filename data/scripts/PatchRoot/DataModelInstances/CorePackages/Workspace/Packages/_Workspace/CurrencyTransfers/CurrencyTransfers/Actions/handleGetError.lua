-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:20:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local TransferDirection = require(CurrencyTransfers.Enums.TransferDirection)
local _ErrorTransferModel = require(CurrencyTransfers.Models.ErrorTransferModel)

local function handleGetError(arg1, arg2)
    local setPromptState = arg1.setPromptState
    local setErrorTransferModel = arg1.setErrorTransferModel
    local getDirection = arg1.getDirection

    if arg2 then
        setErrorTransferModel(arg2)
    else
        setErrorTransferModel(nil)
    end

    if getDirection(false) == TransferDirection.Receive then
        setPromptState(PromptState.ReceiveError)
        return
    end
    setPromptState(PromptState.TransferError)
end

return handleGetError

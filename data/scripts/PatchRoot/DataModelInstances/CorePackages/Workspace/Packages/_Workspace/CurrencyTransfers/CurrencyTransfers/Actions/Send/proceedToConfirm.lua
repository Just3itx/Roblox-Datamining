-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local PromptState = require(CurrencyTransfers.Enums.PromptState)
local _InitiateTransferModel = require(CurrencyTransfers.Models.InitiateTransferModel)
local setTransferPromptState = require(CurrencyTransfers.Actions.Send.setTransferPromptState)

local function proceedToConfirm(arg1, num1: number)
    arg1.setSelectedAmount(num1)
    setTransferPromptState(arg1, PromptState.TransferConfirm)
end

return proceedToConfirm

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:20:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local PromptState = require(CurrencyTransfers.Enums.PromptState)

local function handleReceiveSuccess(arg1)
    arg1.setPromptState(PromptState.ReceiveSuccess)
end

return handleReceiveSuccess

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)
local TransferContext = require(CurrencyTransfers.Contexts.TransferContext)
local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)

local function useTransferStore()
    local var1 = React.useContext(TransferContext)
    if var1 == nil then
        error("useTransferStore must be used within a TransferContext")
    end
    return var1
end

return useTransferStore

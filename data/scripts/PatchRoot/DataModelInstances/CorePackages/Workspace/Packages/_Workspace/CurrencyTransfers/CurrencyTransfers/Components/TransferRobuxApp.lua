-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:30:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)

local TransferRobuxContainer = require(CurrencyTransfers.Components.TransferRobuxContainer)
local TransferContext = require(CurrencyTransfers.Contexts.TransferContext)
local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)

local function TransferRobuxApp(tbl1)
    return React.createElement(
        TransferContext.Provider,
        {
            value = tbl1.transferStore
        },
        {
            TransferRobuxSheet = React.createElement(TransferRobuxContainer, {})
        }
    )
end
return TransferRobuxApp

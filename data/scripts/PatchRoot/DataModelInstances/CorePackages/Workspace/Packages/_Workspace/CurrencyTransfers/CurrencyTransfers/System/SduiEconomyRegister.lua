-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:41:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)

local registerCurrencyTransferSduiActions = require(CurrencyTransfers.Actions.registerCurrencyTransferSduiActions)

return React.memo(function() -- name: SduiEconomyRegister
    React.useEffect(function()
        registerCurrencyTransferSduiActions()
    end, {})
    return nil
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:50:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local LoggingProtocol = require(CurrencyTransfersParent.LoggingProtocol)
local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)

local function logCurrencyTransferCounter(arg1, arg2, tbl1)
    local direction = arg1.getDirection(false)
    local transferOrigination = arg1.getTransferOrigination(false)

    local tbl2 = {
        direction = if direction then tostring(direction) else "unknown",
        transferOrigination = if transferOrigination then tostring(transferOrigination) else "unknown"
    }
    if tbl1 then
        for value, value2 in tbl1 do
            tbl2[value] = value2
        end
    end

    LoggingProtocol.default:logRobloxTelemetryCounter(arg2, 1, tbl2)
end

return logCurrencyTransferCounter

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:50:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")

local _createTransferStore = require(CurrencyTransfers.Stores.createTransferStore)
local buildRobuxTransferFlowPayload = require(CurrencyTransfers.Utils.buildRobuxTransferFlowPayload)
local sendRobuxTransferFlowEvent = require(CurrencyTransfers.Utils.sendRobuxTransferFlowEvent)

local function logRobuxTransferFlowEvent(arg1, str1: string, tbl1)
    local robuxTransferFlowPayload = buildRobuxTransferFlowPayload(arg1, str1)
    if tbl1 then
        for k, value in pairs(tbl1) do
            robuxTransferFlowPayload[k] = value
        end
    end

    sendRobuxTransferFlowEvent(robuxTransferFlowPayload)
end

return logRobuxTransferFlowEvent

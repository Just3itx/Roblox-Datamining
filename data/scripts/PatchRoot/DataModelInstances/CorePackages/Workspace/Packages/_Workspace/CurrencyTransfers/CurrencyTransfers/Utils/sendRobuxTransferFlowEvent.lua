-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:50:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent
local default = require(CurrencyTransfersParent.LoggingProtocol).default

local RobuxTransferFlowTelemetry = require(CurrencyTransfers.Events.RobuxTransferFlowTelemetry)

function sendRobuxTransferFlowEvent(tbl1)
    default:logRobloxTelemetryEvent(
        RobuxTransferFlowTelemetry.RobuxTransferFlowEvent,
        { default.StandardizedFields.addOsInfo, default.StandardizedFields.addSessionId, "addSessionInfo" },
        tbl1,
        "RobuxTransferFlow"
    )
end
return sendRobuxTransferFlowEvent

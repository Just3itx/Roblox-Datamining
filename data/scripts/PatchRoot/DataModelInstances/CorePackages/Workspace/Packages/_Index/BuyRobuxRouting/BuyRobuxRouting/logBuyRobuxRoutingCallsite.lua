-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuyRobuxRoutingParent = script:FindFirstAncestor("BuyRobuxRouting").Parent
local LoggingProtocol = require(BuyRobuxRoutingParent.LoggingProtocol)

local tbl1 = {
    eventName = "BuyRobuxNewRoutingCallsite",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 2026, 10, 21 },
    throttlingPercentage = 10000,
    description = "Fires when a new Buy Robux routing callsite runs."
}

local function logBuyRobuxRoutingCallsite(callsite: string)
    LoggingProtocol.default:logRobloxTelemetryCounter(tbl1, 1, { callsite = callsite })
end

return logBuyRobuxRoutingCallsite

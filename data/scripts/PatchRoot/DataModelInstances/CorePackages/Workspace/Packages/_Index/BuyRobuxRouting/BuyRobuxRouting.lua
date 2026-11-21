-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T06:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Destination = require(script.Destination)
local logBuyRobuxRoutingCallsite = require(script.logBuyRobuxRoutingCallsite)

return {
    fallbackWebUrl = Destination.fallbackWebUrl,
    resolveDestination = Destination.resolveDestination,
    logExposure = Destination.logExposure,
    resolveAndLogDestination = Destination.resolveAndLogDestination,
    logBuyRobuxRoutingCallsite = logBuyRobuxRoutingCallsite,
    ["jest.config"] = script["jest.config"]
}

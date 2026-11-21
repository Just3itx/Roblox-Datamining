-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryUtilsParent = script:FindFirstAncestor("DiscoveryUtils").Parent
local default = require(DiscoveryUtilsParent.LoggingProtocol).default

local throttlingPercentage = game:DefineFastInt("DiscoveryResponseSizeEventHundredthsPercent", 0)

local tbl1 = {
    eventName = "DiscoveryResponseSize",
    backends = { default.TelemetryBackends.Stats },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 24, 8, 2 },
    description = "Response body size for discovery network requests",
    links = ""
}

local function logResponseTelemetry(endpointName: string, tbl2, arg1)
    if arg1 == nil then
        arg1 = default
    end
    assert(arg1, "LoggingProtocol must exist")

    arg1:logRobloxTelemetryStat(tbl1, tbl2.responseSize, { endpoint_name = endpointName })
end

return logResponseTelemetry

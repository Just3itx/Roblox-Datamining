-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryUtilsParent = script:FindFirstAncestor("DiscoveryUtils").Parent
local LoggingProtocol = require(DiscoveryUtilsParent.LoggingProtocol)
local default = LoggingProtocol.default

local throttlingPercentage = game:DefineFastInt("DiscoveryResponseErrorEventHundredthsPercent", 0)

local tbl1 = {
    eventName = "DiscoveryResponse_Error",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 24, 12, 2 },
    description = "Response errors for discovery network requests"
}

local function getStatusCode(tbl2) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = if typeof(tbl2) == "table" then tostring(tbl2.StatusCode) else nil
    return var1 or "unknown"
end

local function logResponseError(endpointName: string, tbl2, arg1)
    if arg1 == nil then
        arg1 = default
    end
    assert(arg1, "LoggingProtocol must exist")

    arg1:logRobloxTelemetryCounter(tbl1, 1, { endpoint_name = endpointName, status_code = getStatusCode(tbl2) })
end

return logResponseError

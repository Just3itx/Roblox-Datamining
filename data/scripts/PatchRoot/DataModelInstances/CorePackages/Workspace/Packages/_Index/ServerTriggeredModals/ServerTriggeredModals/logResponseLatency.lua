-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local LoggingProtocol = require(ServerTriggeredModalsParent.LoggingProtocol)
local default = LoggingProtocol.default

local tbl1 = {
    eventName = "ServerTriggeredModals_NetworkLatency",
    backends = { LoggingProtocol.TelemetryBackends.Stats },
    lastUpdated = { 25, 8, 29 },
    description = "Response latency from server triggered modals request"
}

return function(endpointName: string, num1: number, statusCode: number?, arg1)
    if arg1 == nil then
        arg1 = default
    end
    assert(arg1, "loggingProtocol must exists")

    arg1:logRobloxTelemetryStat(tbl1, num1, { endpoint_name = endpointName, status_code = statusCode })
end

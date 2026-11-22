-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local LoggingProtocol = require(ServerTriggeredModalsParent.LoggingProtocol)
local default = LoggingProtocol.default

local tbl1 = {
    eventName = "ServerTriggeredModals_HttpStatusCode",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 25, 8, 29 },
    description = "Response status code from server triggered modals request"
}

return function(endpointName: string, statusCode: number?, arg1)
    if arg1 == nil then
        arg1 = default
    end
    assert(arg1, "loggingProtocol must exists")

    arg1:logRobloxTelemetryCounter(tbl1, 1, { endpoint_name = endpointName, status_code = statusCode or "unknown" })
end

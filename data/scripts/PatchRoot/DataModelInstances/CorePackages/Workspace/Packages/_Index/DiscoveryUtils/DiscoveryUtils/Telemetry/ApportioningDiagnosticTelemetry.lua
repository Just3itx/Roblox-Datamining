-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryUtilsParent = script:FindFirstAncestor("DiscoveryUtils").Parent

local Cryo = require(DiscoveryUtilsParent.Cryo)

local config = {
    eventName = "NxmApportioningDiagnostic",
    description = "Diagnostic events for the NxM apportioning dry-run",
    lastUpdated = { 26, 7, 7 },
    backends = { "EventIngest", "Points" },
    throttlingPercentage = game:DefineFastInt("LuaAppNxMApportioningDiagnosticThrottleHundredthsPercent", 0)
}

local standardizedFields = { "addOSInfo", "addSessionInfo", "addSessionId" }

local module = {}

function module.log(eventKind: string, tbl2)
    local customFields = Cryo.Dictionary.join(tbl2 or {}, { eventKind = eventKind })
    TelemetryService:LogEvent(config, { standardizedFields = standardizedFields, customFields = customFields })
end

return module

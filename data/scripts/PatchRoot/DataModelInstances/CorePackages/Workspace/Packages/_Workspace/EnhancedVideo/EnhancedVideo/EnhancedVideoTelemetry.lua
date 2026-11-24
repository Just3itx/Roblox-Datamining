-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:11:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local standardizedFields = {
    "addPlaceId",
    "addUniverseId",
    "addSessionId",
    "addOSInfo",
    "addSessionInfo"
}
local config = {
    eventName = "ServeEnhancedVideoError",
    backends = { "Points" },
    throttlingPercentage = game:DefineFastInt("ServeEnhancedVideoErrorTelemetryThrottleHundredthsPercent", 0),
    lastUpdated = { 26, 3, 20 },
    description = "        This is fired when there is an error calling /serve-enhanced-video.\n    "
}

local module = {}

function module.logServeEnhancedVideoError(error: string)
    TelemetryService:LogEvent(config, { standardizedFields = standardizedFields, customFields = { error = error } })
end

return module

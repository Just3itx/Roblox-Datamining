-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local standardizedFields = { "addOSInfo", "addSessionInfo", "addSessionId" }

local config = {
    eventName = "TwoByOneTileActivated",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 1, 16 },
    description = "Counter for TwoByOneTileActivated events."
}

local config2 = {
    eventName = "TwoByOneTileCtaActivated",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 2, 23 },
    description = "Counter for TwoByOneTileCtaActivated events."
}

local config3 = {
    eventName = "TwoByOneTileGameJoinInitiated",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 1, 16 },
    description = "Counter for TwoByOneTileGameJoinInitiated events."
}

local config4 = {
    eventName = "TwoByOneTileViewGameDetailsActivated",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = { 26, 2, 19 },
    description = "Counter for TwoByOneTileViewGameDetailsActivated events."
}

local module = {}

function module.logTwoByOneTileActivated()
    TelemetryService:LogCounter(config, { standardizedFields = standardizedFields, customFields = {} }, 1)
end

function module.logTwoByOneTileCtaActivated()
    TelemetryService:LogCounter(config2, { standardizedFields = standardizedFields, customFields = {} }, 1)
end

function module.logTwoByOneTileGameJoinInitiated()
    TelemetryService:LogCounter(config3, { standardizedFields = standardizedFields, customFields = {} }, 1)
end

function module.logTwoByOneTileViewGameDetailsActivated()
    TelemetryService:LogCounter(config4, { standardizedFields = standardizedFields, customFields = {} }, 1)
end

return module

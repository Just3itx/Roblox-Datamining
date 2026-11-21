-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T11:11:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryUtilsParent = script:FindFirstAncestor("DiscoveryUtils").Parent

local Cryo = require(DiscoveryUtilsParent.Cryo)

local bool1 = game:DefineFastFlag("UpdateDiscoveryEventErrorDetailsLogging", false)

local config = {
    eventName = "DiscoveryEventErrorLogger_ErrorDetails",
    description = "Error messages related to discovery events",
    lastUpdated = { 25, 10, 14 },
    backends = { "Points", if bool1 then "EventIngest" else nil },
    links = "https://roblox.atlassian.net/browse/CLIGROW-2890",
    throttlingPercentage = game:DefineFastInt("DiscoveryEventErrorDetailsHundredthsPercent", 0)
}

local config2 = {
    eventName = "DiscoveryEventErrorLogger_ErrorCounter",
    description = "Counter related to discovery event errors",
    lastUpdated = { 25, 10, 14 },
    backends = { "RobloxTelemetryCounter" },
    links = "https://roblox.atlassian.net/browse/CLIGROW-2890"
}

local module = {}

function module.reportError(errorType: string, errorMessage: string, tbl1)
    if not _G.__TESTEZ_RUNNING_TEST__ then
        warn(`[DiscoveryEventErrorLogger]\nError Type: {errorType}\nError Message: {errorMessage}`)
    end

    TelemetryService:LogCounter(config2, { customFields = { errorType = errorType } }, 1)

    TelemetryService:LogEvent(config, {
        standardizedFields = bool1 and { "addSessionInfo" } or nil,
        customFields = Cryo.Dictionary.join(tbl1 or {}, { errorType = errorType, errorMessage = errorMessage })
    })
end

return module

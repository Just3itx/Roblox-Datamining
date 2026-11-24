-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:21:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local TelemetryService = game:GetService("TelemetryService")

local InExperienceSideSheetParent = script:FindFirstAncestor("InExperienceSideSheet").Parent

local LoggingProtocol = require(InExperienceSideSheetParent.LoggingProtocol)

local engineFeature = game:GetEngineFeature("TelemetryServicePlaySessionInfoEnabled")

local tbl1 = {
    eventName = "sidesheet_closed",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = game:DefineFastInt("SidesheetClosedEventThrottleHundredthsPercent", 10000),
    lastUpdated = { 2026, 4, 8 },
    description = "Fires when the sidesheet is closed"
}

function _logEventWithStandardizedFields(config, tbl2)
    local standardizedFields = {
        "addPlaceId",
        "addUniverseId",
        "addSessionInfo",
        "addOSInfo",
        "addMemoryInfo"
    }
    local customFields = tbl2 or {}

    if engineFeature then
        table.insert(standardizedFields, "addPlaySessionId")
    else
        customFields.playsessionid = RbxAnalyticsService:GetPlaySessionId()
    end

    TelemetryService:LogEvent(config, { standardizedFields = standardizedFields, customFields = customFields })
end

function logSidesheetClosed(source: string)
    _logEventWithStandardizedFields(tbl1, { source = source })
end

return {
    logSidesheetClosed = logSidesheetClosed
}

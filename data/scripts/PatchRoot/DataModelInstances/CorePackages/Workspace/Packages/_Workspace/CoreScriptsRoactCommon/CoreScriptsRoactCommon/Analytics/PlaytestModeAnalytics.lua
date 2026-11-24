-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local TelemetryService = game:GetService("TelemetryService")

local CoreScriptsRoactCommonParent = script:FindFirstAncestor("CoreScriptsRoactCommon").Parent

local LoggingProtocol = require(CoreScriptsRoactCommonParent.LoggingProtocol)

local engineFeature = game:GetEngineFeature("TelemetryServicePlaySessionInfoEnabled")

local config = {
    eventName = "playtest_mode_enabled",
    backends = { LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = game:DefineFastInt("PlaytestModeEnabledEventThrottleHundredthsPercent", 10000),
    lastUpdated = { 2026, 7, 23 },
    description = "Fires once when playtest mode becomes enabled for the local player"
}

local function _logEventWithStandardizedFields(config2: {backends: {any}, description: string, eventName: string, lastUpdated: {number}, throttlingPercentage: number}, tbl1)
    local standardizedFields = { "addPlaceId", "addUniverseId", "addSessionInfo" }
    local customFields = tbl1 or {}

    if engineFeature then
        table.insert(standardizedFields, "addPlaySessionId")
    else
        customFields.playsessionid = RbxAnalyticsService:GetPlaySessionId()
    end

    TelemetryService:LogEvent(config2, { standardizedFields = standardizedFields, customFields = customFields })
end

return {
    logPlaytestModeEnabled = function(reason: string)
        _logEventWithStandardizedFields(config, { reason = reason })
    end
}

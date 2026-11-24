-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T01:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local TelemetryService = game:GetService("TelemetryService")

local throttlingPercentage = game:DefineFastInt("TopBarToggledThrottleHundredthsPercent", 0)

local engineFeature = game:GetEngineFeature("TelemetryServicePlaySessionInfoEnabled")

local config = {
    eventName = "topbar_toggled",
    backends = { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 25, 6, 10 },
    description = "Event fired every time TopBar is toggled open/close in UI-less mode",
    links = "https://github.rbx.com/Roblox/proto-schemas/pull/6270"
}

return function(bool1: boolean)
    local tbl1, tbl2

    if engineFeature then
        tbl1 = {
            is_toggled_on = tostring(bool1)
        }
        tbl2 = {
            "addPlaceId",
            "addUniverseId",
            "addPlaySessionId",
            "addSessionInfo"
        }
    else
        tbl1 = {
            is_toggled_on = tostring(bool1),
            playsessionid = RbxAnalyticsService:GetPlaySessionId()
        }
        tbl2 = { "addPlaceId", "addUniverseId", "addSessionInfo" }
    end

    TelemetryService:LogEvent(config, { standardizedFields = tbl2, customFields = tbl1 })
end

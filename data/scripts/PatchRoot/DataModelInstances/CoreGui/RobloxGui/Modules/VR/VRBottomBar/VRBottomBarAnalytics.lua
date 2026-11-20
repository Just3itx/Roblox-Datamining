-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local TelemetryService = game:GetService("TelemetryService")

local engineFeature = game:GetEngineFeature("TelemetryServicePlaySessionInfoEnabled")

return {
    sendEventToTelemetryV2 = function(tbl1)
        local config = {
            eventName = "coreui_vr_bottom_bar_action",
            backends = { "EventIngest" },
            throttlingPercentage = game:DefineFastInt("VRBottomBarActionEventThrottleHunderedthsPercent", 0),
            lastUpdated = { 2025, 5, 12 },
            description = "Event fired from the client every time VRBottomBar buttons are clicked",
            links = "https://github.rbx.com/Roblox/proto-schemas/pull/5803"
        }

        local standardizedFields = { "addPlaceId", "addUniverseId", "addSessionInfo" }
        local customFields = {
            integration_id = tbl1.integrationId,
            is_toggle_on = tostring(tbl1.isToggleOn),
            source = tbl1.source
        }

        if engineFeature then
            table.insert(standardizedFields, "addPlaySessionId")
        else
            customFields.playsessionid = RbxAnalyticsService:GetPlaySessionId()
        end
        TelemetryService:LogEvent(config, { standardizedFields = standardizedFields, customFields = customFields })
    end
}

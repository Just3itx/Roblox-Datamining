-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

local scriptParentParent = script.Parent.Parent

local FFlagLoggingGamepadOpenExpControlsMenu = require(scriptParentParent.Flags.FFlagLoggingGamepadOpenExpControlsMenu)
local throttlingPercentage = game:DefineFastInt("GamepadOpenExperienceControlsMenuThrottleHundrethsPercent", 0)
local engineFeature = game:GetEngineFeature("TelemetryServicePlaySessionInfoEnabled")

local config = {
    eventName = "coreui_gamepad_toggle_exp_controls",
    backends = { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 25, 4, 25 },
    description = "Event fired from the client every time Experience Controls Menu is toggled open/closed",
    links = "https://github.rbx.com/Roblox/proto-schemas/pull/5750"
}

return function(bool1: boolean)
    if not FFlagLoggingGamepadOpenExpControlsMenu then
        return
    end

    local tbl1, tbl2

    if engineFeature then
        tbl1 = {
            is_toggle_open = tostring(bool1)
        }
        tbl2 = {
            "addPlaceId",
            "addUniverseId",
            "addPlaySessionId",
            "addSessionInfo"
        }
    else
        tbl1 = {
            is_toggle_open = tostring(bool1),
            playsessionid = RbxAnalyticsService:GetPlaySessionId()
        }
        tbl2 = { "addPlaceId", "addUniverseId", "addSessionInfo" }
    end

    TelemetryService:LogEvent(config, { standardizedFields = tbl2, customFields = tbl1 })
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local throttlingPercentage = game:DefineFastInt("SwitchServerTelemetryThrottleHundrethsPercent", 10000)

local tbl1 = {
    SwitchServerButtonActions = {
        eventName = "coreui_switch_server_button_actions",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 7, 15, 26 },
        description = "Event fired every time the User engages with the People tab switch server button",
        links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/4906123766/Switch+Server+Tech+Spec"
    },
    SwitchServerConfirmationActions = {
        eventName = "coreui_switch_server_confirmation_actions",
        backends = { "EventIngest" },
        throttlingPercentage = throttlingPercentage,
        lastUpdated = { 7, 15, 26 },
        description = "Event fired every time the User engages with the switch server confirmation screen",
        links = "https://roblox.atlassian.net/wiki/spaces/APEX/pages/4906123766/Switch+Server+Tech+Spec"
    }
}

local module = ({})
module.__index = module

function module.sendSwitchServerButtonActions(customFields)
    TelemetryService:LogEvent(tbl1.SwitchServerButtonActions, {
        standardizedFields = {
            "addPlaceId",
            "addUniverseId",
            "addPlaySessionId",
            "addSessionInfo"
        },
        customFields = customFields
    })
end

function module.sendSwitchServerConfirmationActions(customFields)
    TelemetryService:LogEvent(tbl1.SwitchServerConfirmationActions, {
        standardizedFields = {
            "addPlaceId",
            "addUniverseId",
            "addPlaySessionId",
            "addSessionInfo"
        },
        customFields = customFields
    })
end

return module

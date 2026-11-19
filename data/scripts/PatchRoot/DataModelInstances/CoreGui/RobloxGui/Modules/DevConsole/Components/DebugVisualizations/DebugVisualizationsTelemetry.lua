-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:21:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local RunService = game:GetService("RunService")
local TelemetryService = game:GetService("TelemetryService")

local config = {
    eventName = "SlimTintModeSelected",
    backends = { "Points", "EventIngest" },
    throttlingPercentage = 10000,
    lastUpdated = { 2026, 10, 13 },
    description = "\t\tSLIM tint mode selected by a user. Shared by the Developer Console Debug Visualizations tab\n\t\t(ui = \"DevConsole\") and the Studio Visualization Modes plugin (ui = \"VisualizationModes\").\n\t\tThe app field is \"Studio\" or \"Player\", since the Developer Console runs in both.\n\t"
}

local module = {}

function module.logSlimTintModeSelected(arg1)
    if arg1.Name == "None" then
        return
    end

    local customFields = {
        tintMode = arg1.Name,
        ui = "DevConsole",
        app = if RunService:IsStudio() then "Studio" else "Player",
        clientId = RbxAnalyticsService:GetClientId()
    }
    TelemetryService:LogEvent(config, { customFields = customFields })
end

return module

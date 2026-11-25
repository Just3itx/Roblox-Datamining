-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local UiShellEventsParent = script:FindFirstAncestor("UiShellEvents").Parent
local TelemetryBackends = require(UiShellEventsParent.LoggingProtocol).TelemetryBackends
local _FocusNavigationUtils = require(UiShellEventsParent.FocusNavigationUtils)

local config = {
    eventName = "KeyboardFocusModeEnteredCounter",
    backends = { "RobloxTelemetryCounter" },
    lastUpdated = "2026-06-22",
    description = "Counts # of sessions that use keyboard mode."
}

local config2 = {
    eventName = "KeyboardFocusModeEnteredEvent",
    backends = { "EventIngest" },
    throttlingPercentage = 10000,
    lastUpdated = "2026-06-22",
    description = "Tracks % of DAUs that use keyboard mode."
}

local tbl1 = {
    eventName = "FocusNavToggledEvent",
    backends = { TelemetryBackends.EventIngest },
    throttlingPercentage = game:DefineFastInt("FocusNavToggledEventThrottleHundredthsPercent", 10000),
    lastUpdated = { 26, 10, 4 },
    links = "proto-schemas: production/eventstream/console/focus_nav_toggled.proto",
    description = "Fired when the user enters or exits focus navigation. Sent to ingest_proto.focus_nav_toggled."
}

local tbl2 = {
    eventName = "ShortcutBarToggle",
    backends = { TelemetryBackends.EventIngest },
    throttlingPercentage = game:DefineFastInt("ShortcutBarToggleThrottleHundredthsPercent", 10000),
    lastUpdated = { 26, 10, 4 },
    links = "proto-schemas: production/eventstream/console/shortcut_bar_toggle.proto",
    description = "Fired when focus navigation dispatches a shortcut the user pressed to a handler. Sent to ingest_proto.shortcut_bar_toggle."
}

local tbl3 = {
    eventName = "FocusNavToggledCounter",
    backends = { TelemetryBackends.Counter },
    lastUpdated = { 26, 10, 4 },
    description = "Counts focus navigation entries and exits by entry and input type."
}

local tbl4 = {
    eventName = "FocusNavShortcutToggleCounter",
    backends = { TelemetryBackends.Counter },
    lastUpdated = { 26, 10, 4 },
    description = "Counts shortcuts used in focus navigation by action and input type."
}

local tbl5 = {
    eventName = "FocusNavToggledPoints",
    backends = { TelemetryBackends.Points },
    throttlingPercentage = game:DefineFastInt("FocusNavToggledPointsThrottleHundredthsPercent", 10000),
    lastUpdated = { 26, 10, 4 },
    description = "Focus navigation entries and exits with page and keyboard details, for Grafana breakdowns."
}

local tbl6 = {
    eventName = "FocusNavShortcutTogglePoints",
    backends = { TelemetryBackends.Points },
    throttlingPercentage = game:DefineFastInt("FocusNavShortcutTogglePointsThrottleHundredthsPercent", 10000),
    lastUpdated = { 26, 10, 4 },
    description = "Shortcuts used in focus navigation with button and page, for Grafana breakdowns."
}

local function logToAllBackends(config3, config4, config5, customFields, customFields2)
    TelemetryService:LogEvent(config3, { customFields = customFields })
    TelemetryService:LogEvent(config4, { customFields = customFields })
    TelemetryService:LogCounter(config5, { customFields = customFields2 }, 1)
end

local standardizedFields = { "addSessionId", "addOSInfo", "addSessionInfo" }

return {
    logKeyboardFocusModeEntered = function()
        TelemetryService:LogEvent(config2, { customFields = {}, standardizedFields = standardizedFields })

        TelemetryService:LogCounter(config, { customFields = {}, standardizedFields = standardizedFields })
    end,
    logFocusNavToggled = function(customFields)
        logToAllBackends(tbl1, tbl5, tbl3, customFields, { entry = customFields.entry, input_type = customFields.input_type })
    end,
    logFocusNavShortcutToggle = function(customFields)
        logToAllBackends(tbl2, tbl6, tbl4, customFields, { action = customFields.action, input_type = customFields.input_type })
    end
}

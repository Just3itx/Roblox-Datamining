-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T09:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
local PinShortcutParent = script:FindFirstAncestor("PinShortcut").Parent

local LoggingProtocol = require(PinShortcutParent.LoggingProtocol)

local throttlingPercentage = game:DefineFastInt("PinShortcutSnackbarTelemetryThrottleHundredthsPercent", 0)

return {
    SnackbarButtonPressed = {
        eventName = "PinShortcut_SnackbarButtonPressed",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 9, 17 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when a snackbar action button is pressed. The \"action\" field distinguishes TryAgain and ViewShortcut.",
        links = ""
    },
    SnackbarShown = {
        eventName = "PinShortcut_SnackbarShown",
        backends = { LoggingProtocol.TelemetryBackends.Counter },
        lastUpdated = { 2026, 9, 17 },
        throttlingPercentage = throttlingPercentage,
        description = "Counter fired when the pin-experience result snackbar is displayed. The \"action\" field distinguishes Success, Failure, and AlreadyExists.",
        links = ""
    }
}

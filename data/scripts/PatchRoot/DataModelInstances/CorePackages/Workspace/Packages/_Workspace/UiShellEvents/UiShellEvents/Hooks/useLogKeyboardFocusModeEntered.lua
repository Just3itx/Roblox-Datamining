-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:51:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UiShellEventsParent = script:FindFirstAncestor("UiShellEvents").Parent
local React = require(UiShellEventsParent.React)
local FocusNavigationUtils = require(UiShellEventsParent.FocusNavigationUtils)
local TelemetryService = game:GetService("TelemetryService")

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

local function useLogKeyboardFocusModeEntered()
    local var1 = FocusNavigationUtils.useLastInputMode()
    local var2 = FocusNavigationUtils.useLastInputMethod()
    local var3 = React.useRef(false)

    React.useEffect(function()
        if var3.current or var1 ~= "Focus" or var2 ~= "Keyboard" then
            return
        end

        var3.current = true

        TelemetryService:LogEvent(
            config2,
            {
                customFields = {},
                standardizedFields = { "addSessionId", "addOSInfo", "addSessionInfo" }
            }
        )

        TelemetryService:LogCounter(
            config,
            {
                customFields = {},
                standardizedFields = { "addSessionId", "addOSInfo", "addSessionInfo" }
            }
        )
    end, { var1, var2 })
end

return useLogKeyboardFocusModeEntered

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UiShellEvents = script:FindFirstAncestor("UiShellEvents")
local UiShellEventsParent = UiShellEvents.Parent
local Logger = require(UiShellEvents.Logger)
local t = require(UiShellEventsParent.t)
local _RobloxAppEnums = require(UiShellEventsParent.RobloxAppEnums)

local bool1 = game:DefineFastFlag("OrientationUseTelemetryService", false)
local TelemetryService = if bool1 then game:GetService("TelemetryService") else nil
local var1 = t.strictInterface({
    deviceOrientation = t.string,
    experienceOrientation = t.optional(t.string),
    page = t.optional(t.string),
    viewportX = t.number,
    viewportY = t.number,
    universeId = t.optional(t.string),
    l2a_session_id = t.optional(t.string),
    l2b_session_id = t.optional(t.string),
    l2a_session_tag = t.optional(t.string),
    l2b_session_tag = t.optional(t.string)
})

game:DefineFastInt("UiShellOrientationChangedThrottleHundredthsPercent", 10000)

local config = {
    eventName = "uiShellOrientationChanged",
    backends = { "EventIngest" },
    throttlingPercentage = game:GetFastInt("UiShellOrientationChangedThrottleHundredthsPercent"),
    lastUpdated = { 2026, 5, 6 },
    description = "Fired when device or app orientation changes on mobile.",
    links = ""
}

return function(arg1, eventContext: string, customFields)
    local var2, var3 = var1(customFields)
    if not var2 then
        Logger:error(var3)
    end

    if not (bool1 and TelemetryService) then
        arg1:sendEventDeferred(eventContext, "uiShellOrientationChanged", customFields)

        return
    end

    TelemetryService:LogEvent(config, {
        eventContext = eventContext,
        customFields = customFields,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" }
    })
end

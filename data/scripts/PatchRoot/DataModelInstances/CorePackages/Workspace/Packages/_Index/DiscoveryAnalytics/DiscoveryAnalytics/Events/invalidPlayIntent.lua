-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")

local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local FFlagLuaAppPlayButtonLoadingDurationTelemetry = require(DiscoveryAnalyticsParent.SharedFlags).FFlagLuaAppPlayButtonLoadingDurationTelemetry

local config = {
    eventName = "invalidPlayIntent",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("LuaAppInvalidPlayIntentThrottlingHundredthsPercent", 10000),
    lastUpdated = { 26, 3, 18 },
    description = "Fires when the user clicks on a Play Button that is in an invalid state to play (i.e. Loading)"
}

local var1 = t.strictInterface({
    universeId = t.string,
    playButtonState = t.string,
    playabilityStatus = t.optional(t.string),
    pageName = if FFlagLuaAppPlayButtonLoadingDurationTelemetry then t.optional(t.string) else nil
})

return function(eventContext: string, arg1)
    local var2, var3 = var1(arg1)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("InvalidPlayIntentInvalidInterface", var3)
    end

    TelemetryService:LogEvent(config, {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = not FFlagLuaAppPlayButtonLoadingDurationTelemetry
            and {
                universeId = arg1.universeId,
                playButtonState = arg1.playButtonState,
                playabilityStatus = arg1.playabilityStatus
            }
            or arg1
    })
end

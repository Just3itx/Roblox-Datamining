-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local DiscoveryAnalytics = script:FindFirstAncestor("DiscoveryAnalytics")

local DiscoveryAnalyticsParent = DiscoveryAnalytics.Parent
local LoggingProtocol = require(DiscoveryAnalyticsParent.LoggingProtocol)

local t = require(DiscoveryAnalyticsParent.t)

local reportWarning = require(DiscoveryAnalytics.Points.reportWarning)

local throttlingPercentage = game:DefineFastInt("LuaAppGameAttributionErrorEventThrottleHundrethsPercent", 0)

local var1 = t.strictInterface({
    errorType = t.string,
    clickedUniverseId = t.string,
    universeId = t.optional(t.string),
    gameSetTypeId = t.optional(t.string),
    gameSetTargetId = t.optional(t.string),
    sortIndex = t.number,
    sortEntryIndex = t.optional(t.number)
})

local tbl1 = {
    eventName = "GameAttributionError",
    backends = { LoggingProtocol.TelemetryBackends.Points, LoggingProtocol.TelemetryBackends.EventIngest },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 25, 7, 30 },
    description = "Tracks failures to resolve game attribution errors"
}

local function reportGameAttributionError(arg1, arg2)
    local var2, var3 = var1(arg2)

    if not var2 then
        reportWarning(LoggingProtocol.default, "EventLogging", var3)
    end

    LoggingProtocol.default:logRobloxTelemetryEvent(
        tbl1,
        { "addSessionInfo", LoggingProtocol.StandardizedFields.addOsInfo },
        arg2,
        arg1
    )
end

return reportGameAttributionError

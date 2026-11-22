-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")
local TimeToInteractiveTrackerParent = TimeToInteractiveTracker.Parent

local LoggingProtocol = require(TimeToInteractiveTrackerParent.LoggingProtocol)
local default = LoggingProtocol.default

local _types = require(TimeToInteractiveTracker.Stores.types)

local navigationEventPrefix = require(TimeToInteractiveTracker.Utils.navigationEventPrefix)

local tbl1 = {
    eventName = "LuaAppNavTTIDiscarded",
    backends = { LoggingProtocol.TelemetryBackends.Counter },
    lastUpdated = { 2026, 11, 10 },
    description = "NavigateTo_ TTI samples dropped instead of sent, labeled by metricName and reason (superseded, backgrounded, joinAttempt, lateFrame). superseded, backgrounded and joinAttempt skip starts that never committed a navigation.",
    links = ""
}

local function logTTIDiscard(metricName: string, reason)
    if string.sub(metricName, 1, #navigationEventPrefix) ~= navigationEventPrefix then
        return
    end
    default:logRobloxTelemetryCounter(tbl1, 1, { metricName = metricName, reason = reason })
end

return logTTIDiscard

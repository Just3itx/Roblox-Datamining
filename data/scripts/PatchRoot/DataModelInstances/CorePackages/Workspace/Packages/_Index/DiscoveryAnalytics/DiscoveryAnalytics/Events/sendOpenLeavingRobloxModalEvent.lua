-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent
local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local throttlingPercentage = game:DefineFastInt("OpenLeavingRobloxModalThrottleHundrethsPercent", 0)

local var1 = t.strictInterface({
    assignment_id = t.number,
    assignment_type = t.string,
    social_link_type = t.string,
    social_link_display_type = t.string
})

local config = {
    eventName = "openLeavingRobloxModal",
    backends = { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 25, 12, 9 },
    description = "Event fired when a prompt is opened to confirm that the user wants to leave roblox"
}

return function(customFields)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("OpenLeavingRobloxModalInterface", var3)
    end

    TelemetryService:LogEvent(config, { standardizedFields = { "addSessionInfo" }, customFields = customFields })
end

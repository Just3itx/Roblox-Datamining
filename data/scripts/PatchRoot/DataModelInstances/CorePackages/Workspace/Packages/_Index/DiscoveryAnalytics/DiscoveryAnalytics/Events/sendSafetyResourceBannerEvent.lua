-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalytics = script:FindFirstAncestor("DiscoveryAnalytics")
local DiscoveryAnalyticsParent = DiscoveryAnalytics.Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger
local SafetyResourceBannerAction = require(DiscoveryAnalytics.Constants.SafetyResourceBannerAction)

local config = {
    eventName = "safetyResourceBanner",
    backends = { "EventIngest" },
    throttlingPercentage = game:DefineFastInt("SafetyResourceBannerEventThrottlingHundredthsPercent", 10000),
    lastUpdated = { 26, 10, 9 },
    description = "Impression or click on a search safety resource banner (e.g. SSH hotline, TVE diversion)"
}

local var1 = t.strictInterface({
    action = t.literal(
        SafetyResourceBannerAction.Impression,
        SafetyResourceBannerAction.LinkTapped,
        SafetyResourceBannerAction.Continue
    ),
    moderationCategory = t.string,
    url = t.string,
    surface = t.string,
    textFilterRequestId = t.string
})

return function(customFields)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("SafetyResourceBannerEventInvalidInterface", var3)
        return
    end

    TelemetryService:LogEvent(
        config,
        {
            standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
            customFields = customFields
        }
    )
end

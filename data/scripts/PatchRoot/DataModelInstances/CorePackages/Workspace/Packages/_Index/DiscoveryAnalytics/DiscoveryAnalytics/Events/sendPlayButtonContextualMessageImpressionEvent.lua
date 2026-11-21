-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalyticsParent = script:FindFirstAncestor("DiscoveryAnalytics").Parent
local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger

local throttlingPercentage = game:DefineFastInt("PlayButtonContextualMessageImpressionHundredthsPercent", 10000)

local var1 = t.strictInterface({ universeId = t.string, playabilityStatus = t.optional(t.string), contextualMessage = t.string })

local config = {
    eventName = "playButtonContextualMessageImpression",
    description = "Impressions for play button contextual message",
    backends = { "EventIngest" },
    throttlingPercentage = throttlingPercentage,
    lastUpdated = { 26, 5, 6 }
}

local function sendPlayButtonContextualMessageImpressionEvent(customFields, eventContext: string?)
    local var2, var3 = var1(customFields)

    if not var2 then
        DiscoveryEventErrorLogger.reportError("PlayButtonContextualMessageImpressionInvalidInterface", var3)
    end

    TelemetryService:LogEvent(config, {
        eventContext = eventContext,
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = customFields
    })
end

return sendPlayButtonContextualMessageImpressionEvent

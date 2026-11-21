-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T10:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TelemetryService = game:GetService("TelemetryService")
local DiscoveryAnalytics = script:FindFirstAncestor("DiscoveryAnalytics")
local DiscoveryAnalyticsParent = DiscoveryAnalytics.Parent

local t = require(DiscoveryAnalyticsParent.t)
local DiscoveryEventErrorLogger = require(DiscoveryAnalyticsParent.DiscoveryUtils).DiscoveryEventErrorLogger
local AiOverviewSentiment = require(DiscoveryAnalytics.Constants.AiOverviewSentiment)

local throttlingPercentage = game:DefineFastInt("AiOverviewExplicitFeedbackThrottleHundrethsPercent", 10000)

local var1 = t.strictInterface({
    sentiment = t.union(t.literal(AiOverviewSentiment.ThumbsUp), t.literal(AiOverviewSentiment.ThumbsDown)),
    searchSessionId = t.string,
    query = t.string,
    didSubmit = t.boolean,
    feedbackText = t.optional(t.string)
})

return function(customFields, eventContext: string)
    local var2, var3 = var1(customFields)
    if not var2 then
        DiscoveryEventErrorLogger.reportError("AiOverviewExplicitFeedbackInvalidInterface", var3)
    end

    TelemetryService:LogEvent(
        {
            eventName = "aiOverviewExplicitFeedback",
            backends = { "EventIngest" },
            throttlingPercentage = throttlingPercentage,
            lastUpdated = { 26, 6, 24 },
            description = "User submitted or dismissed freeform text feedback on AI Overview"
        },
        {
            eventContext = eventContext,
            standardizedFields = { "addSessionInfo" },
            customFields = customFields
        }
    )
end

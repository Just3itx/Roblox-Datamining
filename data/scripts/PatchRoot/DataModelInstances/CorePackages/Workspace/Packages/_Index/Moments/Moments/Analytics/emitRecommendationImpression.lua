-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local Constants = require(Moments.Constants)
local _RecommendationContentType = require(script.Parent.RecommendationContentType)
local _MomentsFeedType = require(Moments.Enums.MomentsFeedType)
local FFlagMomentsRecommendationContentType = require(Moments.Flags.FFlagMomentsRecommendationContentType)
local FFlagMomentsRecommendationFeedType = require(Moments.Flags.FFlagMomentsRecommendationFeedType)

local config = {
    eventName = "RecommendationImpressionEvent",
    backends = { "EventIngest" },
    throttlingPercentage = 10000,
    lastUpdated = { 26, 10, 29 },
    description = "Fires when a moment becomes visible in the platform feed"
}

local function emitRecommendationImpression(tbl1)
    local TelemetryService = game:GetService("TelemetryService")
    local contentType = if FFlagMomentsRecommendationContentType then tbl1.contentType else nil
    local feedType = if FFlagMomentsRecommendationFeedType then tbl1.feedType else nil
    local config2 = config
    local tbl2 = {
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = {
            playsessionid = "",
            universeid = Constants.MOMENTS_UNIVERSE_ID,
            placeid = Constants.MOMENTS_PLACE_ID,
            client_event_timestamp_ms = DateTime.now().UnixTimestampMillis,
            item_id = tbl1.itemId,
            tracing_id = tbl1.tracingId,
            item_position = tostring(tbl1.position),
            duration_seconds = tostring(tbl1.durationSeconds or 0),
            impression_type = tostring(tbl1.impressionType or 1),
            weight = tostring(tbl1.weight or 1),
            departure_intent = tbl1.departureIntent,
            moments_session_id = tbl1.momentsSessionId,
            source_surface = Constants.SOURCE_SURFACE,
            content_type = contentType,
            feed_type = feedType
        }
    }
    TelemetryService:LogEvent(config2, tbl2)
end

return emitRecommendationImpression

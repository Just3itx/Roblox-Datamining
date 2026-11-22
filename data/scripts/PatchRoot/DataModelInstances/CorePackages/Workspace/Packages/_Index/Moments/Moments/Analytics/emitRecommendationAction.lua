-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:40:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent
local Constants = require(Moments.Constants)
local FFlagMomentsComments = require(MomentsParent.SharedFlags).FFlagMomentsComments
local _RecommendationContentType = require(script.Parent.RecommendationContentType)
local _MomentsFeedType = require(Moments.Enums.MomentsFeedType)
local FFlagMomentsRecommendationContentType = require(Moments.Flags.FFlagMomentsRecommendationContentType)
local FFlagMomentsRecommendationFeedType = require(Moments.Flags.FFlagMomentsRecommendationFeedType)

local config = {
    eventName = "RecommendationActionEvent",
    backends = { "EventIngest" },
    throttlingPercentage = 10000,
    lastUpdated = { 26, 10, 29 },
    description = "Fires on user actions in the moments platform feed"
}

local function emitRecommendationAction(tbl1)
    local TelemetryService = game:GetService("TelemetryService")
    local HttpService = game:GetService("HttpService")
    local momentsPlayIntentId = if tbl1.actionType == Constants.RecommendationActionType.Play then HttpService:GenerateGUID(false) else nil
    local contentType = if FFlagMomentsRecommendationContentType then tbl1.contentType else nil
    local feedType = if FFlagMomentsRecommendationFeedType then tbl1.feedType else nil
    local config2 = config
    local tbl2 = {
        standardizedFields = { "addSessionInfo", "addSessionId", "addOSInfo" },
        customFields = 0
    }
    local customFields = {
        playsessionid = "",
        universeid = Constants.MOMENTS_UNIVERSE_ID,
        placeid = Constants.MOMENTS_PLACE_ID,
        client_event_timestamp_ms = DateTime.now().UnixTimestampMillis,
        item_id = tbl1.itemId,
        tracing_id = tbl1.tracingId,
        action_type = tostring(tbl1.actionType),
        moments_session_id = tbl1.momentsSessionId,
        source_surface = Constants.SOURCE_SURFACE,
        reaction_type = tbl1.reactionType,
        destination_placeid = if tbl1.destinationPlaceId then tostring(tbl1.destinationPlaceId) else nil,
        comment_text = tbl1.commentText,
        comment_section_open_duration_seconds = if FFlagMomentsComments and tbl1.commentSectionOpenDurationSeconds ~= nil then tostring(tbl1.commentSectionOpenDurationSeconds) else nil,
        action_weight = if tbl1.actionWeight then tostring(tbl1.actionWeight) else nil,
        moments_play_intent_id = momentsPlayIntentId,
        content_type = contentType,
        feed_type = feedType
    }
    tbl2.customFields = customFields
    TelemetryService:LogEvent(config2, tbl2)

    return momentsPlayIntentId
end

return emitRecommendationAction

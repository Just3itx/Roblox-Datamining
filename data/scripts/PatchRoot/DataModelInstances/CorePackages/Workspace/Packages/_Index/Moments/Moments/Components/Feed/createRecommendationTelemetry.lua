-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local _Signals = require(MomentsParent.Signals)

local Analytics = require(MomentsParent.MomentsCommon).Analytics

local Constants = require(Moments.Constants)
local _MomentsFeedType = require(Moments.Enums.MomentsFeedType)
local emitRecommendationImpression = require(Moments.Analytics.emitRecommendationImpression)
local emitRecommendationAction = require(Moments.Analytics.emitRecommendationAction)

local _SignalTracker = require(Moments.SignalTracker)
local _FeedTypes = require(script.Parent.FeedTypes)
local FFlagMomentsComments = require(MomentsParent.SharedFlags).FFlagMomentsComments

local tbl1 = {
    AddReaction = Constants.RecommendationActionType.AddReaction,
    RemoveReaction = Constants.RecommendationActionType.RemoveReaction,
    Share = Constants.RecommendationActionType.Share,
    Report = Constants.RecommendationActionType.Report,
    Join = Constants.RecommendationActionType.Play,
    Comment = if FFlagMomentsComments then Constants.RecommendationActionType.Comment else nil,
    CommentDelete = if FFlagMomentsComments then Constants.RecommendationActionType.CommentDelete else nil,
    CommentSectionOpen = if FFlagMomentsComments then Constants.RecommendationActionType.CommentSectionOpen else nil
}

local tbl2 = { AddFollow = true, RemoveFollow = true }

local tbl3 = {
    AddReaction = "reaction_add",
    RemoveReaction = "reaction_remove",
    Share = "share",
    Report = "report",
    Join = "join"
}

local function getSignalValue(str1: string, tbl4) -- Luacid: Inlined by compiler; 2 call sites recovered
    return if str1 == "AddReaction" or str1 == "RemoveReaction" then tbl4.reactionType or "" else ""
end

local function createRecommendationTelemetry(tbl4)
    local getMomentsSessionId = tbl4.getMomentsSessionId
    local signalTracker = tbl4.signalTracker
    local feedType = tbl4.feedType

    return {
        logView = function(arg1, arg2)
            emitRecommendationImpression({
                itemId = arg1.itemId,
                tracingId = arg1.tracingId or "",
                momentsSessionId = getMomentsSessionId(false),
                position = arg2.itemPosition,
                durationSeconds = arg2.durationSeconds,
                contentType = arg1.contentType,
                feedType = feedType
            })
            if signalTracker then
                signalTracker:recordSignal(arg1.itemId, "View", string.format("%.1f", arg2.durationSeconds))
            end
        end,
        logAction = function(arg1, arg2, tbl5)
            local actionType = tbl1[arg1]
            if actionType == nil then
                if signalTracker and tbl2[arg1] then
                    signalTracker:recordSignal(
                        arg2.itemId,
                        arg1,
                        if arg1 ~= "AddReaction" and arg1 ~= "RemoveReaction" then "" else getSignalValue("RemoveReaction", tbl5)
                    )
                end
                return nil
            end
            local var2 = tbl3[arg1]
            if var2 ~= nil then
                Analytics.reportMomentsEngagement(var2)
            end
            local var3 = emitRecommendationAction({
                itemId = arg2.itemId,
                tracingId = arg2.tracingId or "",
                momentsSessionId = if FFlagMomentsComments and tbl5.momentsSessionId ~= nil then tbl5.momentsSessionId else getMomentsSessionId(false),
                actionType = actionType,
                reactionType = tbl5.reactionType,
                destinationPlaceId = tbl5.destinationPlaceId,
                commentText = tbl5.commentText,
                actionWeight = tbl5.actionWeight,
                contentType = arg2.contentType,
                commentSectionOpenDurationSeconds = if FFlagMomentsComments then tbl5.commentSectionOpenDurationSeconds else nil,
                feedType = feedType
            })
            if signalTracker then
                signalTracker:recordSignal(
                    arg2.itemId,
                    arg1,
                    if arg1 ~= "AddReaction" and arg1 ~= "RemoveReaction" then "" else getSignalValue("RemoveReaction", tbl5)
                )
            end

            return var3
        end
    }
end

return createRecommendationTelemetry

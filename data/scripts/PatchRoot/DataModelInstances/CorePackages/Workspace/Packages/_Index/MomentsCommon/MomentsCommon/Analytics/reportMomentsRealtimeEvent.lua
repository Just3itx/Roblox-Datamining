-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RealtimeEventNames = require(script.Parent.RealtimeEventNames)
local RealtimeTelemetryActionList = require(script.Parent.RealtimeTelemetryActionList)
local realtimeTelemetryEmitter = require(script.Parent.realtimeTelemetryEmitter)

local function emit(arg1, arg2, func1: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 21 call sites recovered
    (func1 or realtimeTelemetryEmitter.emit)(arg1, arg2)
end

return {
    reportMomentsFeedLoadAttempt = function(feedType: string, func1: ((...any) -> (...any))?)
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsFeedLoadAttempt], { feedType = feedType }, func1)
    end,
    reportMomentsFeedLoadMore = function(status, feedType: string, failureReason: string?, func1: ((...any) -> (...any))?)
        emit(
            RealtimeTelemetryActionList[RealtimeEventNames.MomentsFeedLoadMore],
            { status = status, feedType = feedType, failureReason = failureReason },
            func1
        )
    end,
    reportMomentsFeedMediaLoad = function(status, feedType: string, failureReason: string?, func1: ((...any) -> (...any))?)
        emit(
            RealtimeTelemetryActionList[RealtimeEventNames.MomentsFeedMediaLoad],
            { status = status, feedType = feedType, failureReason = failureReason },
            func1
        )
    end,
    reportMomentsFeedState = function(status, feedType: string, failureReason: string?, func1: ((...any) -> (...any))?)
        emit(
            RealtimeTelemetryActionList[RealtimeEventNames.MomentsFeedState],
            { status = status, feedType = feedType, failureReason = failureReason },
            func1
        )
    end,
    reportMomentsSurfaceLoadAbort = function(reason, func1: ((...any) -> (...any))?)
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsSurfaceLoadAbort], { reason = reason }, func1)
    end,
    reportMomentsViewBegan = function(source: string, func1: ((...any) -> (...any))?)
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsViewBegan], { source = source }, func1)
    end,
    reportMomentsSessionStarted = function(source: string, func1: ((...any) -> (...any))?)
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsSessionStarted], { source = source }, func1)
    end,
    reportMomentsSessionEnded = function(source: string, func1: ((...any) -> (...any))?)
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsSessionEnded], { source = source }, func1)
    end,
    reportMomentsSessionHeartbeat = function(source: string, func1: ((...any) -> (...any))?)
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsSessionHeartbeat], { source = source }, func1)
    end,
    reportMomentsEngagement = function(action: string, func1: ((...any) -> (...any))?)
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsEngagement], { action = action }, func1)
    end,
    reportMomentsCreationStep = function(step: string, status: string?, reason: string?, func1: ((...any) -> (...any))?)
        emit(
            RealtimeTelemetryActionList[RealtimeEventNames.MomentsCreationStep],
            { step = step, status = status, reason = reason },
            func1
        )
    end,
    reportMomentsFeedItemsReceived = function(feedType: string, func1: ((...any) -> (...any))?)
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsFeedItemsReceived], { feedType = feedType }, func1)
    end,
    reportMomentsFeedItemFiltered = function(reason: string, feedType: string, func1: ((...any) -> (...any))?)
        emit(
            RealtimeTelemetryActionList[RealtimeEventNames.MomentsFeedItemFiltered],
            { reason = reason, feedType = feedType },
            func1
        )
    end,
    reportMomentsPublishedWithEdit = function(editType: string, func1: ((...any) -> (...any))?)
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsPublishedWithEdit], { editType = editType }, func1)
    end,
    reportMomentsPublishedEditCount = function(num1: number, func1: ((...any) -> (...any))?)
        local bucket = if num1 >= 3 then "3plus" elseif num1 == 2 then "2" elseif num1 == 1 then "1" else "0"
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsPublishedEditCount], { bucket = bucket }, func1)
    end,
    reportMomentsPublishedByCaptureType = function(captureType: string, func1: ((...any) -> (...any))?)
        emit(
            RealtimeTelemetryActionList[RealtimeEventNames.MomentsPublishedByCaptureType],
            { captureType = captureType },
            func1
        )
    end,
    reportMomentsEditToolOpened = function(tool: string, func1: ((...any) -> (...any))?)
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsEditToolOpened], { tool = tool }, func1)
    end,
    reportMomentsEditToolAbandoned = function(tool: string, func1: ((...any) -> (...any))?)
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsEditToolAbandoned], { tool = tool }, func1)
    end,
    reportMomentsGenerateText = function(status: string, func1: ((...any) -> (...any))?)
        emit(RealtimeTelemetryActionList[RealtimeEventNames.MomentsGenerateText], { status = status }, func1)
    end,
    reportMomentsPostInsightsRequest = function(query: string, status: string, func1: ((...any) -> (...any))?)
        emit(
            RealtimeTelemetryActionList[RealtimeEventNames.MomentsPostInsightsRequest],
            { query = query, status = status },
            func1
        )
    end,
    reportMomentsPostInsightsRequestLatency = function(query: string, status: string, statValue: number, func1: ((...any) -> (...any))?)
        emit(
            RealtimeTelemetryActionList[RealtimeEventNames.MomentsPostInsightsRequestLatency],
            { query = query, status = status, statValue = statValue },
            func1
        )
    end
}

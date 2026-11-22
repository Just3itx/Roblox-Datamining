-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local EventNames = require(script.Parent.EventNames)
local RealtimeEventNames = require(script.Parent.RealtimeEventNames)
local RealtimeTelemetryActionList = require(script.Parent.RealtimeTelemetryActionList)
local realtimeTelemetryEmitter = require(script.Parent.realtimeTelemetryEmitter)

local tbl1 = {
    [EventNames.MomentCommentsListLoadAttempted] = {
        counter = RealtimeEventNames.MomentsCommentsListLoad,
        status = "attempted"
    },
    [EventNames.MomentCommentsListLoadSucceeded] = {
        counter = RealtimeEventNames.MomentsCommentsListLoad,
        status = "succeeded"
    },
    [EventNames.MomentCommentsListLoadFailed] = {
        counter = RealtimeEventNames.MomentsCommentsListLoad,
        status = "failed"
    },
    [EventNames.MomentCommentPostAttempted] = {
        counter = RealtimeEventNames.MomentsCommentPost,
        status = "attempted"
    },
    [EventNames.MomentCommentPostResult] = {
        counter = RealtimeEventNames.MomentsCommentPost,
        statusField = "outcome"
    },
    [EventNames.MomentCommentTranslationToggled] = {
        counter = RealtimeEventNames.MomentsCommentTranslationToggle,
        statusField = "isTranslationShown",
        statusLabels = { ["true"] = "translated", ["false"] = "original" }
    }
}

local tbl2 = {
    [RealtimeEventNames.MomentsCommentReaction] = true,
    [RealtimeEventNames.MomentsCommentDelete] = true,
    [RealtimeEventNames.MomentsCommentReport] = true,
    [RealtimeEventNames.MomentsCommentAuthorBlock] = true
}

local function emit(arg1, tbl3, func1: ((...any) -> (...any))?) -- Luacid: Inlined by compiler; 2 call sites recovered
    (func1 or realtimeTelemetryEmitter.emit)(RealtimeTelemetryActionList[arg1], tbl3)
end

return {
    reportMomentsComments = function(str1: string, tbl3, func1: ((...any) -> (...any))?)
        local var1 = tbl1[str1]
        if var1 == nil then
            return
        end
        local status = var1.status
        if status == nil and var1.statusField ~= nil then
            status = tbl3[var1.statusField]
            local statusLabels = var1.statusLabels
            if statusLabels ~= nil and status ~= nil then
                status = statusLabels[status]
            end
        end
        emit(
            var1.counter,
            {
                status = status or "",
                loadType = tbl3.loadType,
                surface = tbl3.surface or "",
                failureReason = tbl3.failureReason
            },
            func1
        )
    end,
    reportMomentsCommentAction = function(str1: string, tbl3, func1: ((...any) -> (...any))?)
        if not tbl2[str1] then
            return
        end
        emit(
            str1,
            {
                status = tbl3.status or "",
                action = tbl3.action,
                surface = tbl3.surface or "",
                failureReason = tbl3.failureReason
            },
            func1
        )
    end
}

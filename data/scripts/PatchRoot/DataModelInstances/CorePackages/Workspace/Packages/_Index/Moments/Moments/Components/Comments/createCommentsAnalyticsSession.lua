-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local HttpService = game:GetService("HttpService")
local MomentsParent = script:FindFirstAncestor("Moments").Parent
local MomentsCommon = require(MomentsParent.MomentsCommon)
local EventNames = MomentsCommon.Analytics.EventNames
local reportMomentsComments = MomentsCommon.Analytics.reportMomentsComments
local reportMomentsCommentAction = MomentsCommon.Analytics.reportMomentsCommentAction

local function createCommentsAnalyticsSession(feedItemId: string, surface: string, func1: (...any) -> (...any), arg1, str1: string?, func2: ((...any) -> (...any))?, func3: ((...any) -> (...any))?)
    local var1 = arg1 or MomentsCommon.Analytics.fireAnalyticsEvent
    local commentPanelSessionId = str1 or HttpService:GenerateGUID(false)
    local bool1 = false
    local bool2 = false
    local bool3 = false

    local function logEvent(arg2, tbl1)
        if bool3 or not func1() then
            return
        end
        local var2 = table.clone(tbl1 or {})
        var2.feedItemId = feedItemId
        var2.surface = surface
        var2.commentPanelSessionId = commentPanelSessionId
        var1(arg2, var2)
        reportMomentsComments(arg2, var2, func2)
    end

    return {
        open = function()
            if not bool2 then
                bool2 = true
                logEvent(EventNames.MomentCommentsPanelOpened, if func3 then func3() else nil)
            end
        end,
        startView = function()
            if not bool3 then
                bool1 = true
            end
        end,
        finishView = function(closeReason: string)
            if bool1 then
                bool1 = false
                logEvent(EventNames.MomentCommentsPanelClosed, { closeReason = closeReason })
            end
        end,
        cancel = function()
            bool3 = true
            bool1 = false
        end,
        logEvent = logEvent,
        logRealtimeEvent = function(arg2, tbl1)
            if bool3 or not func1() then
                return
            end
            local var2 = table.clone(tbl1)
            var2.surface = surface
            reportMomentsCommentAction(arg2, var2, func2)
        end
    }
end
return createCommentsAnalyticsSession

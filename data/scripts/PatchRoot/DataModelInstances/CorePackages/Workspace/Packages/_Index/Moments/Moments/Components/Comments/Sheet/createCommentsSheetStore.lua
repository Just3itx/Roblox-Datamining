-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsParent = script:FindFirstAncestor("Moments").Parent

local Signals = require(MomentsParent.Signals)
local FFlagMomentsComments = require(MomentsParent.SharedFlags).FFlagMomentsComments
local _createCommentsRecommendationSession = require(script.Parent.Parent.createCommentsRecommendationSession)
local CommentsSheetSnapPoints = require(script.Parent.CommentsSheetSnapPoints)
local _getCommentsVideoLift = require(script.Parent.getCommentsVideoLift)

local _createCommentsAnalyticsSession = require(script.Parent.Parent.createCommentsAnalyticsSession)

local function createCommentsSheetStore()
    local getIsOpen, var2 = Signals.createSignal(false)

    local getFeedItemId, var4 = Signals.createSignal(nil)
    local getOpenSessionId, var6 = Signals.createSignal(0)

    local getIsListScrollingEnabled, var8 = Signals.createSignal(true)

    local getVideoLift, setVideoLift = Signals.createSignal(nil)
    local getIsExpanded, var12 = Signals.createSignal(false)
    local var13 = nil
    local var14 = nil
    local var15 = nil

    return {
        getIsOpen = getIsOpen,
        getFeedItemId = getFeedItemId,
        getOpenSessionId = getOpenSessionId,
        getIsListScrollingEnabled = getIsListScrollingEnabled,
        getVideoLift = getVideoLift,
        getIsExpanded = getIsExpanded,
        getRecommendationSession = function(str1: string, num1: number)
            return if getFeedItemId(false) == str1 and getOpenSessionId(false) == num1 then var13 else nil
        end,
        getAnalyticsSession = function(str1: string, num1: number)
            return if getFeedItemId(false) == str1 and getOpenSessionId(false) == num1 then var14 else nil
        end,
        getTarget = function(str1: string, num1: number)
            return if getFeedItemId(false) == str1 and getOpenSessionId(false) == num1 then var15 else nil
        end,
        open = function(str1: string, arg1, arg2, tbl1)
            if FFlagMomentsComments then
                if var14 ~= nil then
                    var14.finishView("replaced")
                end
                var14 = arg2
                if var14 ~= nil then
                    var14.open()
                end
            end
            if FFlagMomentsComments then
                if var13 ~= nil then
                    var13.finishView()
                end
                var13 = arg1
            end
            var15 = tbl1
            var4(str1)
            var6(getOpenSessionId(false) + 1)
            var8(true)
            setVideoLift(nil)
            var12(false)
            var2(true)
        end,
        close = function(arg1)
            if FFlagMomentsComments and var14 ~= nil then
                var14.finishView(arg1 or "closed")
            end
            if FFlagMomentsComments and var13 ~= nil then
                var13.finishView()
            end
            var15 = nil

            var12(false)
            var2(false)
        end,
        reset = function()
            if FFlagMomentsComments and var14 ~= nil then
                var14.cancel()
                var14 = nil
            end
            if FFlagMomentsComments and var13 ~= nil then
                var13.cancel()
                var13 = nil
            end
            var15 = nil
            var2(false)
            var4(nil)
            var6(getOpenSessionId(false) + 1)
            var8(true)
            setVideoLift(nil)
            var12(false)
        end,
        setSnapPointIndex = function(num1: number)
            var8(num1 == #CommentsSheetSnapPoints)
            var12(num1 == #CommentsSheetSnapPoints)
        end,
        setVideoLift = setVideoLift
    }
end

return createCommentsSheetStore

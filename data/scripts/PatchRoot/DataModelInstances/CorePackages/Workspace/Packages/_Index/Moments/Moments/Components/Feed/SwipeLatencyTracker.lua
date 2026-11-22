-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local React = require(MomentsParent.React)
local MomentsCommon = require(MomentsParent.MomentsCommon)

local _FeedTypes = require(script.Parent.FeedTypes)
local useSwipeLatency = require(script.Parent.useSwipeLatency)
local _VerticalPager = require(Moments.Components.VerticalPager)

local MediaPreloadProvider = MomentsCommon.Media.MediaPreloadProvider

local function SwipeLatencyTracker(tbl1)
    local pager = tbl1.pager
    local var1 = MediaPreloadProvider.useMediaControllerProvider()

    local var2 = React.useMemo(function()
        return function(arg1, arg2)
            if var1 == nil then
                return nil
            end
            if arg2 == nil or arg2.kind ~= "moment" then
                return nil
            end
            local momentId = arg2.moment.momentId
            return var1.getControllerMap(arg1)[momentId]
        end
    end, { var1 })

    local var3 = React.useMemo(function()
        return function(arg1, arg2): boolean
            local var3 = var2(arg1, arg2)
            if var3 == nil then
                return false
            end

            if arg2 ~= nil and arg2.kind == "moment" and arg2.moment.metadata.captureType == Enum.CaptureType.Video then
                return var3.getPosition(arg1) > 0
            end

            return var3.getState(arg1).readiness == "Ready"
        end
    end, { var2 })

    local getHasPresentedFrame = React.useMemo(function()
        return function(arg1)
            return var3(arg1, pager.getCurrentItem(arg1))
        end
    end, { pager, var3 })

    local getTargetHasPresentedFrame = React.useCallback(function(arg1)
        return var3(false, arg1)
    end, { var3 })

    local getCaptureType = React.useCallback(function(arg1): string
        if arg1 == nil or arg1.kind ~= "moment" then
            return "unknown"
        end
        local captureType = arg1.moment.metadata.captureType

        if captureType == Enum.CaptureType.Video then
            return "video"
        end

        if captureType == Enum.CaptureType.Screenshot then
            return "screenshot"
        end

        return "unknown"
    end, {})

    local getIsSettled = React.useMemo(function()
        return function(arg1): boolean
            local current = tbl1.controllerRef.current
            return current == nil or current.getScrollState(arg1) == "Idle"
        end
    end, { tbl1.controllerRef })

    local current = useSwipeLatency({
        getIsSettled = getIsSettled,
        getHasPresentedFrame = getHasPresentedFrame,
        getTargetHasPresentedFrame = getTargetHasPresentedFrame,
        getCaptureType = getCaptureType
    })

    React.useEffect(function()
        tbl1.onTargetCommittedRef.current = current
        return function()
            if tbl1.onTargetCommittedRef.current == current then
                tbl1.onTargetCommittedRef.current = nil
            end
        end
    end, { tbl1.onTargetCommittedRef, current })

    return nil
end

return SwipeLatencyTracker

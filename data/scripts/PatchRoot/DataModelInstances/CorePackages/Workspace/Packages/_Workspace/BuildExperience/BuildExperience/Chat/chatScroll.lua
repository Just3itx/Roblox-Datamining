-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T18:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local chatConstants = require(script.Parent.chatConstants)

local num1 = game:DefineFastInt("BuildHistoryLoadTriggerViewportHeightPercent", 100)

local function getBottomCanvasPosition(arg1): number -- Luacid: Inlined by compiler; 4 call sites recovered
    return math.max(0, arg1.AbsoluteCanvasSize.Y - arg1.AbsoluteWindowSize.Y)
end

return {
    getBottomCanvasPosition = getBottomCanvasPosition,
    getDistanceFromBottom = function(arg1): number
        return math.max(0, getBottomCanvasPosition(arg1) - arg1.CanvasPosition.Y)
    end,
    getOffsetInViewport = function(arg1, arg2)
        return arg2.AbsolutePosition.Y - arg1.AbsolutePosition.Y
    end,
    isScrolledToBottom = function(arg1): boolean
        return math.max(0, getBottomCanvasPosition(arg1) - arg1.CanvasPosition.Y) <= chatConstants.BOTTOM_SCROLL_THRESHOLD
    end,
    isScrolledToTop = function(arg1): boolean
        return arg1.CanvasPosition.Y <= 0
    end,
    isScrolledNearTop = function(arg1): boolean
        return arg1.CanvasPosition.Y / arg1.AbsoluteWindowSize.Y <= num1 / 100
    end,
    scrollToBottom = function(arg1)
        arg1.CanvasPosition = Vector2.new(0, (getBottomCanvasPosition(arg1)))
    end,
    syncScrollFromBottom = function(arg1, bottomScrollThreshold: number)
        local bottomCanvasPosition = getBottomCanvasPosition(arg1)

        if bottomScrollThreshold <= chatConstants.BOTTOM_SCROLL_THRESHOLD then
            arg1.CanvasPosition = Vector2.new(0, bottomCanvasPosition)
            return
        end

        arg1.CanvasPosition = Vector2.new(0, math.max(0, bottomCanvasPosition - bottomScrollThreshold))
    end
}

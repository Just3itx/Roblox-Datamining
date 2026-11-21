-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceUIKitParent = script:FindFirstAncestor("AvatarExperienceUIKit").Parent

local React = require(AvatarExperienceUIKitParent.React)

local createScrollIntervalPerformanceTracker = require(AvatarExperienceUIKitParent.IntervalPerformanceTracker).createScrollIntervalPerformanceTracker

local function getNativeScrollingFrame(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local current = tbl1.current
    if current == nil then
        return nil
    end
    local nativeScrollRef = current:getNativeScrollRef()
    return if nativeScrollRef == nil or nativeScrollRef._nativeRef == nil then nil else nativeScrollRef._nativeRef.current
end

local function useFlatListScrollPerformanceTracker(str1: string?, tbl1, str2: string?)
    React.useEffect(function()
        if str1 == nil then
            return
        end
        local nativeScrollingFrame = getNativeScrollingFrame(tbl1)
        if nativeScrollingFrame == nil then
            return
        end

        local scrollIntervalPerformanceTracker = createScrollIntervalPerformanceTracker(str1, nativeScrollingFrame)
        local connection = nativeScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(scrollIntervalPerformanceTracker.onScrollTick)

        return function()
            connection:Disconnect()
            scrollIntervalPerformanceTracker.cleanup()
        end
    end, { str1, tbl1, str2 })
end

return useFlatListScrollPerformanceTracker

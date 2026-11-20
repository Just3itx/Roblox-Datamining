-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T23:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppPageShell = script:FindFirstAncestor("AppPageShell")
local AppPageShellParent = AppPageShell.Parent

local Signals = require(AppPageShellParent.Signals)
local SignalsExperimental = require(AppPageShellParent.SignalsExperimental)
local IntervalPerformanceTracker = require(AppPageShellParent.IntervalPerformanceTracker)

local isEndReached = require(AppPageShell.isEndReached)
local FFlagSduiFeedScrollBarFixes = require(AppPageShellParent.SharedFlags).FFlagSduiFeedScrollBarFixes
local FFlagAppPageShellScrollTelemetry = require(AppPageShellParent.SharedFlags).FFlagAppPageShellScrollTelemetry

local function createPageScrollStore(debugName: string?)
    local getScrollingFrame, var2 = Signals.createSignal(nil)
    local getCanvasPosition, var4 = Signals.createSignal(0)
    local getViewportHeight, setViewportHeight = Signals.createSignal(0)
    local getContentHeight, setContentHeight = Signals.createSignal(0)
    local var9, setEndReachedThreshold = Signals.createSignal(nil)

    local getIsEndReached = Signals.createComputed(function(arg1)
        return isEndReached(getCanvasPosition(arg1), getViewportHeight(arg1), getContentHeight(arg1), var9(arg1))
    end)

    local scrollIntervalPerformanceTracker = nil

    local function rebindTracker(arg1)
        if scrollIntervalPerformanceTracker then
            scrollIntervalPerformanceTracker.cleanup()
            scrollIntervalPerformanceTracker = nil
        end
        if not debugName or not arg1 then
            return
        end

        scrollIntervalPerformanceTracker = IntervalPerformanceTracker.createScrollIntervalPerformanceTracker(
            debugName,
            arg1,
            nil,
            {
                scrollOptions = { debugName = debugName }
            }
        )
    end

    local function setCanvasPosition(num1: number) -- Luacid: Inlined by compiler; 2 call sites recovered
        var4(num1)
        if FFlagAppPageShellScrollTelemetry and scrollIntervalPerformanceTracker then
            scrollIntervalPerformanceTracker.onScrollTick()
        end
    end
    local function setCanvasPositionFromScrollingFrame(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        setCanvasPosition(arg1.CanvasPosition.Y)
    end
    local function setViewportHeightFromScrollingFrame(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        setViewportHeight(arg1.AbsoluteWindowSize.Y)
    end
    local function setContentHeightFromScrollingFrame(arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
        setContentHeight(arg1.AbsoluteCanvasSize.Y)
    end

    local function writeExtents(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
        setViewportHeightFromScrollingFrame(arg1)
        setContentHeightFromScrollingFrame(arg1)
    end

    return {
        getScrollingFrame = getScrollingFrame,
        setScrollingFrame = function(arg1)
            if FFlagAppPageShellScrollTelemetry and arg1 ~= getScrollingFrame(false) then
                rebindTracker(arg1)
            end

            var2(arg1)
            if FFlagSduiFeedScrollBarFixes and arg1 ~= nil then
                SignalsExperimental.batch(function()
                    setCanvasPositionFromScrollingFrame(arg1)
                    writeExtents(arg1)
                end)
            end
        end,
        getCanvasPosition = getCanvasPosition,
        getViewportHeight = getViewportHeight,
        getContentHeight = getContentHeight,
        setCanvasPosition = setCanvasPosition,
        setViewportHeight = setViewportHeight,
        setContentHeight = setContentHeight,
        setCanvasPositionFromScrollingFrame = setCanvasPositionFromScrollingFrame,
        setViewportHeightFromScrollingFrame = setViewportHeightFromScrollingFrame,
        setContentHeightFromScrollingFrame = setContentHeightFromScrollingFrame,
        setExtentsFromScrollingFrame = function(arg1)
            SignalsExperimental.batch(function()
                writeExtents(arg1)
            end)
        end,
        getIsEndReached = getIsEndReached,
        setEndReachedThreshold = setEndReachedThreshold
    }
end

return createPageScrollStore

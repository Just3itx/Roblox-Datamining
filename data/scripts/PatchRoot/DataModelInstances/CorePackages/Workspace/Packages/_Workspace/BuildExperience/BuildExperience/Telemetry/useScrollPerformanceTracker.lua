-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local createScrollIntervalPerformanceTracker = require(BuildExperienceParent.IntervalPerformanceTracker).createScrollIntervalPerformanceTracker

local function useScrollPerformanceTracker(str1: string, arg1)
    React.useEffect(function()
        local current = arg1.current
        if current == nil then
            return
        end

        local scrollIntervalPerformanceTracker = createScrollIntervalPerformanceTracker(str1, current)
        local connection = current:GetPropertyChangedSignal("CanvasPosition"):Connect(scrollIntervalPerformanceTracker.onScrollTick)

        return function()
            connection:Disconnect()
            scrollIntervalPerformanceTracker.cleanup()
        end
    end, { str1 })
end

return useScrollPerformanceTracker

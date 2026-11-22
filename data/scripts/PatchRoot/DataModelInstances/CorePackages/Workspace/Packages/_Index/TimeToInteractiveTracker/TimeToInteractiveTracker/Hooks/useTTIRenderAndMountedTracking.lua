-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:50:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TimeToInteractiveTracker = script:FindFirstAncestor("TimeToInteractiveTracker")
local TimeToInteractiveTrackerParent = TimeToInteractiveTracker.Parent
local React = require(TimeToInteractiveTrackerParent.React)
local constants = require(TimeToInteractiveTracker.Milestones.constants)

local _types = require(TimeToInteractiveTracker.Milestones.types)

local function createUseTTIRenderAndMountedTracking(callback: (...any) -> (...any)): (string) -> ()
    return function(str1: string)
        local var1 = React.useRef(false)

        if not var1.current then
            var1.current = true
            callback(str1, constants.RenderStarted)
        end

        React.useEffect(function()
            callback(str1, constants.SurfaceMounted)
        end, {})
    end
end

return createUseTTIRenderAndMountedTracking

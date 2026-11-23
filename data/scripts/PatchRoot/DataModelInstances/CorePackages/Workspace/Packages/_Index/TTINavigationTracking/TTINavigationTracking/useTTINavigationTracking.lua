-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:11:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TTINavigationTrackingParent = script:FindFirstAncestor("TTINavigationTracking").Parent

local React = require(TTINavigationTrackingParent.React)
local RoactNavigation = require(TTINavigationTrackingParent.RoactNavigation)
local useNavigation = require(TTINavigationTrackingParent.Navigation).useNavigation
local RobloxAppNavigation = require(TTINavigationTrackingParent.RobloxAppNavigation)
local SharedFlags = require(TTINavigationTrackingParent.SharedFlags)
local FFlagEnableOnScreenAPIIntegration = SharedFlags.FFlagEnableOnScreenAPIIntegration
local FFlagLuaAppNavTTIMeasurementV2 = SharedFlags.FFlagLuaAppNavTTIMeasurementV2
local useOnScreenNavigationListener = if FFlagEnableOnScreenAPIIntegration then RobloxAppNavigation.useOnScreenNavigationListener else nil
local TimeToInteractiveTracker = require(TTINavigationTrackingParent.TimeToInteractiveTracker).TimeToInteractiveTracker
local Milestone = TimeToInteractiveTracker.Milestone
local Hooks = TimeToInteractiveTracker.Hooks or nil
local trackMilestone = TimeToInteractiveTracker.trackMilestone or nil

local function useTTINavigationTracking(str1: string)
    Hooks.useTTIRenderAndMountedTracking(str1)

    local var1 = useNavigation()

    local function endNavigation() -- Luacid: Inlined by compiler; 3 call sites recovered
        if FFlagLuaAppNavTTIMeasurementV2 then
            TimeToInteractiveTracker.discardOlderNavigationStarts(str1)
            TimeToInteractiveTracker.trackEndAtNextFrame(str1)
            return
        end
        TimeToInteractiveTracker.trackEnd(str1)
    end

    local function onWillFocus() -- Luacid: Inlined by compiler; 1 call site recovered
        local var2 = TimeToInteractiveTracker.getEvents(false)[str1]
        if var2 and var2.startTime then
            trackMilestone(str1, Milestone.RenderStarted)
        end
    end
    local function onDidFocus() -- Luacid: Inlined by compiler; 1 call site recovered
        local var2 = TimeToInteractiveTracker.getEvents(false)[str1]
        if not (var2 and var2.startTime) then
            return
        end
        trackMilestone(str1, Milestone.SurfaceMounted)
        endNavigation()
    end

    if FFlagEnableOnScreenAPIIntegration then
        useOnScreenNavigationListener(function()
            if var1.isFocused() then
                return
            end

            onWillFocus()
            onDidFocus()
        end, nil)
    end

    React.useEffect(function()
        endNavigation()
        local var2 = var1.addListener(RoactNavigation.Events.WillFocus, onWillFocus)
        local var3 = var1.addListener(RoactNavigation.Events.DidFocus, onDidFocus)
        return function()
            var2.remove()
            var3.remove()
        end
    end, {})
end

return useTTINavigationTracking

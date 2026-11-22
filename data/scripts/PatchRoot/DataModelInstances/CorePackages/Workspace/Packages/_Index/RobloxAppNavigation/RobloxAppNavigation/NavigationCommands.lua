-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RobloxAppNavigationParent = script:FindFirstAncestor("RobloxAppNavigation").Parent

local RoactNavigation = require(RobloxAppNavigationParent.RoactNavigation)

local AppNavigationRegistry = require(script.Parent.AppNavigationRegistry)
local SharedFlags = require(RobloxAppNavigationParent.SharedFlags)
local FFlagSignalsNavPendingLock = SharedFlags.FFlagSignalsNavPendingLock
local FFlagSignalsNavHomeFlowBegin = SharedFlags.FFlagSignalsNavHomeFlowBegin
local HomePageLoadTracker = if FFlagSignalsNavHomeFlowBegin then require(RobloxAppNavigationParent.HomePageLoadTracker).HomePageLoadTracker else nil
local Home = require(RobloxAppNavigationParent.RobloxAppEnums).AppPage.Home

local trackStart = require(RobloxAppNavigationParent.TimeToInteractiveTracker).TimeToInteractiveTracker.trackStart

local function isNavigationLocked(bool1: boolean?) -- Luacid: Inlined by compiler; 6 call sites recovered
    if FFlagSignalsNavPendingLock then
        return not bool1 and AppNavigationRegistry.isNavigationLocked(false)
    end

    return not bool1 and AppNavigationRegistry.get().getIsNavigating(false)
end

local function beginHomeVisitIfHome(tbl1) -- Luacid: Inlined by compiler; 5 call sites recovered
    if tbl1 and tbl1.routeName == Home then
        HomePageLoadTracker.beginVisit()
    end
end

return {
    back = function(bool1: boolean?)
        if isNavigationLocked(bool1) then
            return
        end
        AppNavigationRegistry.get().dispatch(RoactNavigation.Actions.back())
    end,
    down = function(tbl1, bool1: boolean?)
        if isNavigationLocked(bool1) then
            return
        end
        if trackStart then
            trackStart("NavigateTo_" .. tbl1.routeName, true)
        end
        if FFlagSignalsNavHomeFlowBegin then
            beginHomeVisitIfHome(tbl1)
        end

        AppNavigationRegistry.get().dispatch(RoactNavigation.StackActions.push(tbl1))
    end,
    to = function(tbl1, bool1: boolean?)
        if isNavigationLocked(bool1) then
            return
        end
        if trackStart then
            trackStart("NavigateTo_" .. tbl1.routeName, true)
        end
        if FFlagSignalsNavHomeFlowBegin then
            beginHomeVisitIfHome(tbl1)
        end

        AppNavigationRegistry.get().dispatch(RoactNavigation.Actions.navigate(tbl1))
    end,
    sideways = function(tbl1, bool1: boolean?)
        if isNavigationLocked(bool1) then
            return
        end
        if trackStart then
            trackStart("NavigateTo_" .. tbl1.routeName, true)
        end
        if FFlagSignalsNavHomeFlowBegin then
            beginHomeVisitIfHome(tbl1)
        end

        AppNavigationRegistry.get().dispatch(RoactNavigation.Actions.navigate(tbl1))
    end,
    fromWebView = function(tbl1, bool1: boolean?)
        if isNavigationLocked(bool1) then
            return
        end
        if trackStart then
            trackStart("NavigateTo_" .. tbl1.routeName, true)
        end
        if FFlagSignalsNavHomeFlowBegin then
            beginHomeVisitIfHome(tbl1)
        end

        AppNavigationRegistry.get().dispatch(RoactNavigation.StackActions.replace(tbl1))
    end,
    resetStack = function(tbl1, tbl2, bool1: boolean?)
        if isNavigationLocked(bool1) then
            return
        end
        local actions = {}
        local wrapAction = if tbl2 then tbl2.wrapAction else nil

        for _, value in tbl1 do
            local var1 = RoactNavigation.Actions.navigate(value)
            if wrapAction then
                var1 = wrapAction(var1, value) or var1
            end
            table.insert(actions, var1)
        end

        if trackStart then
            local var1 = tbl1[#tbl1]
            if var1 then
                trackStart("NavigateTo_" .. var1.routeName, true)
            end
        end
        if FFlagSignalsNavHomeFlowBegin then
            beginHomeVisitIfHome(tbl1[#tbl1])
        end

        AppNavigationRegistry.get().dispatch(RoactNavigation.StackActions.reset({ index = #actions, actions = actions }))
    end,
    fromLegacyPage = function(tbl1)
        local var1 = nil
        for value, value2 in tbl1 do
            if value ~= "name" and value ~= "rnKey" and value ~= "key" then
                var1 = var1 == nil and {} or var1

                var1[value] = value2
            end
        end
        return {
            routeName = tbl1.name,
            params = var1,
            key = tbl1.rnKey or tbl1.key
        }
    end
}

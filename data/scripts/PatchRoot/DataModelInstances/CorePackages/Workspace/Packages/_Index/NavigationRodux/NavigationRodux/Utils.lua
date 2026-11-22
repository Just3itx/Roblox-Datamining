-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")
local NavigationRoduxParent = NavigationRodux.Parent

local Cryo = require(NavigationRoduxParent.Cryo)
local getActiveRoutes = require(NavigationRoduxParent.Navigation).getActiveRoutes
local AppPage = require(NavigationRoduxParent.RobloxAppEnums).AppPage
local FFlagAppIaHomeSubTab = require(NavigationRoduxParent.SharedFlags).FFlagAppIaHomeSubTab

local _types = require(NavigationRodux.types)
local Constants = require(NavigationRodux.Constants)

local function legacyRouteFilter(arg1): boolean
    return not (arg1.routeName == Constants.TempRnSwitchNavigatorName) and arg1.key ~= "StackRouterRoot"
end

local function getLegacyPageFromRoactNavigationRoute(arg1)
    return Cryo.Dictionary.join(arg1.params or {}, { name = arg1.routeName, rnKey = arg1.key })
end

local function getTabNavigatorState(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.routeName == Constants.TempRnSwitchNavigatorName then
        return arg1
    end

    local var1 = arg1.routes[arg1.index]
    if var1.routes then
        return getTabNavigatorState(var1)
    end

    return nil
end

return {
    getLegacyPageFromRoactNavigationRoute = getLegacyPageFromRoactNavigationRoute,
    getLegacyRouteFromRoactNavigationState = function(arg1)
        return Cryo.List.map(Cryo.List.filter(getActiveRoutes(arg1), legacyRouteFilter), getLegacyPageFromRoactNavigationRoute)
    end,
    getLegacyHistoryFromRoactNavigationState = function(arg1)
        local legacyHistoryFromRoactNavigationState = ({})

        for i = 1, arg1.index do
            local var1 = arg1.routes[i]
            if var1.routes and var1.routeName == Constants.TempRnSwitchNavigatorName then
                var1 = var1.routes[var1.index]
            end

            if FFlagAppIaHomeSubTab and var1.routes and var1.routeName == Constants.HomeContainerName then
                var1 = var1.routes[var1.index]
            end

            local legacyPageFromRoactNavigationRoute = getLegacyPageFromRoactNavigationRoute(var1)
            legacyHistoryFromRoactNavigationState[i] = Cryo.List.join(legacyHistoryFromRoactNavigationState[i - 1] or {}, { legacyPageFromRoactNavigationRoute })
        end

        return legacyHistoryFromRoactNavigationState
    end,
    getCurrentTabName = function(arg1)
        local tabNavigatorState = getTabNavigatorState(arg1)

        if tabNavigatorState == nil then
            return AppPage.None
        end

        return tabNavigatorState.routes[tabNavigatorState.index].routeName
    end
}

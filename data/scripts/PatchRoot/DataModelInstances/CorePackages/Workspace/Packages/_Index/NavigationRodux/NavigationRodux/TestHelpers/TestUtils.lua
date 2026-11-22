-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:00:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local NavigationRodux = script:FindFirstAncestor("NavigationRodux")
local NavigationRoduxParent = NavigationRodux.Parent

local Navigation = require(NavigationRoduxParent.Navigation)
local getCurrentRouteState = Navigation.getCurrentRouteState
local RoactNavigation = require(NavigationRoduxParent.RoactNavigation)
local Actions = RoactNavigation.Actions
local StackActions = RoactNavigation.StackActions
local AppPage = require(NavigationRoduxParent.RobloxAppEnums).AppPage

local Constants = require(NavigationRodux.Constants)
local _types = require(NavigationRodux.types)
local getLegacyRouteFromRoactNavigationState = require(NavigationRodux.Utils).getLegacyRouteFromRoactNavigationState

local createMockStackState = Navigation.TestUtils.createMockStackState
local createMockScreenState = Navigation.TestUtils.createMockScreenState

local function createMockReducerStateFromRouteState(arg1)
    return {
        history = { (getLegacyRouteFromRoactNavigationState(arg1)) },
        currentRoute = getCurrentRouteState({ state = arg1 }),
        roactNavigationState = arg1,
        lockNavigationActions = false,
        backNavigationDisableCounter = 0
    }
end

local function createMockRouteStateFromPages(tbl1)
    local tbl2 = {}
    for _, value in tbl1 do
        table.insert(tbl2, createMockScreenState(value.name, value))
    end
    return createMockStackState("StackRouterRoot", tbl2)
end

local tbl1 = {
    [AppPage.Home] = true,
    [AppPage.Games] = true,
    [AppPage.Moments] = true,
    [AppPage.AvatarExperienceRoot] = true,
    [AppPage.Chat] = true,
    [AppPage.More] = true
}

local function navigateToRoute(arg1, tbl2)
    local actions = {}
    for _, routeName in tbl2 do
        local var1 = typeof(routeName) == "string" and { routeName = routeName } or routeName
        local var2 = Actions.navigate(var1)
        if tbl1[var1.routeName] then
            var2 = Actions.navigate(
                {
                    routeName = Constants.TempRnSwitchNavigatorName,
                    action = var2,
                    key = Constants.TempRnSwitchNavigatorName
                }
            )
        end

        table.insert(actions, var2)
    end
    arg1.dispatch(StackActions.reset({ index = #actions, actions = actions }))
end

return {
    createMockReducerStateFromRouteState = createMockReducerStateFromRouteState,
    createMockRouteStateFromPages = createMockRouteStateFromPages,
    createMockNavigationState = function(...)
        local tbl2 = {}
        for _, name in { ... } do
            table.insert(tbl2, { name = name })
        end
        local mockRouteStateFromPages = createMockRouteStateFromPages(tbl2)
        return (createMockReducerStateFromRouteState(mockRouteStateFromPages))
    end,
    resetNavigation = function(arg1, tbl2)
        arg1.notifyEvents()
        if tbl2 == nil or #tbl2 == 0 then
            arg1.dispatch({ type = "RESET_NAVIGATION_FOR_TESTING_ONLY__DO_NOT_USE_IN_PRODUCTION" })
            return
        end

        navigateToRoute(arg1, tbl2)
        arg1.notifyEvents()
    end,
    createMockStackState = createMockStackState,
    createMockSwitchState = Navigation.TestUtils.createMockSwitchState,
    createMockScreenState = createMockScreenState
}

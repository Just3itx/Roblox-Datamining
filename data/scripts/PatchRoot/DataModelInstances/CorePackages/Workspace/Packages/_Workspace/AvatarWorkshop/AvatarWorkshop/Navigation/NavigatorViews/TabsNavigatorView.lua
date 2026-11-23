-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T17:50:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarWorkshop = script:FindFirstAncestor("AvatarWorkshop")
local AvatarWorkshopParent = AvatarWorkshop.Parent

local _Foundation = require(AvatarWorkshopParent.Foundation)
local Localization = require(AvatarWorkshopParent.Localization)
local RoactNavigation = require(AvatarWorkshopParent.RoactNavigation)
local React = require(AvatarWorkshopParent.React)

local _NavigationTypes = require(AvatarWorkshop.Navigation.NavigationTypes)
local TabsLayout = require(AvatarWorkshop.Components.Layouts.TabsLayout)
local getActiveRoute = require(AvatarWorkshop.Navigation.getActiveRoute)
local ScreenTitles = require(AvatarWorkshop.Constants.ScreenTitles)

local useLocalization = Localization.Hooks.useLocalization

local function TabsNavigatorView(arg1)
    local activeRoute = getActiveRoute(arg1.navigation)

    local routes = arg1.navigation.state.routes
    local var1 = useLocalization(ScreenTitles)
    local tabs = {}
    for _, value in routes do
        table.insert(tabs, { id = value.key, text = var1[value.routeName] or value.routeName })
    end

    local onTabActivated = React.useCallback(function(key)
        for _, value in routes do
            if value.key == key then
                arg1.navigation.navigate(value.routeName)
                return
            end
        end
    end, { arg1.navigation, routes })

    local key = arg1.navigation.state.key
    local testId = if key then `--avatar-workshop-tabs-{key}` else "--avatar-workshop-tabs"

    return React.createElement(
        TabsLayout,
        {
            tabs = tabs,
            activeTabId = activeRoute.key,
            onTabActivated = onTabActivated,
            testId = testId
        },
        {
            Content = React.createElement(RoactNavigation.RobloxSwitchView, arg1)
        }
    )
end
return TabsNavigatorView

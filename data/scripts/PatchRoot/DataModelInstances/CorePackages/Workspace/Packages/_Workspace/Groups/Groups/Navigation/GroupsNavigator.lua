-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:50:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local _Navigation = require(GroupsParent.Navigation)
local React = require(GroupsParent.React)
local RoactNavigation = require(GroupsParent.RoactNavigation)

local GroupOverviewPane = require(Groups.Components.GroupOverviewPane)
local GroupsPage = require(Groups.Components.GroupsPage)
local GroupsRoutes = require(script.Parent.GroupsRoutes)

local tbl1 = {
    [GroupsRoutes.GroupsPage] = {
        screen = function(_) -- name: renderGroupsPage
            return React.createElement(GroupsPage)
        end
    }
}

local tbl2 = {
    [GroupsRoutes.GroupOverviewPane] = {
        screen = function(tbl2) -- name: renderGroupOverviewPane
            return React.createElement(GroupOverviewPane, { navigation = tbl2.navigation })
        end,
        navigationOptions = { disableBackButton = false }
    }
}

local tbl3 = { tbl1, tbl2 }

return RoactNavigation.createRobloxStackNavigator(tbl3, {
    initialRouteName = GroupsRoutes.GroupsPage,
    keepVisitedScreensMounted = false,
    backBehavior = RoactNavigation.BackBehavior.History
})

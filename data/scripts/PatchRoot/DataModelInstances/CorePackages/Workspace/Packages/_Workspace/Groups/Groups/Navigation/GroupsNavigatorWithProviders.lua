-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local React = require(GroupsParent.React)

local GroupsPage = require(Groups.Components.GroupsPage)
local FFlagEnableGroupOverviewPane = require(GroupsParent.SharedFlags).FFlagEnableGroupOverviewPane
local GroupsNavigator = if FFlagEnableGroupOverviewPane then require(script.Parent.GroupsNavigator) else nil
local GroupsRoutes = if FFlagEnableGroupOverviewPane then require(script.Parent.GroupsRoutes) else nil
local useIsCompactTouch = if FFlagEnableGroupOverviewPane then require(Groups.Hooks.useIsCompactTouch) else nil
local useGroupsWrapperContext = require(Groups.Contexts.useGroupsWrapperContext)
local initializeGroupsAnalytics = require(Groups.Analytics.initializeGroupsAnalytics)
local GroupsAnalyticsContext = require(Groups.Analytics.GroupsAnalyticsContext)

local function GroupsWithContext(arg1)
    local var1 = useGroupsWrapperContext()
    if FFlagEnableGroupOverviewPane then
        local var2 = useIsCompactTouch()
        local var3 = React.useRef(nil)
        React.useEffect(function()
            if var1.groupId == nil then
                var3.current = nil
                return
            end

            if not arg1.navigation or not var2 or var3.current == var1.groupId then
                return
            end

            var3.current = var1.groupId
            arg1.navigation.navigate(
                GroupsRoutes.GroupOverviewPane,
                {
                    groupId = var1.groupId,
                    source = var1.groupOverviewPaneSource
                }
            )
        end, {
            var1.groupId,
            var1.groupOverviewPaneSource,
            arg1.navigation,
            var2
        })
    end
    local value = React.useMemo(function()
        local var2 = initializeGroupsAnalytics()
        var2.updateInfoForAllEvents({ userId = var1.userId })

        return var2
    end, { var1.userId })

    local var3 = FFlagEnableGroupOverviewPane and {
        GroupsContent = React.createElement(GroupsNavigator, arg1)
    }
        or {
            GroupsPage = React.createElement(GroupsPage, arg1)
        }

    return React.createElement(GroupsAnalyticsContext.Provider, { value = value }, var3)
end

if not FFlagEnableGroupOverviewPane then
    return GroupsWithContext
end

local var1 = React.PureComponent:extend("GroupsNavigatorWithProviders")

function var1.render(arg1)
    return React.createElement(GroupsWithContext, arg1.props)
end

var1.router = GroupsNavigator.router

return var1

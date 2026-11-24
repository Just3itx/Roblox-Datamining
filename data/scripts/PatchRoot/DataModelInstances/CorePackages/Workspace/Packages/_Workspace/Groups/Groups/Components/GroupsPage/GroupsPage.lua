-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:41:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent

local React = require(GroupsParent.React)
local useEffectOnce = require(GroupsParent.RoactUtils).Hooks.useEffectOnce

local FFlagEnableGroupOverviewPane = require(GroupsParent.SharedFlags).FFlagEnableGroupOverviewPane
local useIsCompactTouch = if FFlagEnableGroupOverviewPane then require(Groups.Hooks.useIsCompactTouch) else nil
local Foundation = require(GroupsParent.Foundation)
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local FullscreenPageWithSafeArea = require(GroupsParent.AppBlox).FullscreenPageWithSafeArea
local GroupOverviewPane = if FFlagEnableGroupOverviewPane then require(Groups.Components.GroupOverviewPane) else nil
local GroupsList = require(Groups.Components.GroupsList)
local useGroupsWrapperContext = require(Groups.Contexts.useGroupsWrapperContext)
local useGroupsListData = require(Groups.Hooks).useGroupsListData

local useGroupsAnalytics = require(Groups.Hooks.useGroupsAnalytics)
local EventNames = require(Groups.Analytics.EventNames)

local function GroupsPage(_)
    local var1 = useGroupsWrapperContext()
    local var2 = useTokens()
    local var3 = useGroupsListData(var1.userId)
    local var4 = useGroupsAnalytics()
    local var5 = if FFlagEnableGroupOverviewPane then useIsCompactTouch() else false

    useEffectOnce(function()
        var4.fireAnalyticsEvent(EventNames.GroupsListPageExposure)
    end, not (var3.isLoading or var3.loadFailure))

    local element = React.createElement(GroupsList, {
        layoutOrder = 1,
        groupsList = var3.groupsList,
        canCreateGroup = var3.canCreateGroup,
        isLoading = var3.isLoading,
        loadFailure = var3.loadFailure
    })
    local element2

    if FFlagEnableGroupOverviewPane and not var5 then
        element2 = React.createElement(View, {
            testId = "GroupsPage.DesktopLayout",
            tag = "row size-full-full"
        }, {
            Sidebar = React.createElement(
                View,
                {
                    LayoutOrder = 1,
                    Size = UDim2.new(0, 327, 1, 0),
                    tag = "col padding-xlarge",
                    testId = "GroupsPage.Sidebar"
                },
                { GroupsList = element }
            ),
            Divider = React.createElement(View, {
                LayoutOrder = 2,
                Size = UDim2.new(0, 1, 1, 0),
                backgroundStyle = var2.Color.Surface.Surface_300,
                testId = "GroupsPage.Divider"
            }),
            MainPage = React.createElement(
                View,
                { LayoutOrder = 3, tag = "fill size-0-full clip", testId = "GroupsPage.Overview" },
                {
                    GroupOverviewPane = React.createElement(GroupOverviewPane, { groupId = var1.groupId, source = var1.groupOverviewPaneSource })
                }
            )
        })
    else
        element2 = React.createElement(
            View,
            {
                tag = "col size-full-full padding-x-xlarge padding-y-xxlarge",
                testId = "GroupsPage.SinglePane"
            },
            { Content = element }
        )
    end

    return React.createElement(FullscreenPageWithSafeArea, {
        includeStatusBar = true,
        BackgroundColor3 = var2.Color.Surface.Surface_0.Color3,
        BackgroundTransparency = var2.Color.Surface.Surface_0.Transparency
    }, { GroupsPageContent = element2 })
end

return GroupsPage

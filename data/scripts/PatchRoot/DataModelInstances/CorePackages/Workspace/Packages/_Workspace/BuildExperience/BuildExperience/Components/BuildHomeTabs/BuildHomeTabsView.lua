-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:21:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperience = script:FindFirstAncestor("BuildExperience")
local BuildExperienceParent = BuildExperience.Parent

local Foundation = require(BuildExperienceParent.Foundation)
local React = require(BuildExperienceParent.React)
local ReactUtils = require(BuildExperienceParent.ReactUtils)

local FFlagBuildExperienceFoundationTabs = require(BuildExperience.Flags.FFlagBuildExperienceFoundationTabs)
local FFlagSubTabSizeSmall = require(BuildExperienceParent.SharedFlags).FFlagSubTabSizeSmall

local BuildTabStrip = require(BuildExperience.Components.BuildTabStrip.BuildTabStrip)
local createBuildHomeTabStore = require(BuildExperience.Stores.GetBuildHomeTabStore.createBuildHomeTabStore)
local _useBuildHomeTabsViewModel = require(script.Parent.useBuildHomeTabsViewModel)

local View = Foundation.View

local createNextOrder = ReactUtils.createNextOrder

local BUILD_HOME_TAB = createBuildHomeTabStore.BUILD_HOME_TAB

local function isPageShown(num1: number, num2: number, bool1: boolean): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    bool1 = bool1 or math.abs(num1 - num2) < 1
    return bool1
end

local function BuildHomeTabsView(tbl1)
    local tabOrder = tbl1.tabOrder
    local pageOffset = tbl1.pageOffset

    local nextOrder = createNextOrder()

    local createElement = React.createElement
    local var1 = View
    local tbl2 = {
        LayoutOrder = tbl1.LayoutOrder,
        tag = "col fill size-full",
        testId = "BuildHomeTabs"
    }

    local tbl3 = { TabsLayout = 0, Panes = 0 }
    local var2

    if tbl1.showTabs then
        local createElement2 = React.createElement
        local var3 = View
        local tbl4 = {
            LayoutOrder = nextOrder(),
            tag = "composition-layout-detail size-full-0 auto-y"
        }

        local tbl5 = { TabsBody = 0 }
        local createElement3 = React.createElement
        local var4 = View
        local tbl6 = { tag = "composition-content-body col size-full-0 auto-y" }

        local tbl7 = { Tabs = 0 }
        local element

        if FFlagBuildExperienceFoundationTabs then
            element = React.createElement(Foundation.Tabs, {
                activeTabId = tbl1.activeTab,
                onActivated = tbl1.onTabActivated,
                tabs = tbl1.tabs,
                size = if FFlagSubTabSizeSmall then Foundation.Enums.InputSize.Small else Foundation.Enums.InputSize.Medium,
                fillBehavior = tbl1.tabsFillBehavior,
                testId = "BuildHomeTabs.Tabs"
            })
        else
            element = React.createElement(BuildTabStrip, {
                activeTabId = tbl1.activeTab,
                activeOffset = pageOffset,
                onActivated = tbl1.onTabActivated,
                tabs = tbl1.tabs,
                testId = "BuildHomeTabs.Tabs"
            })
        end

        tbl7.Tabs = element
        tbl5.TabsBody = createElement3(var4, tbl6, tbl7)
        var2 = createElement2(var3, tbl4, tbl5)
    else
        var2 = nil
    end

    tbl3.TabsLayout = var2

    tbl3.Panes = React.createElement(
        View,
        {
            LayoutOrder = nextOrder(),
            tag = "fill size-full clip",
            testId = "BuildHomeTabs.Panes"
        },
        {
            GamesPage = React.createElement(View, {
                Position = pageOffset:map(function(num1: number): UDim2
                    return UDim2.fromScale(tabOrder[BUILD_HOME_TAB.Games] - num1, 0)
                end),
                tag = "size-full",
                testId = "BuildHomeTabs.GamesPage"
            }, {
                Content = React.createElement(View, {
                    Visible = pageOffset:map(function(num1: number): boolean
                        return (isPageShown(tabOrder[BUILD_HOME_TAB.Games], num1, tbl1.activeTab == BUILD_HOME_TAB.Games))
                    end),
                    tag = "size-full",
                    testId = "BuildHomeTabs.GamesContent"
                }, {
                    Content = tbl1.gamesContent
                })
            }),
            PreviewsPage = React.createElement(View, {
                Position = pageOffset:map(function(num1: number): UDim2
                    return UDim2.fromScale(tabOrder[BUILD_HOME_TAB.Previews] - num1, 0)
                end),
                tag = "size-full",
                testId = "BuildHomeTabs.PreviewsPage"
            }, {
                Content = React.createElement(View, {
                    Visible = pageOffset:map(function(num1: number): boolean
                        return (isPageShown(tabOrder[BUILD_HOME_TAB.Previews], num1, tbl1.activeTab == BUILD_HOME_TAB.Previews))
                    end),
                    tag = "size-full",
                    testId = "BuildHomeTabs.PreviewsContent"
                }, {
                    Content = tbl1.previewsContent
                })
            })
        }
    )

    return createElement(var1, tbl2, tbl3)
end

return BuildHomeTabsView

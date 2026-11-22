-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:10:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local React = require(SocialTabsPageParent.React)
local RoactNavigation = require(SocialTabsPageParent.RoactNavigation)
local useNavigationProps = require(SocialTabsPageParent.RobloxAppNavigation).useNavigationProps

local SocialTabsPage2 = require(SocialTabsPage.Components.SocialTabsPage)
local SocialTabsPageRouter = require(script.Parent.SocialTabsPageRouter)

local useProfileDockedPanelWidth = require(SocialTabsPageParent.ProfilePlatformCommon).Hooks.useProfileDockedPanelWidth
local useIsProfileSplitDetail = require(SocialTabsPageParent.ProfilePlatformCommon).Hooks.useIsProfileSplitDetail
local useStatusBarHeight = require(SocialTabsPageParent.RobloxAppHooks).useStatusBarHeight
local FFlagSocialTabsPageSplitPaneLayout = require(SocialTabsPageParent.SharedFlags).FFlagSocialTabsPageSplitPaneLayout

local robloxSwitchNavigator = RoactNavigation.createRobloxSwitchNavigator(
    SocialTabsPageRouter,
    {
        resetOnBlur = false,
        keepVisitedScreensMounted = true,
        backBehavior = RoactNavigation.BackBehavior.None
    }
)

local function SocialTabsPageNavigatorComponent(tbl1)
    local navigation = tbl1.navigation

    local var1 = useNavigationProps(function(_, arg1)
        return {
            profileId = arg1.profileId,
            title = arg1.title,
            initialTabId = arg1.initialTabId,
            tabConfig = arg1.tabConfig,
            dockToProfilePanel = arg1.dockToProfilePanel
        }
    end)

    local pageWidth = useProfileDockedPanelWidth(var1.dockToProfilePanel)
    local var3 = if FFlagSocialTabsPageSplitPaneLayout then useIsProfileSplitDetail() else false
    local var4 = if FFlagSocialTabsPageSplitPaneLayout then useStatusBarHeight() else 0

    local renderNavigator = React.useCallback(function()
        return React.createElement(robloxSwitchNavigator, { navigation = navigation })
    end, { navigation })

    local createElement = React.createElement
    local var6 = SocialTabsPage2
    local tbl2 = {
        renderNavigator = renderNavigator,
        tabConfig = var1.tabConfig,
        profileId = var1.profileId,
        title = var1.title,
        initialTabId = var1.initialTabId,
        pageWidth = pageWidth,
        fillContainer = if FFlagSocialTabsPageSplitPaneLayout and var3 then true else nil,
        topInset = 0,
        hideBackButton = 0
    }

    if not (FFlagSocialTabsPageSplitPaneLayout and var3) then
        var4 = nil
    end

    tbl2.topInset = var4
    tbl2.hideBackButton = if FFlagSocialTabsPageSplitPaneLayout and var3 then true else nil
    return createElement(var6, tbl2)
end

local var1 = React.PureComponent:extend("SocialTabsPageNavigatorClassWrapper")

function var1.render(arg1)
    return React.createElement(SocialTabsPageNavigatorComponent, arg1.props)
end

var1.router = robloxSwitchNavigator.router

return var1

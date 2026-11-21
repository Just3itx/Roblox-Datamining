-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local FriendsLandingParent = FriendsLanding.Parent

local dependencies = require(FriendsLanding.dependencies)
local SocialLibraries = dependencies.SocialLibraries
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)
local EnumScreens = require(FriendsLanding.EnumScreens)
local FriendsLandingAnalytics = require(FriendsLanding.FriendsLandingAnalytics)
local AddFriendsIcon = require(FriendsLanding.Components.AddFriendsIcon)
local memoize = dependencies.memoize
local IconButton = UIBlox.App.Button.IconButton
local Images = UIBlox.App.ImageSet.Images
local ButtonClickEvents = require(FriendsLanding.FriendsLandingAnalytics.ButtonClickEvents)
local compose = SocialLibraries.RoduxTools.compose
local Sources = require(FriendsLandingParent.SocialLuaAnalytics).Analytics.Enums.Sources

local AppPage = require(FriendsLandingParent.RobloxAppEnums).AppPage

local FFlagConnectionManagementChips = require(FriendsLandingParent.SharedFlags).FFlagConnectionManagementChips

local function func1(tbl1: {goToSearchFriendsPage: any, layoutOrder: number})
    return Roact.createElement(IconButton, {
        size = UDim2.fromOffset(0, 0),
        icon = Images["icons/common/search"],
        layoutOrder = tbl1.layoutOrder,
        onActivated = tbl1.goToSearchFriendsPage
    })
end

local tbl1 = {
    SHOW_ADDFRIENDS_ICON = {
        [EnumScreens.FriendsLanding] = true,
        [EnumScreens.SearchFriends] = true
    },
    SHOW_SEARCHFRIENDS_ICON = {
        [EnumScreens.FriendsLanding] = true,
        [EnumScreens.SearchFriends] = true,
        [EnumScreens.AddFriends] = true
    }
}

local var1 = Roact.PureComponent:extend("HeaderBarRightView")

var1.defaultProps = { layoutOrder = 1, onActivated = nil }

function var1.init(arg1)
    arg1.goToFriendRequestsPage = memoize(function(_, arg2)
        return function()
            local var2 = arg2 == 0 and ButtonClickEvents.AddFriendsNoFriends or ButtonClickEvents.AddFriends
            arg1.props.analytics:buttonClick(var2)
            arg1.props.analytics:navigate(EnumScreens.AddFriends)

            return arg1.props.navigation.navigate(AppPage.AddFriendsPage)
        end
    end)

    arg1.goToSearchFriendsPage = memoize(function()
        return function()
            arg1.props.navigation.navigate(
                AppPage.UserSearch,
                {
                    shouldShowUserSearchLandingPage = true,
                    entryPoint = Sources.FriendsLanding
                }
            )
        end
    end)
end

function var1.render(arg1)
    local navigation = arg1.props.navigation
    local var2 = nil
    local element = nil

    if arg1.props.addFriendsPageSearchbarEnabled then
        tbl1.SHOW_ADDFRIENDS_ICON[EnumScreens.SearchFriends] = false
    end

    if navigation and navigation.state then
        local routeName = navigation.state.routeName
        var2 = tbl1.SHOW_SEARCHFRIENDS_ICON[routeName]
        element = tbl1.SHOW_ADDFRIENDS_ICON[routeName]
    end

    local createElement = Roact.createElement
    local str1 = "Frame"
    local tbl2 = {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 72, 0, 36)
    }
    local tbl3 = {
        UIListLayout = Roact.createElement("UIListLayout", {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            SortOrder = Enum.SortOrder.LayoutOrder
        }),
        SearchFriendsIcon = var2 and func1({ goToSearchFriendsPage = arg1.goToSearchFriendsPage(), layoutOrder = 1 }),
        Padding = Roact.createElement("Frame", { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, LayoutOrder = 2 }),
        AddFriendsIcon = 0
    }

    element = element
        and Roact.createElement(AddFriendsIcon, {
            onActivated = arg1.goToFriendRequestsPage(arg1.props.navigateToLuaAppPages, arg1.props.totalFriendCount),
            layoutOrder = 3,
            friendRequestCount = arg1.props.friendRequestCount,
            showTooltip = not FFlagConnectionManagementChips and arg1.props.totalFriendCount == 0
        })
    tbl3.AddFriendsIcon = element
    return createElement(str1, tbl2, tbl3)
end

return compose(FriendsLandingAnalytics.connect(function(analytics)
    return { analytics = analytics }
end), FriendsLandingContext.connect(function(arg1, _)
    return {
        navigateToLuaAppPages = arg1.navigateToLuaAppPages,
        friendRequestCount = arg1.friendRequestCount,
        totalFriendCount = arg1.totalFriendCount,
        luaAddFriendsPageEnabled = arg1.luaAddFriendsPageEnabled,
        addFriendsPageSearchbarEnabled = arg1.addFriendsPageSearchbarEnabled
    }
end))(var1)

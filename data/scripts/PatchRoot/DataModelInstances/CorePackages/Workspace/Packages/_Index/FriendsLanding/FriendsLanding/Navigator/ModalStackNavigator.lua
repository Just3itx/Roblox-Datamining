-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local _FriendsLandingParent = FriendsLanding.Parent

local RoactNavigation = dependencies.RoactNavigation
local EnumScreens = require(FriendsLanding.EnumScreens)
local MainStackNavigatorConnector = require(FriendsLanding.Navigator.MainStackNavigatorConnector)
local FriendsLandingFilter = require(FriendsLanding.Components.FriendsLandingFilter)
local FriendsLandingContextualMenu = require(FriendsLanding.Components.FriendsLandingContextualMenu)
local DiscoverabilityOverlay = dependencies.DiscoverabilityOverlay
local Roact = dependencies.Roact
local _React = require(FriendsLanding.Parent.React)
local FriendsLandingContext = require(FriendsLanding.FriendsLandingContext)
local ProfileQRCodePageWrapper = require(FriendsLanding.Navigator.ProfileQRCodePageWrapper)

Roact.PureComponent:extend("DiscoverabilityWrapped").render = function(arg1)
    return FriendsLandingContext.with(function(context)
        return Roact.createElement(DiscoverabilityOverlay, { navigation = arg1.props.navigation, context = context })
    end)
end

local tbl1 = {
    {
        MainStackNavigator = {
            screen = MainStackNavigatorConnector,
            navigationOptions = { overlayTransparency = 1 }
        }
    },
    {
        [EnumScreens.FilterByModal] = { screen = FriendsLandingFilter }
    },
    {
        [EnumScreens.ContextualMenu] = FriendsLandingContextualMenu
    },
    {
        [EnumScreens.ProfileQRCodePage] = ProfileQRCodePageWrapper
    }
}

return (RoactNavigation.createRobloxStackNavigator(tbl1, {
    defaultNavigationOptions = {
        overlayEnabled = true,
        absorbInput = true,
        absorbInputSelectable = false
    },
    mode = RoactNavigation.StackPresentationStyle.Overlay
}))

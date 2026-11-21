-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local _FriendsLandingParent = FriendsLanding.Parent
local dependencies = require(FriendsLanding.dependencies)

local UserGameSettings = UserSettings():GetService("UserGameSettings")
local RoactNavigation = dependencies.RoactNavigation
local FriendsLandingScreen = require(FriendsLanding.Components.FriendsLandingScreen)

local NavigationOptions = require(FriendsLanding.Components.FriendsLandingScreen.NavigationOptions)
local EnumScreens = require(FriendsLanding.EnumScreens)

local createRobloxStackNavigator = RoactNavigation.createRobloxStackNavigator
local tbl1 = {{
    [EnumScreens.FriendsLanding] = {
        screen = FriendsLandingScreen,
        navigationOptions = NavigationOptions
    }
}}

return (createRobloxStackNavigator(tbl1, {
    transitionConfig = function() -- name: getTransitionConfig
        return if UserGameSettings.ReducedMotion then RoactNavigation.StackViewTransitionConfigs.FadeInPlace else RoactNavigation.StackViewTransitionConfigs.SlideFromRight
    end
}))

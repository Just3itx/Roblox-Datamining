-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")

local dependencies = require(FriendsLanding.dependencies)
local RoactNavigation = dependencies.RoactNavigation
local EnumScreens = require(FriendsLanding.EnumScreens)
local ModalStackNavigator = require(FriendsLanding.Navigator.ModalStackNavigator)
local ToastScreen = dependencies.SocialLibraries.Components.ToastScreen

return (RoactNavigation.createRobloxStackNavigator({
    {
        ModalStackNavigator = {
            screen = ModalStackNavigator,
            navigationOptions = { transparent = true, absorbInputSelectable = false }
        }
    },
    {
        [EnumScreens.GenericToast] = {
            screen = ToastScreen,
            navigationOptions = {
                overlayEnabled = true,
                overlayTransparency = 1,
                absorbInput = false
            }
        }
    }
}, {
    mode = RoactNavigation.StackPresentationStyle.Overlay
}))

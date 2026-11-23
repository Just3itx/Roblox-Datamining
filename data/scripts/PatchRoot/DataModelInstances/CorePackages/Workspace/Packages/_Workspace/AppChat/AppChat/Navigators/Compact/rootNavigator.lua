-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Roact = require(AppChatParent.Roact)
local RoactNavigation = require(AppChatParent.RoactNavigation)

local EnumScreens = require(AppChat.EnumScreens)
local ToastScreen = require(AppChat.Components.Toast.ToastScreen)

local FFlagAppChatDisableAbsorbInputSelectable = require(AppChat.Flags.FFlagAppChatDisableAbsorbInputSelectable)

local chatLandingWithDialogsNavigator = require(script.Parent.chatLandingWithDialogsNavigator)

local ChatLandingWithDialogs = Roact.Component:extend("ChatLandingWithDialogsNavigatorConnector")
ChatLandingWithDialogs.router = chatLandingWithDialogsNavigator.router

function ChatLandingWithDialogs.render(arg1)
    return Roact.createElement(chatLandingWithDialogsNavigator, arg1.props)
end

return RoactNavigation.createRobloxStackNavigator({
    { ChatLandingWithDialogs = ChatLandingWithDialogs },
    {
        [EnumScreens.RoactChatToast] = {
            screen = ToastScreen,
            navigationOptions = {
                overlayEnabled = true,
                overlayTransparency = 1,
                absorbInput = false
            }
        }
    }
}, {
    defaultNavigationOptions = FFlagAppChatDisableAbsorbInputSelectable and {
        absorbInputSelectable = false
    } or nil,
    mode = RoactNavigation.StackPresentationStyle.Overlay
})

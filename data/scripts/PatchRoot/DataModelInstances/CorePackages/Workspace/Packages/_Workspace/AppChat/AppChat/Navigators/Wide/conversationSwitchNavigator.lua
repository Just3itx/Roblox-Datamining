-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local RoactNavigation = require(AppChatParent.RoactNavigation)

local EnumScreens = require(AppChat.EnumScreens)
local EmptyConversationScreen = require(AppChat.Components.ChatConversation.EmptyConversationScreen)

local ConversationStackNavigatorConnector = require(script.Parent.ConversationStackNavigatorConnector)

return (RoactNavigation.createRobloxSwitchNavigator({
    {
        [EnumScreens.EmptyConversation] = {
            screen = EmptyConversationScreen,
            navigationOptions = {
                headerText = { raw = "testing", shouldLocalize = false },
                backButtonEnabled = false,
                isRoot = true,
                tabBarVisible = true
            }
        }
    },
    { ConversationStackNavigator = ConversationStackNavigatorConnector }
}))

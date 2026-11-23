-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local RoactNavigation = require(AppChatParent.RoactNavigation)
local Cryo = require(AppChatParent.Cryo)

local autoFocusNavigation = require(script.Parent.Parent.autoFocusNavigation)

local EnumScreens = require(AppChat.EnumScreens)
local ChatConversationScreen = require(AppChat.Components.ChatConversation.ChatConversationScreen)
local ChatDetailsScreen = require(AppChat.Components.ChatDetails.ChatDetailsScreen)
local SquadInviteFriendsScreen = require(AppChat.Components.Squads.SquadInviteFriendsScreen)
local SquadLobbyScreen = require(AppChat.Components.Squads.SquadLobbyScreen)

local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled
local FFlagAppChatDisableAbsorbInputSelectable = require(AppChat.Flags.FFlagAppChatDisableAbsorbInputSelectable)

local function instantTransitionConfig()
    return {
        transitionSpec = { frequency = 1000000, dampingRatio = 1 }
    }
end

return function(navigationOptions, bool1: boolean?)
    local tbl1 = {
        {
            [EnumScreens.ChatConversation] = {
                screen = ChatConversationScreen,
                navigationOptions = Cryo.Dictionary.join(
                    {
                        backButtonEnabled = false,
                        isRoot = true,
                        lockIconEnabled = true,
                        tabBarVisible = true
                    },
                    navigationOptions or {}
                )
            }
        },
        {
            [EnumScreens.ChatDetails] = {
                screen = autoFocusNavigation(ChatDetailsScreen),
                navigationOptions = navigationOptions or {}
            }
        }
    }

    if GetFFlagIsSquadEnabled() then
        table.insert(tbl1, {
            [EnumScreens.SquadLobby] = {
                screen = autoFocusNavigation(SquadLobbyScreen.WideSquadLobbyScreen),
                navigationOptions = navigationOptions or {}
            }
        })

        table.insert(tbl1, {
            [EnumScreens.SquadInviteFriends] = {
                screen = autoFocusNavigation(SquadInviteFriendsScreen),
                navigationOptions = navigationOptions or {}
            }
        })
    end

    local defaultNavigationOptions = { tabBarVisible = true }

    if FFlagAppChatDisableAbsorbInputSelectable then
        defaultNavigationOptions.absorbInputSelectable = false
    end

    return RoactNavigation.createRobloxStackNavigator(tbl1, {
        defaultNavigationOptions = defaultNavigationOptions,
        transitionConfig = if bool1 then instantTransitionConfig else nil
    })
end

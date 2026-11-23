-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local SquadQuickStartExperimentation = require(AppChatParent.SocialExperiments).SquadQuickStartExperimentation

local EnumScreens = require(AppChat.EnumScreens)
local ChatLandingScreen = require(AppChat.Components.ChatLanding.ChatLandingScreen)
local ChatConversationScreen = require(AppChat.Components.ChatConversation.ChatConversationScreen)
local ChatDetailsScreen = require(AppChat.Components.ChatDetails.ChatDetailsScreen)
local ChatDetailsNavigationOptions = require(AppChat.Components.ChatDetails.ChatDetailsNavigationOptions)
local CreateNewChatScreen = require(AppChat.Components.CreateNewChat.CreateNewChatScreen)
local EditChatMembersScreen = require(AppChat.Components.EditChatMembers.EditChatMembersScreen)
local SquadInviteFriendsScreen = require(AppChat.Components.Squads.SquadInviteFriendsScreen)
local SquadLobbyScreen = require(AppChat.Components.Squads.SquadLobbyScreen)
local QuickStartSquadInviteFriendsScreen = require(AppChat.Components.Squads.QuickStartSquadInviteFriendsScreen)
local GetFFlagIsSquadEnabled = require(AppChatParent.SharedFlags).GetFFlagIsSquadEnabled
local getFFlagAppChatRemoveDynamicRequires = require(AppChat.Flags.getFFlagAppChatRemoveDynamicRequires)
local FFlagEnablePartyQuickStartButton = require(AppChatParent.SharedFlags).FFlagEnablePartyQuickStartButton

local tbl1 = {
    [EnumScreens.ChatLanding] = {
        screen = ChatLandingScreen,
        navigationOptions = getFFlagAppChatRemoveDynamicRequires() and function()
            return { isRoot = true, backButtonEnabled = false, tabBarVisible = true }
        end or { isRoot = true, backButtonEnabled = false, tabBarVisible = true }
    }
}

local tbl2 = {
    [EnumScreens.ChatConversation] = {
        screen = ChatConversationScreen,
        navigationOptions = {
            backButtonEnabled = true,
            tabBarVisible = false,
            lockIconEnabled = true,
            absorbInput = false
        }
    }
}

local tbl3 = {
    [EnumScreens.ChatDetails] = {
        screen = ChatDetailsScreen,
        navigationOptions = function(arg1) -- name: getChatDetailsNavigationOptions
            return ChatDetailsNavigationOptions.getNavigationOptions(arg1, { tabBarVisible = false })
        end
    }
}

local tbl4 = {
    tbl1,
    tbl2,
    tbl3,
    {
        [EnumScreens.CreateNewChat] = {
            screen = CreateNewChatScreen,
            navigationOptions = { backButtonEnabled = true, tabBarVisible = false }
        }
    },
    {
        [EnumScreens.EditChatMembers] = {
            screen = EditChatMembersScreen,
            navigationOptions = { backButtonEnabled = true, tabBarVisible = false }
        }
    }
}

if GetFFlagIsSquadEnabled() then
    table.insert(tbl4, {
        [EnumScreens.SquadLobby] = {
            screen = SquadLobbyScreen.CompactSquadLobbyScreen,
            navigationOptions = { backButtonEnabled = true, tabBarVisible = false }
        }
    })

    if SquadQuickStartExperimentation.getPartyQuickStartChangesEnabled() and FFlagEnablePartyQuickStartButton then
        table.insert(tbl4, {
            [EnumScreens.QuickStartSquadInviteFriends] = {
                screen = QuickStartSquadInviteFriendsScreen,
                navigationOptions = { backButtonEnabled = true, tabBarVisible = false }
            }
        })
    end

    table.insert(tbl4, {
        [EnumScreens.SquadInviteFriends] = {
            screen = SquadInviteFriendsScreen,
            navigationOptions = {
                backButtonEnabled = true,
                tabBarVisible = false,
                headerText = FFlagEnablePartyQuickStartButton and {
                    raw = "Feature.Squads.Action.Add",
                    shouldLocalize = true
                } or nil
            }
        }
    })
end

return tbl4

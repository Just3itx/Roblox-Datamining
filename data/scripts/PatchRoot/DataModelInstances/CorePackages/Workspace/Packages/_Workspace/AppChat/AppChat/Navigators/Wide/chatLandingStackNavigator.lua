-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local RoactNavigation = require(AppChatParent.RoactNavigation)
local SquadQuickStartExperimentation = require(AppChatParent.SocialExperiments).SquadQuickStartExperimentation

local EnumScreens = require(AppChat.EnumScreens)

local ChatLandingScreenWithSwitchNavigator = require(AppChat.Components.ChatLanding.ChatLandingScreenWithSwitchNavigator)
local CreateNewChatScreen = require(AppChat.Components.CreateNewChat.CreateNewChatScreen)
local EditChatMembersScreen = require(AppChat.Components.EditChatMembers.EditChatMembersScreen)
local QuickStartSquadInviteFriendsScreen = require(AppChat.Components.Squads.QuickStartSquadInviteFriendsScreen)

local createOverlayTopBarStackNavigatorWithFocus = require(AppChat.Navigators.createOverlayTopBarStackNavigatorWithFocus)
local getFFlagAppChatRemoveDynamicRequires = require(AppChat.Flags.getFFlagAppChatRemoveDynamicRequires)
local FFlagEnablePartyQuickStartButton = require(AppChatParent.SharedFlags).FFlagEnablePartyQuickStartButton
local FFlagAppChatDisableAbsorbInputSelectable = require(AppChat.Flags.FFlagAppChatDisableAbsorbInputSelectable)

local function wrapScreenInOverlayNavigator(arg1, arg2) -- Luacid: unused: defined but never referenced
    return createOverlayTopBarStackNavigatorWithFocus({{ [arg1] = arg2 }})
end

local navigationOptions = {
    backButtonEnabled = true,
    tabBarVisible = true,
    overlayEnabled = true,
    overlayTransparency = 0.5,
    absorbInput = true
}

local tbl2 = {
    [EnumScreens.ChatLanding] = {
        screen = ChatLandingScreenWithSwitchNavigator,
        navigationOptions = getFFlagAppChatRemoveDynamicRequires() and function()
            return { backButtonEnabled = false, tabBarVisible = true }
        end or { backButtonEnabled = false, tabBarVisible = true }
    }
}

local tbl3 = { CreateNewChatScreenWrapper = 0 }
local CreateNewChatScreenWrapper = { screen = 0, navigationOptions = 0 }
local tbl5 = {{
    [EnumScreens.CreateNewChat] = CreateNewChatScreen
}}
CreateNewChatScreenWrapper.screen = createOverlayTopBarStackNavigatorWithFocus(tbl5)
CreateNewChatScreenWrapper.navigationOptions = navigationOptions
tbl3.CreateNewChatScreenWrapper = CreateNewChatScreenWrapper

local tbl6 = { EditChatMembersScreenWrapper = 0 }
local EditChatMembersScreenWrapper = { screen = 0, navigationOptions = 0 }
local tbl8 = {{
    [EnumScreens.EditChatMembers] = EditChatMembersScreen
}}
EditChatMembersScreenWrapper.screen = createOverlayTopBarStackNavigatorWithFocus(tbl8)
EditChatMembersScreenWrapper.navigationOptions = navigationOptions
tbl6.EditChatMembersScreenWrapper = EditChatMembersScreenWrapper
local tbl9 = { tbl2, tbl3, tbl6 }

if SquadQuickStartExperimentation.getPartyQuickStartChangesEnabled() and FFlagEnablePartyQuickStartButton then
    local tbl10 = { CreatePartyQuickStartWrapper = 0 }
    local createPartyQuickStartWrapper = { screen = 0, navigationOptions = 0 }
    local tbl12 = {{
        [EnumScreens.QuickStartSquadInviteFriends] = QuickStartSquadInviteFriendsScreen
    }}
    createPartyQuickStartWrapper.screen = createOverlayTopBarStackNavigatorWithFocus(tbl12)

    createPartyQuickStartWrapper.navigationOptions = navigationOptions
    tbl10.CreatePartyQuickStartWrapper = createPartyQuickStartWrapper
    table.insert(tbl9, tbl10)
end

return RoactNavigation.createRobloxStackNavigator(tbl9, {
    defaultNavigationOptions = FFlagAppChatDisableAbsorbInputSelectable and {
        absorbInputSelectable = false
    } or nil,
    mode = RoactNavigation.StackPresentationStyle.Overlay
})

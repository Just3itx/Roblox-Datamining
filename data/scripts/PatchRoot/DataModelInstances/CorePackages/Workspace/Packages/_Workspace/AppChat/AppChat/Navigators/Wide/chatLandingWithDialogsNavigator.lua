-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Roact = require(AppChatParent.Roact)
local RoactNavigation = require(AppChatParent.RoactNavigation)
local EnumScreens = require(AppChat.EnumScreens)
local SharedFlags = require(AppChatParent.SharedFlags)

local ChatDetails = AppChat.Components.ChatDetails
local GenericDialogType = require(ChatDetails.Dialogs.GenericDialogType)
local EditChatGroupNameDialogScreen = require(ChatDetails.EditChatGroupNameDialog.EditChatGroupNameDialogScreen)
local LeaveGroupDialogScreen = require(ChatDetails.LeaveGroupDialog.LeaveGroupDialogScreen)
local ParticipantDialogScreenDeprecated = require(ChatDetails.ParticipantDialog.ParticipantDialogScreenDeprecated)
local RemoveUserDialogScreen = require(ChatDetails.RemoveUserDialog.RemoveUserDialogScreen)
local AbuseReportScreen = require(AppChat.Components.ChatAbuseReport.AbuseReportScreen)
local FFlagAppChatDisableAbsorbInputSelectable = require(AppChat.Flags.FFlagAppChatDisableAbsorbInputSelectable)

local MessageContextMenuScreen = require(AppChat.Components.ChatConversation.MessageInteraction.MessageContextMenuScreen)
local SquadVoiceChangerOverlay = require(AppChatParent.Squads.SquadVoiceChangerOverlay)
local FocusNavigableSurfaceIdentifierEnum = require(AppChatParent.FocusNavigationUtils).FocusNavigableSurfaceIdentifierEnum

local ChatConversation = AppChat.Components.ChatConversation

local CreateUnfilteredChatPartialModalScreen = require(ChatConversation.PartialModal.CreateUnfilteredChatPartialModalScreen)
local LearnMorePartialModalScreen = require(ChatConversation.PartialModal.LearnMorePartialModalScreen)
local SquadVoiceAbuseReportScreen = require(AppChatParent.Squads.SquadVoiceAbuseReportScreen)
local ConversationOverlayScreen = require(ChatConversation.PartialModal.ConversationOverlayScreen)
local TrustedFriendsUpsellScreen = require(AppChat.Components.TrustedFriendsUpsell.TrustedFriendsUpsellScreen)
local GroupOSADialogScreen = require(AppChat.Components.OSA.GroupOSADialogScreen)
local makeDialogScreenTelemetryWrapper = require(AppChat.Navigators.makeDialogScreenTelemetryWrapper)
local isolatedAutoFocusNavigation = require(AppChat.Navigators.isolatedAutoFocusNavigation)

local BlockingModal = require(AppChatParent.SocialBlockingModal).BlockingModal

local GetFFlagEnableCrossExpVoice = SharedFlags.GetFFlagEnableCrossExpVoice
local GetFFlagIsSquadEnabled = SharedFlags.GetFFlagIsSquadEnabled
local FFlagEnablePartyVoiceChangersInLua = SharedFlags.FFlagEnablePartyVoiceChangersInLua
local chatLandingStackNavigator = require(script.Parent.chatLandingStackNavigator)
local FFlagAppChatConsoleFocusFixes = require(AppChat.Flags.FFlagAppChatConsoleFocusFixes)

local var1 = Roact.Component:extend("ChatLandingStackNavigatorConnector")
var1.router = chatLandingStackNavigator.router

function var1.render(arg1)
    return Roact.createElement(
        "Frame",
        {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ClipsDescendants = not FFlagAppChatConsoleFocusFixes or nil
        },
        {
            ChatLandingStackNavigator = Roact.createElement(chatLandingStackNavigator, arg1.props)
        }
    )
end
local tbl1 = {
    {
        [EnumScreens.ChatLandingStack] = var1
    },
    {
        [GenericDialogType.EditChatGroupNameDialog] = {
            screen = isolatedAutoFocusNavigation(EditChatGroupNameDialogScreen, FocusNavigableSurfaceIdentifierEnum.PopUp),
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    },
    {
        [GenericDialogType.LeaveGroupDialog] = {
            screen = isolatedAutoFocusNavigation(
                makeDialogScreenTelemetryWrapper(LeaveGroupDialogScreen),
                FocusNavigableSurfaceIdentifierEnum.PopUp
            ),
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    },
    {
        [GenericDialogType.ParticipantDialog] = {
            screen = isolatedAutoFocusNavigation(
                makeDialogScreenTelemetryWrapper(ParticipantDialogScreenDeprecated),
                FocusNavigableSurfaceIdentifierEnum.PopUp
            ),
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    },
    {
        [GenericDialogType.RemoveUserDialog] = {
            screen = isolatedAutoFocusNavigation(RemoveUserDialogScreen, FocusNavigableSurfaceIdentifierEnum.PopUp),
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    },
    {
        [EnumScreens.CreateUnfilteredChatPartialModal] = {
            screen = isolatedAutoFocusNavigation(CreateUnfilteredChatPartialModalScreen, FocusNavigableSurfaceIdentifierEnum.PopUp),
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    },
    {
        [EnumScreens.LearnMorePartialModal] = {
            screen = isolatedAutoFocusNavigation(LearnMorePartialModalScreen, FocusNavigableSurfaceIdentifierEnum.PopUp),
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    }
}

table.insert(tbl1, {
    [EnumScreens.AppChatReportAbuse] = {
        screen = isolatedAutoFocusNavigation(AbuseReportScreen, FocusNavigableSurfaceIdentifierEnum.PopUp),
        navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
    }
})

table.insert(tbl1, {
    [EnumScreens.BlockingModal] = {
        screen = isolatedAutoFocusNavigation(BlockingModal, FocusNavigableSurfaceIdentifierEnum.PopUp),
        navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
    }
})

table.insert(tbl1, {
    [EnumScreens.MessageContextMenu] = {
        screen = isolatedAutoFocusNavigation(MessageContextMenuScreen, FocusNavigableSurfaceIdentifierEnum.ContextualMenu),
        navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
    }
})

if GetFFlagIsSquadEnabled() and GetFFlagEnableCrossExpVoice() then
    table.insert(tbl1, {
        [EnumScreens.SquadVoiceReportAbuse] = {
            screen = isolatedAutoFocusNavigation(SquadVoiceAbuseReportScreen, FocusNavigableSurfaceIdentifierEnum.PopUp),
            navigationOptions = { backButtonEnabled = true, overlayEnabled = true }
        }
    })
end

table.insert(tbl1, {
    [EnumScreens.ConversationOverlay] = {
        screen = isolatedAutoFocusNavigation(ConversationOverlayScreen, FocusNavigableSurfaceIdentifierEnum.PopUp),
        navigationOptions = { overlayEnabled = true, transparent = true, overlayTransparency = 0.5 }
    }
})

table.insert(tbl1, {
    [EnumScreens.TrustedConnectionsUpsell] = {
        screen = isolatedAutoFocusNavigation(TrustedFriendsUpsellScreen, FocusNavigableSurfaceIdentifierEnum.PopUp),
        navigationOptions = { transparent = true, overlayTransparency = 0.5, overlayEnabled = true }
    }
})

table.insert(tbl1, {
    [EnumScreens.GroupOSADialog] = {
        screen = GroupOSADialogScreen,
        navigationOptions = { transparent = true, overlayTransparency = 0.5, overlayEnabled = true }
    }
})

if FFlagEnablePartyVoiceChangersInLua then
    table.insert(tbl1, {
        [EnumScreens.SquadVoiceChangers] = {
            screen = isolatedAutoFocusNavigation(SquadVoiceChangerOverlay, FocusNavigableSurfaceIdentifierEnum.PopUp),
            navigationOptions = { overlayEnabled = true, overlayTransparency = 0.5 }
        }
    })
end

return RoactNavigation.createRobloxStackNavigator(tbl1, {
    defaultNavigationOptions = FFlagAppChatDisableAbsorbInputSelectable and {
        absorbInputSelectable = false
    } or nil,
    mode = RoactNavigation.StackPresentationStyle.Overlay
})

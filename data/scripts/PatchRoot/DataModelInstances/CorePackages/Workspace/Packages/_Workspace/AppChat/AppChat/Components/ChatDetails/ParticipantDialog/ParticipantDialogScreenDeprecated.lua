-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local EnumScreens = require(AppChat.EnumScreens)
local React = require(AppChatParent.React)
local RoactRodux = require(AppChatParent.RoactRodux)
local SocialCommon = require(AppChatParent.SocialCommon)

local GenericDialogType = require(script.Parent.Parent.Dialogs.GenericDialogType)
local Logger = require(script.Parent.Logger)
local ParticipantDialogContainerDeprecated = require(script.Parent.ParticipantDialogContainerDeprecated)
local connectAnalytics = require(AppChat.LegacyAnalytics.connectAnalytics)
local RoactChatAnalytics = require(AppChat.LegacyAnalytics.RoactChatAnalytics)
local createConversation = require(AppChat.Conversations.Thunks.createConversation)
local parseCreateConversationErrors = require(AppChat.Conversations.Thunks.parseCreateConversationErrors)
local ChatEntryPointNames = SocialCommon.Enums.ChatEntryPointNames
local EnteredChatFromEntryPoint = require(AppChat.Actions).EnteredChatFromEntryPoint

local FFlagDisableBlockAndReport = require(AppChatParent.SharedFlags).FFlagDisableBlockAndReport

local var1 = React.PureComponent:extend("ParticipantDialogScreenDeprecated")

var1.defaultProps = { navigation = nil }

function var1.init(arg1)
    function arg1.onDismiss()
        arg1.props.navigation.goBack()
    end
    function arg1.openRemoveUserDialog(participantId, conversationId)
        Logger:info("User activated removeFromGroup | userId: {}, conversationId: {}", participantId, conversationId)
        arg1.props.navigation.replace(
            GenericDialogType.RemoveUserDialog,
            { conversationId = conversationId, participantId = participantId }
        )
    end

    function arg1.openViewProfile(arg2)
        local var2 = arg1.props.navigation.getScreenProps("navigateToLuaAppPages", {})[EnumScreens.ViewUserProfile]
        if not var2 then
            Logger:warning("UserProfile page was not set in navigateToLuaAppPages screenProps")

            return
        end

        Logger:info("Navigate To UserProfile from {screen}")
        arg1.props.analytics:navigate(RoactChatAnalytics.NavigationEvents.ChatDetailsProfile)
        var2(arg2, {})
    end
    function arg1.openChat(arg2)
        Logger:info("User activated openChat | userId: {}", arg2)
        arg1.props.dispatch(EnteredChatFromEntryPoint(ChatEntryPointNames.ChatDetailsParticipantDialog))
        arg1.props.navigation.goBack()
        arg1.props.dispatch(createConversation("one_to_one", { tostring(arg2) })):andThen(function(arg3)
            arg1.props.navigation.navigate(EnumScreens.ChatConversation, { conversationId = arg3.id })
        end):catch(function(arg3)
            Logger:warning("Error creating 1:1 conversation for userId {}: {}", arg2, tostring(arg3))
            local toastTitle = if parseCreateConversationErrors(arg3) == "participant_chat_disabled" then "Feature.Chat.Message.PartyUnavailableWithUser" else "Feature.Toast.NetworkingError.SomethingIsWrong"

            arg1.props.navigation.navigate(
                EnumScreens.RoactChatToast,
                {
                    toastProps = {
                        toastContent = { toastTitle = toastTitle }
                    }
                }
            )
        end)
    end

    function arg1.openReportUser(participantId, conversationId)
        arg1.props.navigation.replace(
            EnumScreens.AppChatReportAbuse,
            { participantId = participantId, conversationId = conversationId }
        )
    end

    function arg1.openBlockingModal(arg2, conversationId)
        arg1.props.navigation.replace(EnumScreens.BlockingModal, {
            navProps = {
                userId = arg2,
                openReportUser = function()
                    arg1.props.navigation.pop()
                    arg1.props.navigation.navigate(
                        EnumScreens.AppChatReportAbuse,
                        { participantId = arg2, conversationId = conversationId }
                    )
                end,
                disableReportOption = FFlagDisableBlockAndReport
            }
        })
    end
end

function var1.render(arg1)
    local navigation = arg1.props.navigation
    assert(type(navigation) ~= "nil", "ParticipantDialogScreenDeprecated should be wrapped with navigation")

    local conversationId = navigation.getParam("conversationId", nil)
    local participantId = navigation.getParam("participantId", nil)
    local showRemoveUserButton = navigation.getParam("showRemoveUserButton", false)
    local isWideMode = navigation.getScreenProps("wideMode", false)

    if conversationId == nil or participantId == nil then
        Logger:warning("ConversationId and participantId are required to open {screen}")
        return nil
    end

    return React.createElement(ParticipantDialogContainerDeprecated, {
        conversationId = conversationId,
        participantId = participantId,
        showRemoveUserButton = showRemoveUserButton,
        isWideMode = isWideMode,
        onDismiss = arg1.onDismiss,
        openRemoveUserDialog = arg1.openRemoveUserDialog,
        openReportUser = arg1.openReportUser,
        openViewProfile = arg1.openViewProfile,
        openChat = arg1.openChat,
        openBlockingModal = arg1.openBlockingModal
    })
end

function var1.didMount(_)
    Logger:info("{screen} mounted")
end

local var2 = connectAnalytics(function(analytics)
    return { analytics = analytics }
end)(var1)

return (RoactRodux.connect(nil, function(dispatch)
    return { dispatch = dispatch }
end)(var2))

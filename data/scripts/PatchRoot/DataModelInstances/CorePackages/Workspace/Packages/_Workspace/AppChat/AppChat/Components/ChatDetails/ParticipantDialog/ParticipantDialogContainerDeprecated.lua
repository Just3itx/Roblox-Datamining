-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local EnumScreens = require(AppChat.EnumScreens)
local NetworkingFriends = require(AppChat.Http.NetworkingFriends)
local _types = require(AppChat.types)
local useAppPolicy = require(AppChat.Hooks.useAppPolicy)
local useIsExternalNavigationAvailable = require(AppChat.Hooks.useIsExternalNavigationAvailable)
local Conversation = require(AppChat.Models.Conversation)

local Cryo = require(AppChatParent.Cryo)
local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local InputHandlers = require(AppChatParent.InputHandlers)
local React = require(AppChatParent.React)
local _ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local AppFocusRoot = FocusNavigationUtils.AppFocusRoot
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum
local FFlagAppChatMigrateFriendshipStatuses = require(AppChat.Flags.FFlagAppChatMigrateFriendshipStatuses)
local useGetFriendshipStatus = require(AppChatParent.FriendsHydrationReact).useGetFriendshipStatus

local memo = React.memo

local ParticipantDialogDeprecated = require(script.Parent.ParticipantDialogDeprecated)
local PlayerContextualMenuWrapper = require(script.Parent.PlayerContextualMenuWrapper)

local tbl1 = {
    conversationId = nil,
    participantId = nil,
    showRemoveUserButton = false,
    isWideMode = false,
    viewProfileText = "Feature.Chat.Label.ViewProfile",
    chatText = "CommonUI.Features.Label.Chat",
    reportUserText = "Feature.Chat.Action.ReportUser",
    removeFromGroupText = "Feature.Chat.Action.RemoveFromGroup",
    cancelText = "Feature.Chat.Action.Cancel",
    openViewProfile = nil,
    openChat = nil,
    openReportUser = nil,
    openRemoveUserDialog = nil,
    onDismiss = function() end
}

local tbl2 = { skipFetch = true }

function ParticipantDialogContainerDeprecated(tbl3)
    local var1 = Cryo.Dictionary.join(tbl1, tbl3)
    local showViewProfileButton = useAppPolicy(function(arg1)
        return arg1.getChatViewProfileOption()
    end)

    local var3 = useSelector(function(arg1)
        local conversations = arg1.ChatAppReducer and arg1.ChatAppReducer.Conversations
        local conversation = conversations and conversations[var1.conversationId]
        return conversation and conversation.conversationType == Conversation.Type.MULTI_USER_CONVERSATION
    end)

    local var4 = useDispatch()
    local bool1

    if FFlagAppChatMigrateFriendshipStatuses then
        bool1 = useGetFriendshipStatus(var1.participantId, if var3 then nil else tbl2) == Enum.FriendStatus.Friend
    else
        bool1 = useSelector(function(arg1)
            local friends = arg1.ChatAppReducer and arg1.ChatAppReducer.Friends
            local friendshipStatus = friends and friends.friendshipStatus
            return friendshipStatus and friendshipStatus[var1.participantId] == Enum.FriendStatus.Friend
        end)

        React.useEffect(function()
            if var3 then
                var4(NetworkingFriends.GetExtendedFriendshipStatus.API({ targetUserId = var1.participantId }))
            end
        end, { var1.participantId, var4, var3 })
    end

    local showChatButton = if var3 then not not bool1 else false
    local var5 = useLocalization({
        viewProfileText = var1.viewProfileText,
        chatText = var1.chatText,
        reportUserText = var1.reportUserText,
        removeFromGroupText = var1.removeFromGroupText,
        cancelText = var1.cancelText
    })

    local var6 = useIsExternalNavigationAvailable({ EnumScreens.ViewUserProfile })

    local customEventHandlers = React.useMemo(function()
        local result = {}
        result[FocusNavigationEventNameEnum.NavigateBack] = {
            handler = InputHandlers.onRelease(function(arg1)
                var1.onDismiss()
                arg1:cancel()
            end)
        }
        return result
    end, { var1.onDismiss })
    local var8 = Cryo.Dictionary.join(
        var1,
        var5,
        {
            showViewProfileButton = showViewProfileButton,
            showChatButton = showChatButton,
            isWideMode = var1.isWideMode
        }
    )
    if var6[EnumScreens.ViewUserProfile] then
        return React.createElement(FocusNavigableSurfaceWrapper, {
            customEventHandlers = customEventHandlers,
            isAutoFocusRoot = true,
            isFocusable = true,
            isIsolated = true,
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp
        }, { React.createElement(ParticipantDialogDeprecated, var8) })
    end

    return React.createElement(AppFocusRoot, {
        customEventHandlers = customEventHandlers,
        isAutoFocusRoot = true,
        isFocusable = true,
        isIsolated = true,
        shouldRestoreFocus = false,
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp
    }, { React.createElement(PlayerContextualMenuWrapper, {
            conversationId = var1.conversationId,
            participantId = var1.participantId,
            onDismiss = var1.onDismiss,
            openRemoveUserDialog = var1.openRemoveUserDialog,
            removeFromGroupText = var5.removeFromGroupText,
            openReportUser = var1.openReportUser,
            showRemoveUserButton = var1.showRemoveUserButton,
            openBlockingModal = var1.openBlockingModal
        }) })
end

return memo(ParticipantDialogContainerDeprecated)

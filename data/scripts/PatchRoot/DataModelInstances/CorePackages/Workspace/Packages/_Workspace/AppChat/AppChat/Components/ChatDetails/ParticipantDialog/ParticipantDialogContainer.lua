-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:00:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local BackHandlerContext = require(AppChat.Contexts.BackHandlerContext)
local EnumScreens = require(AppChat.EnumScreens)
local _types = require(AppChat.types)
local useAppPolicy = require(AppChat.Hooks.useAppPolicy)
local useIsExternalNavigationAvailable = require(AppChat.Hooks.useIsExternalNavigationAvailable)
local Conversation = require(AppChat.Models.Conversation)

local Cryo = require(AppChatParent.Cryo)
local FocusNavigationUtils = require(AppChatParent.FocusNavigationUtils)
local InputHandlers = require(AppChatParent.InputHandlers)
local NotificationModalsManager = require(AppChatParent.NotificationModalsManager)
local React = require(AppChatParent.React)
local _ReactFocusNavigation = require(AppChatParent.ReactFocusNavigation)
local SharedFlags = require(AppChatParent.SharedFlags)
local useGetFriendshipStatus = require(AppChatParent.FriendsHydrationReact).useGetFriendshipStatus
local useLocalization = require(AppChatParent.Localization).Hooks.useLocalization
local useDispatch = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useDispatch
local useSelector = require(AppChatParent.RoactUtils).Hooks.RoactRodux.useSelector
local useNavigation = require(AppChatParent.Navigation).useNavigation
local SocialCommon = require(AppChatParent.SocialCommon)
local SocialLuaAnalytics = require(AppChatParent.SocialLuaAnalytics)

local NetworkingFriends = require(AppChat.Http.NetworkingFriends)

local FocusNavigableSurfaceIdentifierEnum = FocusNavigationUtils.FocusNavigableSurfaceIdentifierEnum
local FocusNavigableSurfaceWrapper = FocusNavigationUtils.FocusNavigableSurfaceWrapper
local AppFocusRoot = FocusNavigationUtils.AppFocusRoot
local FocusNavigationEventNameEnum = FocusNavigationUtils.FocusNavigationEventNameEnum

local FFlagDisableBlockAndReport = SharedFlags.FFlagDisableBlockAndReport
local FFlagAppChatMigrateFriendshipStatuses = require(AppChat.Flags.FFlagAppChatMigrateFriendshipStatuses)

local memo = React.memo

local GenericDialogType = require(script.Parent.Parent.Dialogs.GenericDialogType)
local ParticipantDialog = require(script.Parent.ParticipantDialog)
local PlayerContextualMenuWrapper = require(script.Parent.PlayerContextualMenuWrapper)
local useTrustedFriendAction = require(script.Parent.useTrustedFriendAction)
local connectAnalytics = require(AppChat.LegacyAnalytics.connectAnalytics)
local RoactChatAnalytics = require(AppChat.LegacyAnalytics.RoactChatAnalytics)
local createConversation = require(AppChat.Conversations.Thunks.createConversation)
local parseCreateConversationErrors = require(AppChat.Conversations.Thunks.parseCreateConversationErrors)
local ChatEntryPointNames = SocialCommon.Enums.ChatEntryPointNames
local EnteredChatFromEntryPoint = require(AppChat.Actions).EnteredChatFromEntryPoint
local Logger = require(script.Parent.Logger)

local Sources = SocialLuaAnalytics.Analytics.Enums.Sources

local tbl1 = { skipFetch = true }

local tbl2 = {
    conversationId = nil,
    participantId = nil,
    anchorRef = nil,
    showRemoveUserButton = false,
    isWideMode = false,
    navigateToDialog = function() end,
    viewProfileText = "Feature.Chat.Label.ViewProfile",
    chatText = "CommonUI.Features.Label.Chat",
    reportUserText = "Feature.Chat.Action.ReportUser",
    removeFromGroupText = "Feature.Chat.Action.RemoveFromGroup",
    onDismiss = function() end,
    openBlockingModal = nil,
    analytics = nil
}

function ParticipantDialogContainer(tbl3)
    local var1 = Cryo.Dictionary.join(tbl2, tbl3)
    local var2 = React.useContext(BackHandlerContext)
    local var3 = React.useRef(var1.onDismiss)
    var3.current = var1.onDismiss
    React.useLayoutEffect(function()
        return var2(function()
            var3.current()
        end)
    end, { var2 })

    local var4 = useNavigation()
    local var5 = useDispatch()
    local var6 = var1.navigateToDialog or function() end

    local showViewProfileButton = useAppPolicy(function(arg1)
        return arg1.getChatViewProfileOption()
    end)

    local var8 = useSelector(function(arg1)
        local conversations = arg1.ChatAppReducer and arg1.ChatAppReducer.Conversations
        local conversation = conversations and conversations[var1.conversationId]
        return conversation and conversation.conversationType == Conversation.Type.MULTI_USER_CONVERSATION
    end)

    local bool1

    if FFlagAppChatMigrateFriendshipStatuses then
        bool1 = useGetFriendshipStatus(var1.participantId, if var8 then nil else tbl1) == Enum.FriendStatus.Friend
    else
        bool1 = useSelector(function(arg1)
            local friends = arg1.ChatAppReducer and arg1.ChatAppReducer.Friends
            local friendshipStatus = friends and friends.friendshipStatus
            return friendshipStatus and friendshipStatus[var1.participantId] == Enum.FriendStatus.Friend
        end)

        React.useEffect(function()
            if var8 then
                var5(NetworkingFriends.GetExtendedFriendshipStatus.API({ targetUserId = var1.participantId }))
            end
        end, { var1.participantId, var5, var8 })
    end

    local showChatButton = if var8 then not not bool1 else false
    local var9 = useLocalization({
        viewProfileText = var1.viewProfileText,
        chatText = var1.chatText,
        reportUserText = var1.reportUserText,
        removeFromGroupText = var1.removeFromGroupText,
        chatUnavailableWithUser = "Feature.Chat.Message.ChatUnavailableWithUser",
        networkErrorText = "Feature.Toast.NetworkingError.SomethingIsWrong"
    })

    local var10 = useIsExternalNavigationAvailable({ EnumScreens.ViewUserProfile })[EnumScreens.ViewUserProfile]

    local var11 = useTrustedFriendAction(var1.participantId)
    local action = var11.action
    local refetch = var11.refetch

    local showTrustedFriendButton = var10 and action ~= nil
    local isDisabled = not (action == nil) and action.isDisabled
    local actionText = var11.actionText

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

    local openRemoveUserDialog = React.useCallback(function(participantId, conversationId)
        Logger:info("User activated removeFromGroup | userId: {}, conversationId: {}", participantId, conversationId)
        var1.onDismiss()
        var6(GenericDialogType.RemoveUserDialog, { conversationId = conversationId, participantId = participantId })
    end, { var1.onDismiss, var6 })

    local openViewProfile = React.useCallback(function(arg1)
        local var15 = var4.getScreenProps("navigateToLuaAppPages", {})[EnumScreens.ViewUserProfile]

        if not var15 then
            Logger:warning("UserProfile page was not set in navigateToLuaAppPages screenProps")

            return
        end

        Logger:info("Navigate To UserProfile from {screen}")
        if var1.analytics then
            var1.analytics:navigate(RoactChatAnalytics.NavigationEvents.ChatDetailsProfile)
        end
        var1.onDismiss()
        var15(arg1, {})
    end, { var4, var1.analytics, var1.onDismiss })

    local openTrustedFriend = React.useCallback(function()
        if action == nil then
            return
        end

        if action.actionType == "RemoveTrustedConnection" then
            var1.onDismiss()
            var5(NetworkingFriends.RemoveTC.API(var1.participantId)):andThen(function()
                refetch()
                NotificationModalsManager.SetUIBloxToast(
                    {
                        sequenceNumber = DateTime.now().UnixTimestamp,
                        toastTitle = var11.toastText
                    }
                )
            end):catch(function(arg1)
                Logger:warning("Error removing trusted connection for userId {}: {}", var1.participantId, tostring(arg1))
            end)

            return
        end

        local modalVariantOverride = action.modalVariantOverride
        var1.onDismiss()

        if action.actionType == "AddIncomingTrustedConnection" then
            local tbl4 = {
                userId = var1.participantId,
                onRequestAccepted = refetch
            }
            var4.navigate(EnumScreens.TrustedConnectionsUpsell, tbl4)
            return
        end
        local tbl4 = {
            userId = var1.participantId,
            source = Sources.ChatDetails,
            modalVariantOverride = modalVariantOverride,
            onRequestSent = refetch
        }
        var4.navigate(EnumScreens.TrustedConnectionsUpsell, tbl4)
    end, {
        action,
        var11,
        var1.participantId,
        var1.onDismiss,
        var5,
        refetch,
        var4
    })

    local openChat = React.useCallback(function(arg1)
        Logger:info("User activated openChat | userId: {}", arg1)
        var5(EnteredChatFromEntryPoint(ChatEntryPointNames.ChatDetailsParticipantDialog))
        var1.onDismiss()
        var5(createConversation("one_to_one", { tostring(arg1) })):andThen(function(arg2)
            var4.navigate(EnumScreens.ChatConversation, { conversationId = arg2.id })
        end):catch(function(arg2)
            Logger:warning("Error creating 1:1 conversation for userId {}: {}", arg1, tostring(arg2))
            local toastTitle = if parseCreateConversationErrors(arg2) == "participant_chat_disabled" then var9.chatUnavailableWithUser else var9.networkErrorText
            var4.navigate(EnumScreens.RoactChatToast, { toastProps = { toastContent = { toastTitle = toastTitle } } })
        end)
    end, {
        var5,
        var4,
        var1.onDismiss,
        var9
    })

    local openReportUser = React.useCallback(function(participantId, conversationId)
        var1.onDismiss()
        var4.navigate(EnumScreens.AppChatReportAbuse, { participantId = participantId, conversationId = conversationId })
    end, { var4, var1.onDismiss })

    local var19 = React.useCallback(function(arg1, conversationId)
        local function func1()
            var4.pop()
            var4.navigate(EnumScreens.AppChatReportAbuse, { participantId = arg1, conversationId = conversationId })
        end

        var1.onDismiss()
        var4.navigate(
            EnumScreens.BlockingModal,
            {
                navProps = {
                    userId = arg1,
                    openReportUser = func1,
                    disableReportOption = FFlagDisableBlockAndReport
                }
            }
        )
    end, { var4, var1.onDismiss })

    local var20 = Cryo.Dictionary.join(var1, var9, {
        showViewProfileButton = showViewProfileButton,
        showChatButton = showChatButton,
        showTrustedFriendButton = showTrustedFriendButton,
        trustedFriendText = actionText,
        isTrustedFriendButtonDisabled = isDisabled,
        openViewProfile = openViewProfile,
        openTrustedFriend = openTrustedFriend,
        openChat = openChat,
        openReportUser = openReportUser,
        openRemoveUserDialog = openRemoveUserDialog
    })

    if var10 then
        return React.createElement(FocusNavigableSurfaceWrapper, {
            customEventHandlers = customEventHandlers,
            isAutoFocusRoot = true,
            isFocusable = true,
            isIsolated = true,
            surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp
        }, { React.createElement(ParticipantDialog, var20) })
    end

    local createElement = React.createElement
    local var21 = AppFocusRoot
    local tbl4 = {
        customEventHandlers = customEventHandlers,
        isAutoFocusRoot = true,
        isFocusable = true,
        isIsolated = true,
        shouldRestoreFocus = false,
        surfaceIdentifier = FocusNavigableSurfaceIdentifierEnum.PopUp
    }
    local createElement2 = React.createElement
    local var22 = PlayerContextualMenuWrapper
    local tbl5 = {
        conversationId = var1.conversationId,
        participantId = var1.participantId,
        onDismiss = var1.onDismiss,
        openRemoveUserDialog = openRemoveUserDialog,
        removeFromGroupText = var9.removeFromGroupText,
        openReportUser = openReportUser,
        showRemoveUserButton = var1.showRemoveUserButton,
        openBlockingModal = 0
    }

    if var1.openBlockingModal then
        var19 = var1.openBlockingModal
    end

    tbl5.openBlockingModal = var19
    return createElement(var21, tbl4, { createElement2(var22, tbl5) })
end

ParticipantDialogContainer = connectAnalytics(function(analytics)
    return { analytics = analytics }
end)(ParticipantDialogContainer)

return memo(ParticipantDialogContainer)

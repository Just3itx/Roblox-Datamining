-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local RetrievalStatus = require(AppChatParent.Http).Enum.RetrievalStatus
local Conversation = require(AppChat.Models.Conversation)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local createConversation = require(AppChat.Conversations.Thunks.createConversation)
local createFriendConversation = require(AppChat.Conversations.Thunks.createFriendConversation)
local ModerationType = require(AppChat.Models.ConversationChannels).ModerationType
local expandToGroupConversation = require(AppChat.Conversations.Thunks.expandToGroupConversation)
local fetchLatestConversationDetails = require(AppChat.Conversations.Thunks.fetchLatestConversationDetails)
local getConversationTitle = require(AppChat.Conversations.getConversationTitle)
local NavigateIntoSquadLobby = require(AppChat.Conversations.Thunks.NavigateIntoSquadLobby)
local useGetConversationFromId = require(AppChat.Hooks.useGetConversationFromId)
local useGetConversationHasGroupUpFromId = require(AppChat.Hooks.useGetConversationHasGroupUpFromId)
local useIsUserPending = require(AppChat.Hooks.useIsUserPending)
local useIsChatEnabled = require(AppChat.Hooks.useIsChatEnabled)
local useIsChatUserMessagesEnabled = require(AppChat.Hooks.useIsChatUserMessagesEnabled)
local useChatSettingsRetrievalStatus = require(AppChat.Hooks.useChatSettingsRetrievalStatus)
local FFlagReadAppChatFetchingVariable = require(AppChatParent.SharedFlags).FFlagReadAppChatFetchingVariable

local FFlagAppChatNavigateBackIfOSAUnacknowledged = require(AppChatParent.SharedFlags).FFlagAppChatNavigateBackIfOSAUnacknowledged
local FFlagEnableSquadRegroupExperimentation = require(AppChatParent.SharedFlags).FFlagEnableSquadRegroupExperimentation

local shouldShowOSAForConversation = require(AppChat.Utils.shouldShowOSAForConversation)

local GetOverlayStore = require(AppChat.Stores.GetOverlayStore)
local OverlayTypes = require(AppChat.Stores.GetOverlayStore.OverlayTypes)
local HttpService = game:GetService("HttpService")
local CreateExperienceInvite = require(AppChatParent.Squads.Thunks).CreateExperienceInvite

local function showGroupOSADialog(conversationId: string, callback: (...any) -> (...any), callback2: (...any) -> (...any))
    local overlayStore = GetOverlayStore(false)
    overlayStore.showOverlay(OverlayTypes.GroupOSADialog, {
        conversationId = conversationId,
        impressionId = HttpService:GenerateGUID(false),
        onJoin = function()
            overlayStore.dismissOverlay()
            callback()
        end,
        onDecline = function()
            overlayStore.dismissOverlay()
            callback2()
        end
    })
end

local tbl1 = {
    fetchParentChannelDetails = function(arg1, arg2)
        return arg1(fetchLatestConversationDetails(arg2))
    end,
    inviteToParentChannel = function(arg1, arg2, tbl1)
        if arg2.conversationType == Conversation.Type.MULTI_USER_CONVERSATION then
            return arg1(AppChatNetworking.rodux.AddUserToConversation.API(arg2.id, tbl1)):andThen(function()
                return arg2.id
            end)
        end

        return arg1(expandToGroupConversation(arg2.id, tbl1)):andThen(function(arg3)
            return arg3.id
        end)
    end,
    navigateIntoSquadLobby = NavigateIntoSquadLobby,
    removeUserFromParentChannel = function(arg1, arg2, arg3)
        return arg1(AppChatNetworking.rodux.RemoveUserFromConversation.API(arg2, arg3))
    end,
    createConversation = createConversation,
    createFriendConversation = createFriendConversation,
    createExperienceInvite = FFlagEnableSquadRegroupExperimentation and function(str1: string, arg1, str2: string)
        return CreateExperienceInvite(str1, arg1, str2)
    end or nil,
    useGetConversationFromId = useGetConversationFromId,
    useParentChannelHasGroupUp = function(arg1)
        return useGetConversationHasGroupUpFromId(arg1)
    end,
    useParentChannelHasSquadAccess = function(arg1): boolean
        assert(arg1 ~= nil, "Missing parent channel ID")
        local var1 = useGetConversationFromId(arg1) or {}

        if var1.source == "friends" then
            return true
        end

        local bool1 = var1.participantPendingStatus == ConversationChannels.UserPendingStatus.Pending

        return not (useIsUserPending(var1) or bool1)
    end,
    useParentChannelIsPartyVoiceEligible = function(arg1)
        local var1 = useGetConversationFromId(arg1)

        if var1 and var1.moderationType ~= nil then
            return var1.moderationType == ModerationType.TrustedComms
        end

        return nil
    end,
    useParentChannelTitleSelector = function(arg1)
        local var1 = useGetConversationFromId(arg1)
        return getConversationTitle(var1)
    end,
    useIsChatEnabled = useIsChatEnabled,
    useIsLoadingChatSettings = function(): boolean?
        local var1 = useChatSettingsRetrievalStatus()
        return if FFlagReadAppChatFetchingVariable then var1 ~= RetrievalStatus.Done else nil
    end,
    useIsChatUserMessagesEnabled = useIsChatUserMessagesEnabled,
    shouldShowOSAForConversation = 0,
    showGroupOSADialog = 0
}
if not FFlagAppChatNavigateBackIfOSAUnacknowledged then
    shouldShowOSAForConversation = nil
end

tbl1.shouldShowOSAForConversation = shouldShowOSAForConversation

tbl1.showGroupOSADialog = showGroupOSADialog
return tbl1

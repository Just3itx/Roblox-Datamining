-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)

local Conversation = require(AppChat.SocialLibraries).Conversation
local getConversationTitle = require(AppChat.Conversations.getConversationTitle)
local getOtherParticipant = Conversation.getOtherParticipant
local getConversationGameId = Conversation.getConversationGameId

local populateUserIdsWithState = require(script.Parent.populateUserIdsWithState)
local getThumbnailsForUserIds = require(AppChat.Users.getThumbnailsForUserIds)
local getLastMessageContent = require(script.Parent.getLastMessageContent)
local RoduxPresence = require(AppChat.Http.RoduxPresence)
local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)

local userPresenceUtils = require(AppChat.Users.userPresenceUtils)

local getConversationTimestamp = require(AppChat.Utils.getConversationTimestamp)

return function(arg1, arg2)
    local var1 = arg2.participants or {}
    local otherParticipants = Cryo.List.filter(var1, function(localUserId): boolean
        return localUserId ~= arg1.LocalUserId
    end)

    local userDisplayPresence

    if FFlagAppChatPresenceStoreMigration or arg2.conversationType ~= "OneToOneConversation" then
        userDisplayPresence = nil
    else
        local otherParticipant = getOtherParticipant(arg1, arg2.participants)
        local userPresenceByUserId = RoduxPresence.Selectors.getUserPresenceByUserId(arg1, otherParticipant)
        userDisplayPresence = userPresenceUtils.getUserDisplayPresence(userPresenceByUserId)
    end

    local tbl1 = ({})
    local users = arg1.Users

    for _, value in pairs(var1) do
        tbl1[value] = users[value]
    end

    local tbl2 = {
        shortRelativeTime = arg2.lastUpdated and getConversationTimestamp(arg2.lastUpdated),
        longRelativeTime = arg2.lastUpdated and arg2.lastUpdated:GetLongRelativeTime(),
        unixTime = arg2.lastUpdated and arg2.lastUpdated:GetUnixTimestamp()
    }

    return Cryo.Dictionary.join({
        id = arg2.id,
        title = getConversationTitle(arg2),
        participants = populateUserIdsWithState(arg1, var1),
        otherParticipants = otherParticipants,
        isDefaultTitle = arg2.isDefaultTitle,
        hasGroupUp = arg2.hasGroupUp,
        lastMessageContent = getLastMessageContent(arg2) or "",
        hasUnreadMessages = arg2.hasUnreadMessages or false,
        thumbnails = getThumbnailsForUserIds(otherParticipants),
        presenceText = if FFlagAppChatPresenceStoreMigration then nil else userDisplayPresence and userDisplayPresence.text,
        presenceImage = if FFlagAppChatPresenceStoreMigration then nil else userDisplayPresence and userDisplayPresence.image,
        gameId = getConversationGameId(arg2, arg1.LocalUserId, tbl1),
        serverState = arg2.serverState,
        moderationType = arg2.moderationType,
        userPendingStatus = arg2.userPendingStatus,
        conversationType = arg2.conversationType,
        osaAcknowledgementStatus = arg2.osaAcknowledgementStatus,
        userOptedIntoChatMessages = arg2.userOptedIntoChatMessages
    }, tbl2)
end

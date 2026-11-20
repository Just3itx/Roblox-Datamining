-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _networkingChatTypes = require(script.Parent.networkingChatTypes)
local networkRequests = script.Parent.networkRequests
local createAddToConversation = require(networkRequests.createAddToConversation)
local createRemoveFromConversation = require(networkRequests.createRemoveFromConversation)
local createRenameGroupConversation = require(networkRequests.createRenameGroupConversation)
local createStartGroupConversation = require(networkRequests.createStartGroupConversation)
local createStartOneToOneConversation = require(networkRequests.createStartOneToOneConversation)
local createSetConversationUniverse = require(networkRequests.createSetConversationUniverse)
local createResetConversationUniverse = require(networkRequests.createResetConversationUniverse)
local createSendMessage = require(networkRequests.createSendMessage)
local createSendGameLinkMessage = require(networkRequests.createSendGameLinkMessage)
local createUpdateUserTypingStatus = require(networkRequests.createUpdateUserTypingStatus)
local createMarkAsRead = require(networkRequests.createMarkAsRead)
local createMarkAsSeen = require(networkRequests.createMarkAsSeen)
local createGetMessages = require(networkRequests.createGetMessages)
local createGetUserConversations = require(networkRequests.createGetUserConversations)
local createGetConversations = require(networkRequests.createGetConversations)
local createGetLatestMessages = require(networkRequests.createGetLatestMessages)
local createGetUnreadConversationCount = require(networkRequests.createGetUnreadConversationCount)
local createGetUnreadMessages = require(networkRequests.createGetUnreadMessages)
local createGetChatSettings = require(networkRequests.createGetChatSettings)
local createGetRolloutSettings = require(networkRequests.createGetRolloutSettings)
local createGetMetadata = require(networkRequests.createGetMetadata)

return function(arg1)
    return {
        AddToConversation = createAddToConversation(arg1),
        RemoveFromConversation = createRemoveFromConversation(arg1),
        RenameGroupConversation = createRenameGroupConversation(arg1),
        StartGroupConversation = createStartGroupConversation(arg1),
        StartOneToOneConversation = createStartOneToOneConversation(arg1),
        SetConversationUniverse = createSetConversationUniverse(arg1),
        ResetConversationUniverse = createResetConversationUniverse(arg1),
        SendMessage = createSendMessage(arg1),
        SendGameLinkMessage = createSendGameLinkMessage(arg1),
        UpdateUserTypingStatus = createUpdateUserTypingStatus(arg1),
        MarkAsRead = createMarkAsRead(arg1),
        MarkAsSeen = createMarkAsSeen(arg1),
        GetMessages = createGetMessages(arg1),
        GetUserConversations = createGetUserConversations(arg1),
        GetConversations = createGetConversations(arg1),
        GetLatestMessages = createGetLatestMessages(arg1),
        GetUnreadConversationCount = createGetUnreadConversationCount(arg1),
        GetUnreadMessages = createGetUnreadMessages(arg1),
        GetChatSettings = createGetChatSettings(arg1),
        GetRolloutSettings = createGetRolloutSettings(arg1),
        GetMetadata = createGetMetadata(arg1)
    }
end

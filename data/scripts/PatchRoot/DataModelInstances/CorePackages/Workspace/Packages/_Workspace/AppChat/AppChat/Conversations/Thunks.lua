-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
return {
    createConversation = require(script.createConversation),
    SendPolicies = require(script.SendPolicies),
    SendTextMessage = require(script.SendTextMessage),
    SendMessageUsingPolicy = require(script.SendMessageUsingPolicy),
    ReceivedChatResponse = require(script.ReceivedChatResponse),
    getAllFriendsAsync = require(script.getAllFriendsAsync),
    getLocalUserFriendsCount = require(script.getLocalUserFriendsCount),
    getAllUserPresences = require(script.getAllUserPresences),
    paginateAndRefreshConversations = require(script.paginateAndRefreshConversations),
    DEPRECATED_getLocalUserConversations = require(script.DEPRECATED_getLocalUserConversations),
    fetchChatMetadata = require(script.fetchChatMetadata),
    NavigateIntoChat = require(script.NavigateIntoChat),
    NavigateIntoSquadLobby = require(script.NavigateIntoSquadLobby),
    NavigateIntoSquadLobbyIfExists = require(script.NavigateIntoSquadLobbyIfExists)
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local responses = script.responses
local _SharedTypes = require(responses.SharedTypes)
local _createConversations = require(responses["create-conversations"])
local _expandToGroupConversation = require(responses["expand-to-group-conversation"])
local _getConversationMessages = require(responses["get-conversation-messages"])
local _getMessages = require(responses["get-messages"])
local _getConversations = require(responses["get-conversations"])
local _getSuggestions = require(responses["get-suggestions"])
local _getUserConversations = require(responses["get-user-conversations"])
local _searchConversations = require(responses["search-conversations"])
local _getConversationsParticipantsMetadata = require(responses["get-conversations-participants-metadata"])
local _getMetadata = require(responses["get-metadata"])
local _getConversationMetadata = require(responses["get-conversation-metadata"])
local _clearGlobalUnreadCount = require(responses["clear-global-unread-count"])
local _getChatModerationStatuses = require(responses["get-chat-moderation-statuses"])
local _translateUserMessage = require(responses["translate-user-message"])
local _GetModalSequence = require(script.rodux.GetModalSequence)
local _GetConversations = require(script.http.GetConversations)
local _RecordModalSequenceResponse = require(script.http.RecordModalSequenceResponse)

return {
    Constants = require(script.Constants),
    http = require(script.http),
    rodux = require(script.rodux),
    ["jest.config"] = script["jest.config"]
}

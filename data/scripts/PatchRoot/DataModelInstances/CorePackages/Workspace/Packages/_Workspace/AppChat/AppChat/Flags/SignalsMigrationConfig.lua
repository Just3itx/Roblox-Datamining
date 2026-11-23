-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:31:08Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAppChatConversationStore = require(script.Parent.FFlagAppChatConversationStore)
local FFlagAppChatSignalsMessageStore = require(script.Parent.FFlagAppChatSignalsMessageStore)
local FFlagAppChatUseFoundationConversationRow = require(script.Parent.FFlagAppChatUseFoundationConversationRow)

local FFlagAppChatReadConversationListFromSignalsStore = require(script.Parent.FFlagAppChatReadConversationListFromSignalsStore)
local FFlagAppChatReadMessageListFromSignalsStore = require(script.Parent.FFlagAppChatReadMessageListFromSignalsStore)
local FFlagAppChatUseViewRecyclerMessageList = require(script.Parent.FFlagAppChatUseViewRecyclerMessageList)
local FFlagAppChatIncrementalPaginationProjection = require(script.Parent.FFlagAppChatIncrementalPaginationProjection)

local shouldUseFoundationConversationRow = FFlagAppChatUseFoundationConversationRow and FFlagAppChatConversationStore and FFlagAppChatSignalsMessageStore

local shouldReadMessageListFromSignalsStore = FFlagAppChatReadMessageListFromSignalsStore and FFlagAppChatSignalsMessageStore

return {
    shouldUseFoundationConversationRow = shouldUseFoundationConversationRow,
    shouldReadConversationListFromSignalsStore = FFlagAppChatReadConversationListFromSignalsStore and shouldUseFoundationConversationRow,
    shouldReadMessageListFromSignalsStore = shouldReadMessageListFromSignalsStore,
    shouldUseViewRecyclerMessageList = FFlagAppChatUseViewRecyclerMessageList
        and FFlagAppChatIncrementalPaginationProjection
        and shouldReadMessageListFromSignalsStore
}

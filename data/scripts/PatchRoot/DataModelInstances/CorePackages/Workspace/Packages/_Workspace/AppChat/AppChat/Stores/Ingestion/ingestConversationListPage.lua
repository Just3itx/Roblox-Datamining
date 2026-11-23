-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Cryo = require(AppChatParent.Cryo)
local SignalsExperimental = require(AppChatParent.SignalsExperimental)

local ConversationChannels = require(AppChat.Models.ConversationChannels)
local _GetConversationStore = require(AppChat.Stores.GetConversationStore)
local getResponseBody = require(script.Parent.getResponseBody)
local buildValidMessages = require(script.Parent.buildValidMessages)
local ingestBatch = require(script.Parent.ingestBatch)
local IngestOperation = require(script.Parent.IngestOperation)
local FFlagAppChatIngestConversationMessages = require(AppChat.Flags.FFlagAppChatIngestConversationMessages)
local searchIntroducedConversationIds = require(AppChat.Stores.searchIntroducedConversationIds)
local FFlagAppChatAnyServerSideConversationSearch = require(AppChat.Flags.FFlagAppChatAnyServerSideConversationSearch)

local function isInitialCursor(str1: string?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    return str1 == nil or str1 == ""
end

local function upsertConversationResponse(arg1, arg2)
    if arg2 == nil or arg2.status == "failed" then
        return
    end

    if arg2.source == ConversationChannels.Source.Channels
        and arg2.type == ConversationChannels.Type.OneToOne
        and arg2.participant_user_ids ~= nil
    then
        arg1.removeConversation(ConversationChannels.getFriendConversationId(arg2.participant_user_ids))
    end

    local channelsApi = ConversationChannels.fromChannelsApi(arg2)

    if FFlagAppChatAnyServerSideConversationSearch then
        SignalsExperimental.batch(function()
            arg1.upsertConversation(channelsApi)

            searchIntroducedConversationIds.remove(channelsApi.id)
        end)
    else
        arg1.upsertConversation(channelsApi)
    end

    if not FFlagAppChatIngestConversationMessages then
        return
    end

    local validMessages = buildValidMessages(channelsApi.id, arg2.messages or {})
    if #validMessages > 0 then
        ingestBatch(channelsApi.id, validMessages, IngestOperation.Prepend)
    end
end

local function upsertConversationResponses(arg1, arg2) -- Luacid: Inlined by compiler; 1 call site recovered
    if arg2 == nil or arg2.conversations == nil then
        return
    end

    for _, conversation in arg2.conversations do
        upsertConversationResponse(arg1, conversation)
    end
end

return {
    beginFetch = function(arg1, str1: string?)
        arg1.setListStatus(
            {
                isFetchingConversations = true,
                isFetchingNextPage = not isInitialCursor(str1),
                error = Cryo.None
            }
        )
    end,
    ingestSuccess = function(arg1, cursor: string?, arg2)
        local responseBody = getResponseBody(arg2)
        local nextCursor = if responseBody == nil then nil else responseBody.next_cursor
        local conversationCount = if responseBody == nil or responseBody.conversations == nil then 0 else #responseBody.conversations

        local bool1 = nextCursor == nil or nextCursor == ""
        local listStatus = arg1.getListStatus(false)
        upsertConversationResponses(arg1, responseBody)
        arg1.setListStatus({
            isFetchingConversations = false,
            isFetchingNextPage = false,
            hasFetchedInitialPage = if isInitialCursor(cursor) then true else listStatus.hasFetchedInitialPage,
            oldestConversationIsFetched = bool1,
            isExhausted = bool1,
            nextCursor = if bool1 then Cryo.None else nextCursor,
            error = Cryo.None
        })

        return {
            cursor = cursor,
            nextCursor = nextCursor,
            conversationCount = conversationCount,
            responseBody = responseBody
        }
    end,
    ingestFailure = function(arg1, error)
        arg1.setListStatus({ isFetchingConversations = false, isFetchingNextPage = false, error = error })
    end,
    ingestConversationResponses = upsertConversationResponses,
    ingestConversationDetails = upsertConversationResponse
}

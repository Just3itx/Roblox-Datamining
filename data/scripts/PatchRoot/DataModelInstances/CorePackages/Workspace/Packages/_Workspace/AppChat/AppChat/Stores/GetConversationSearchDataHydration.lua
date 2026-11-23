-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DataHydration = require(AppChatParent.DataHydration)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Signals = require(AppChatParent.Signals)
local SignalsExperimental = require(AppChatParent.SignalsExperimental)

local var1 = require(AppChat.Logger):new(script.Name)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local ingestConversationListPage = require(AppChat.Stores.Ingestion.ingestConversationListPage)
local getResponseBody = require(AppChat.Stores.Ingestion.getResponseBody)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local searchIntroducedConversationIds = require(AppChat.Stores.searchIntroducedConversationIds)
local createDataCache = DataHydration.createDataCache
local createDataResolver = DataHydration.createDataResolver

local function isEmptyQuery(query: string?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return query == nil or query == ""
end

local function getPageId(query: string, cursor: string?): string -- Luacid: Inlined by compiler; 1 call site recovered
    return `{query}\000{if cursor == nil or cursor == "" then "__initial__" else cursor}`
end

local function supersedesStoredFriendPlaceholder(arg1, arg2): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    if arg2.source ~= ConversationChannels.Source.Channels
        or arg2.type ~= ConversationChannels.Type.OneToOne
        or arg2.participant_user_ids == nil
    then
        return false
    end

    local friendConversationId = ConversationChannels.getFriendConversationId(arg2.participant_user_ids)
    return arg1.getConversation(friendConversationId, false) ~= nil
end

local function collectSearchOnlyIds(arg1, arg2)
    local result = {}
    if arg2 == nil or arg2.conversations == nil then
        return result
    end

    for _, conversation in arg2.conversations do
        if conversation == nil or conversation.status == "failed" then
            continue
        end

        local conversationId = ConversationChannels.getConversationId(conversation)

        if not supersedesStoredFriendPlaceholder(arg1, conversation)
            and (arg1.getConversation(conversationId, false) == nil or searchIntroducedConversationIds.has(conversationId))
        then
            table.insert(result, conversationId)
        end
    end
    return result
end

local function getOrderedMatchedIds(arg1)
    local orderedMatchedIds = {}
    if arg1 == nil or arg1.conversations == nil then
        return orderedMatchedIds
    end

    local tbl1 = ({})
    for _, conversation in arg1.conversations do
        if conversation == nil or conversation.status == "failed" then
            continue
        end

        local conversationId = ConversationChannels.getConversationId(conversation)
        if not tbl1[conversationId] then
            tbl1[conversationId] = true
            table.insert(orderedMatchedIds, conversationId)
        end
    end

    return orderedMatchedIds
end

return Signals.createComputed(function() -- name: createConversationSearchDataHydrationStore
    local cache = createDataCache(30)
    local conversationStore = GetConversationStore(false)

    local tbl1 = ({})

    local num1 = 0

    local getInvalidationGeneration, var3 = Signals.createSignal(0)
    local tbl2 = ({})
    local fetchPage = nil

    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        queueProcessDelaySec = 0,
        replaceItems = true,
        logError = function(arg1)
            var1:warning(`Failed to fetch AppChat conversation search page: {tostring(arg1)}`)
        end,
        fetchFn = function(str1: string)
            local var4 = tbl1[str1]
            local var5 = if var4 == nil then "" else var4.query
            local cursor = if var4 == nil then nil else var4.cursor
            local placement = if var4 == nil then nil else var4.placement
            local num2 = num1
            tbl2[str1] = getInvalidationGeneration(false)

            return AppChatNetworking.http.SearchConversations(nil, var5, cursor, nil, placement):andThen(function(arg1)
                if num2 ~= num1 then
                    return {
                        matchedConversationIds = {},
                        nextCursor = nil
                    }
                end
                local responseBody = getResponseBody(arg1)

                local tbl3 = collectSearchOnlyIds(conversationStore, responseBody)

                SignalsExperimental.batch(function()
                    ingestConversationListPage.ingestConversationResponses(conversationStore, responseBody)

                    for _, value in tbl3 do
                        searchIntroducedConversationIds.add(value)
                    end
                end)

                local matchedConversationIds = getOrderedMatchedIds(responseBody)
                local nextCursor = if responseBody == nil then nil else responseBody.next_cursor

                if tbl2[str1] ~= getInvalidationGeneration(false) then
                    task.defer(function()
                        if num2 == num1 then
                            fetchPage(var5, cursor, placement)
                        end
                    end)
                end

                local tbl4 = { matchedConversationIds = matchedConversationIds, nextCursor = 0 }
                if nextCursor == nil or nextCursor == "" then
                    nextCursor = nil
                end

                tbl4.nextCursor = nextCursor
                return tbl4
            end)
        end
    })

    fetchPage = function(query: string, cursor: string?, placement: string?)
        if isEmptyQuery(query) then
            return nil
        end

        local pageId = getPageId(query, cursor)
        tbl1[pageId] = { query = query, cursor = cursor, placement = placement }
        return dataResolver.getAndFetchItem(pageId, function(): boolean
            return tbl2[pageId] ~= getInvalidationGeneration(false)
        end)
    end

    conversationStore.addClearListener(function()
        num1 += 1
        tbl1 = {}
        tbl2 = {}
        searchIntroducedConversationIds.clear()
        dataResolver.clear()
    end)

    return {
        fetchPage = fetchPage,
        getInvalidationGeneration = getInvalidationGeneration,
        invalidate = function()
            var3(getInvalidationGeneration(false) + 1)
        end
    }
end)

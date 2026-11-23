-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DataHydration = require(AppChatParent.DataHydration)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local var1 = require(AppChat.Logger):new(script.Name)
local ingestConversationListPage = require(AppChat.Stores.Ingestion.ingestConversationListPage)
local GetConversationStore = require(AppChat.Stores.GetConversationStore)

local createDataCache = DataHydration.createDataCache
local createDataResolver = DataHydration.createDataResolver

local function getPageId(str1: string?): string -- Luacid: Inlined by compiler; 1 call site recovered
    return if str1 == nil or str1 == "" then "__initial__" else str1
end

local function getCursorFromPageId(str1: string): string? -- Luacid: Inlined by compiler; 1 call site recovered
    return if str1 == "__initial__" then nil else str1
end

local function isInitialCursor(str1: string?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return str1 == nil or str1 == ""
end

local function createConversationPageDataHydrationStore()
    local cache = createDataCache(60)
    local conversationStore = GetConversationStore(false)
    local dataResolver = createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        queueProcessDelaySec = 0,
        replaceItems = true,
        logError = function(arg1)
            var1:warning(`Failed to fetch AppChat conversation list page: {tostring(arg1)}`)
            ingestConversationListPage.ingestFailure(conversationStore, arg1)
        end,
        fetchFn = function(str1: string)
            local cursor = getCursorFromPageId(str1)

            return AppChatNetworking.http.GetUserConversations(nil, cursor):andThen(function(arg1)
                local var2 = ingestConversationListPage.ingestSuccess(conversationStore, cursor, arg1)

                return {
                    cursor = cursor,
                    nextCursor = var2.nextCursor,
                    conversationCount = var2.conversationCount
                }
            end)
        end
    })

    local function fetchPage(str1: string?)
        local pageId = getPageId(str1)
        local listStatus = conversationStore.getListStatus(false)

        if listStatus.isFetchingConversations == true then
            return dataResolver.getCachedItem(pageId)
        end

        if not isInitialCursor(str1) and listStatus.isExhausted == true then
            return dataResolver.getCachedItem(pageId)
        end

        ingestConversationListPage.beginFetch(conversationStore, str1)
        return dataResolver.fetchItem(pageId)
    end

    conversationStore.addClearListener(function()
        dataResolver.clear()
    end)

    return {
        fetchPage = fetchPage,
        clear = function()
            dataResolver.clear()
        end
    }
end

return (createConversationPageDataHydrationStore())

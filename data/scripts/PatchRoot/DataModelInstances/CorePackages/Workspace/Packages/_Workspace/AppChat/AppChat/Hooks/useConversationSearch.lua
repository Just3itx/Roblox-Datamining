-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _DataHydration = require(AppChatParent.DataHydration)
local React = require(AppChatParent.React)
local Signals = require(AppChatParent.Signals)
local SignalsReact = require(AppChatParent.SignalsReact)

local GetConversationStore = require(AppChat.Stores.GetConversationStore)
local GetConversationSearchDataHydration = require(AppChat.Stores.GetConversationSearchDataHydration)

local tbl1 = {
    query = "",
    items = {},
    status = "Idle",
    nextCursor = nil
}
local tbl2 = {
    query = "",
    pages = {}
}
local function normalizeQuery(str1: string?, bool1: boolean)
    if not bool1 or str1 == nil then
        return ""
    end

    local var1 = string.match(str1, "^%s*(.-)%s*$") or ""
    local num1 = utf8.len(var1) or #var1
    if num1 < 1 then
        return ""
    end

    if num1 > 200 then
        local num2 = utf8.offset(var1, 201)
        if num2 ~= nil then
            return string.sub(var1, 1, num2 - 1)
        end
    end

    return var1
end

local function useConversationSearch(str1: string?, bool1: boolean?, str2: string?)
    local conversationSearchDataHydration = GetConversationSearchDataHydration(false)
    local conversationStore = GetConversationStore(false)
    local var1 = normalizeQuery(str1, bool1 ~= false)

    local var2, var3 = React.useState("")

    React.useEffect(function()
        if var1 == "" then
            var3("")
            return
        end

        local var4 = task.delay(0.15, function()
            var3(var1)
        end)

        return function()
            task.cancel(var4)
        end
    end, { var1 })

    local var4, var5 = React.useState(tbl2)
    local current = SignalsReact.useSignalState(conversationSearchDataHydration.getInvalidationGeneration)

    React.useEffect(function()
        if var2 == "" then
            var5(tbl2)
            return
        end

        local var7 = conversationSearchDataHydration.fetchPage(var2, nil, str2)
        if var7 == nil then
            var5({ query = var2, pages = {} })
            return
        end

        var5({ query = var2, pages = {{ result = var7 }} })
    end, { var2, conversationSearchDataHydration, str2 })

    local var7 = React.useRef(current)
    React.useEffect(function()
        if var7.current == current then
            return
        end
        var7.current = current
        for _, value in var4.pages do
            conversationSearchDataHydration.fetchPage(var4.query, value.cursor, str2)
        end
    end, {
        var4,
        conversationSearchDataHydration,
        current,
        str2
    })
    local loadNext = React.useCallback(function()
        local pages = var4.pages
        local var8 = pages[#pages]
        if var8 == nil or var8.result.status(false) ~= "Ready" then
            return
        end

        local var9 = var8.result.data(false)
        local nextCursor = if var9 == nil then nil else var9.nextCursor

        if nextCursor == nil then
            return
        end

        local var10 = conversationSearchDataHydration.fetchPage(var4.query, nextCursor, str2)
        if var10 == nil then
            return
        end

        var5(function(arg1)
            if arg1.query ~= var4.query then
                return arg1
            end
            local var6 = table.clone(arg1.pages)
            table.insert(var6, { result = var10, cursor = nextCursor })
            return {
                query = arg1.query,
                pages = var6
            }
        end)
    end, { var4, conversationSearchDataHydration, str2 })

    local var9 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            local function collectItems(pages)
                local tbl3 = {}
                local tbl4 = ({})
                for _, value in pages do
                    local var9 = value.result.data(arg1)
                    if var9 == nil or var9.matchedConversationIds == nil then
                        continue
                    end

                    for _, matchedConversationId in var9.matchedConversationIds do
                        if not tbl4[matchedConversationId] then
                            tbl4[matchedConversationId] = true
                            table.insert(tbl3, matchedConversationId)
                        end
                    end
                end

                local result = {}
                for _, value in tbl3 do
                    local conversation = conversationStore.getConversation(value, arg1)
                    if conversation ~= nil then
                        table.insert(result, conversation)
                    end
                end
                return result
            end

            local pages = var4.pages
            if var4.query == "" or #pages == 0 then
                return tbl1
            end

            local var9 = pages[#pages]
            local var10 = var9.result.data(arg1)
            return {
                query = var4.query,
                items = collectItems(pages),
                status = var9.result.status(arg1),
                nextCursor = if var10 == nil then nil else var10.nextCursor
            }
        end)
    end, { var4, conversationStore })

    local var10 = SignalsReact.useSignalState(var9)

    return {
        items = var10.items,
        status = var10.status,
        isActive = var1 ~= "",
        debouncedQuery = var2,
        isFetching = var10.status == "NotReady",
        isAwaitingResults = not (var1 == "") and (var10.query ~= var1 or var10.status == "NotReady" or var10.status == "Idle"),
        hasError = var10.status == "Failed",
        hasSearched = var10.query ~= "",
        nextCursor = var10.nextCursor,
        loadNext = loadNext
    }
end

return useConversationSearch

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Players = game:GetService("Players")

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local DataHydration = require(AppChatParent.DataHydration)
local _LuauPolyfill = require(AppChatParent.LuauPolyfill)
local Promise = require(AppChatParent.Promise)

local var1 = require(AppChat.Logger):new(script.Name)
local getResponseBody = require(AppChat.Stores.Ingestion.getResponseBody)
local serializeChatTimeoutRange = require(AppChat.Utils.serializeChatTimeoutRange)

local FFlagAppChatReactiveFeatureRestrictions = require(AppChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions

local tbl1 = { status = "none" }

local function getLocalPlayerUserId(): number? -- Luacid: Inlined by compiler; 2 call sites recovered
    local userId = if Players.LocalPlayer then Players.LocalPlayer.UserId else nil
    return if userId == nil or not (userId > 0) then nil else userId
end

local function toTimeoutStatus(userTimeoutRange) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = serializeChatTimeoutRange(userTimeoutRange)
    return {
        status = "active",
        endTimestamp = var2.endTimestamp,
        decisionEventId = userTimeoutRange.decision_event_id,
        duration = var2.duration or 0,
        requiresAcknowledgement = var2.requiresAcknowledgement
    }
end

local function mapResponseToStatuses(arg1, tbl2)
    local responseBody = getResponseBody(arg1)
    local var2 = if tbl2.includeUser then if responseBody and responseBody.user_timeout_range then toTimeoutStatus(responseBody.user_timeout_range) else tbl1 else nil
    local tbl3 = ({})
    local tbl4 = ({})

    for _, conversationId in tbl2.conversationIds do
        tbl4[conversationId] = true
        tbl3[conversationId] = tbl1
    end

    if responseBody and responseBody.conversation_timeout_ranges then
        for _, value in responseBody.conversation_timeout_ranges do
            if not tbl4[value.id] then
                continue
            end

            local id = value.id
            local timeoutRange = value.timeout_range
            local var3 = serializeChatTimeoutRange(timeoutRange)
            tbl3[id] = {
                status = "active",
                endTimestamp = var3.endTimestamp,
                decisionEventId = timeoutRange.decision_event_id,
                duration = var3.duration or 0,
                requiresAcknowledgement = var3.requiresAcknowledgement
            }
        end
    end

    return var2, tbl3
end

local function createChatModerationStatusDataHydrationStore()
    local cache = DataHydration.createDataCache()
    local dataCache = DataHydration.createDataCache()

    local num1 = 0
    local var2 = nil
    local tbl2 = ({})

    local dataResolver = DataHydration.createDataResolver({
        cache = cache,
        supportsMultiGet = false,
        queueProcessDelaySec = 0,
        replaceItems = true,
        logError = function(arg1)
            var1:warning(`Failed to fetch local-user chat moderation status: {tostring(arg1)}`)
        end,
        fetchFn = function()
            return AppChatNetworking.http.GetChatModerationStatuses(nil, nil):andThen(function(arg1)
                return (mapResponseToStatuses(arg1, { includeUser = true, conversationIds = {} }))
            end)
        end
    })

    local dataResolver2 = DataHydration.createDataResolver({
        cache = dataCache,
        queueProcessDelaySec = 0,
        replaceItems = true,
        logError = function(arg1)
            var1:warning(`Failed to fetch conversation chat moderation status: {tostring(arg1)}`)
        end,
        fetchFn = function(arg1)
            local conversationIds = {}
            for value in arg1 do
                table.insert(conversationIds, value)
            end

            return AppChatNetworking.http.GetChatModerationStatuses(nil, conversationIds):andThen(function(arg2)
                local _, tbl4 = mapResponseToStatuses(arg2, { includeUser = false, conversationIds = conversationIds })

                return tbl4
            end)
        end
    })

    local function ingestResponse(arg1, tbl3) -- Luacid: Inlined by compiler; 1 call site recovered
        local var3, tbl4 = mapResponseToStatuses(arg1, tbl3)
        if var3 then
            cache.replaceItem("__local_user__", var3)
        end
        if next(tbl4) then
            dataCache.replaceItems(tbl4)
        end
    end

    local function releaseRefreshOwnership(num2: number, tbl3) -- Luacid: Inlined by compiler; 2 call sites recovered
        if var2 == num2 then
            var2 = nil
        end

        for _, value in tbl3 do
            if tbl2[value] == num2 then
                tbl2[value] = nil
            end
        end
    end

    return {
        getUserStatus = function()
            return dataResolver.getAndFetchItem("__local_user__")
        end,
        getCachedUserStatus = function()
            return cache.getItem("__local_user__")
        end,
        getConversationStatus = function(str1: string)
            return dataResolver2.getAndFetchItem(str1)
        end,
        getCachedConversationStatus = function(str1: string)
            return dataCache.getItem(str1)
        end,
        ingestResponse = ingestResponse,
        refreshStatuses = function(tbl3)
            num1 += 1
            var2 = num1

            local num2 = num1
            local localPlayerUserId = getLocalPlayerUserId()
            local var3 = not tbl3 and {} or table.clone(tbl3)
            for _, value in var3 do
                tbl2[value] = num2
            end

            return AppChatNetworking.http.GetChatModerationStatuses(nil, tbl3):andThen(function<T>(arg1: T): T
                if localPlayerUserId == getLocalPlayerUserId() then
                    local conversationIds = {}
                    for _, value in var3 do
                        if tbl2[value] == num2 then
                            table.insert(conversationIds, value)
                        end
                    end

                    ingestResponse(arg1, { includeUser = var2 == num2, conversationIds = conversationIds })
                end

                return arg1
            end):andThen(function<T>(arg1: T): T -- name: onSuccess
                releaseRefreshOwnership(num2, var3)
                return arg1
            end, function(arg1) -- name: onFailure
                releaseRefreshOwnership(num2, var3)
                return Promise.reject(arg1)
            end)
        end,
        setConversationStatusNone = function(str1: string)
            dataCache.replaceItem(str1, tbl1)
        end,
        clear = function()
            if FFlagAppChatReactiveFeatureRestrictions then
                var2 = nil
                table.clear(tbl2)
            end
            dataResolver.clear()
            dataResolver2.clear()
        end
    }
end

local var2 = nil

local function GetChatModerationStatusDataHydration(_)
    local var3 = var2
    if var3 ~= nil then
        return var3
    end
    local chatModerationStatusDataHydrationStore = createChatModerationStatusDataHydrationStore()
    var2 = chatModerationStatusDataHydrationStore
    return chatModerationStatusDataHydrationStore
end

return GetChatModerationStatusDataHydration

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:10:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Signals = require(AppChatParent.Signals)
local _createConversationStore = require(AppChat.Stores.GetConversationStore.createConversationStore)

local _createConversationViewModelStore = require(AppChat.Stores.GetConversationViewModelStore.createConversationViewModelStore)
local getConversationIds = require(AppChat.Utils.getConversationIds)
local searchIntroducedConversationIds = require(AppChat.Stores.searchIntroducedConversationIds)
local FFlagAppChatAnyServerSideConversationSearch = require(AppChat.Flags.FFlagAppChatAnyServerSideConversationSearch)

local FFlagAppChatDerivedConversationLatestActivity = require(AppChat.Flags.FFlagAppChatDerivedConversationLatestActivity)

local function getLastUpdatedUnixTime(arg1) -- Luacid: Inlined by compiler; 2 call sites recovered
    local lastUpdated = arg1.lastUpdated
    if lastUpdated == nil then
        return nil
    elseif typeof(lastUpdated) == "DateTime" then
        return lastUpdated.UnixTimestamp
    elseif type(lastUpdated) == "table" and lastUpdated.GetUnixTimestamp ~= nil then
        return lastUpdated:GetUnixTimestamp()
    end
    return nil
end

local function compareConversations(arg1, arg2, num1: number?, num2: number?): boolean -- Luacid: Inlined by compiler; 2 call sites recovered
    if num1 == nil or num2 == nil then
        if num1 == nil and num2 == nil then
            return string.lower(arg1.title or "") < string.lower(arg2.title or "")
        end

        return num1 ~= nil
    end

    return num2 < num1
end

local function compareByServerLastUpdated(arg1, arg2): boolean
    return compareConversations(arg1, arg2, getLastUpdatedUnixTime(arg1), (getLastUpdatedUnixTime(arg2)))
end

local function sortByLatestActivity(tbl1, arg1, arg2)
    local tbl2 = {}
    for _, value in tbl1 do
        tbl2[value.id] = arg1.getUnixTime(value.id)(arg2)
    end
    table.sort(tbl1, function(arg3, arg4): boolean
        return compareConversations(arg3, arg4, tbl2[arg3.id], tbl2[arg4.id])
    end)
end

local function containsAllFrozenConversations(tbl1, tbl2)
    for _, value in tbl2 do
        if table.find(tbl1, value) == nil then
            return false
        end
    end
    return true
end

local function excludeSearchIntroduced(tbl1)
    local result = {}
    for _, value in tbl1 do
        if not searchIntroducedConversationIds.has(value.id) then
            table.insert(result, value)
        end
    end
    return result
end

local function getSortedConversations(arg1, arg2, arg3) -- Luacid: unused: defined but never referenced
    local conversations = arg1.getConversations(arg3)
    if FFlagAppChatAnyServerSideConversationSearch then
        conversations = excludeSearchIntroduced(conversations)
    end
    if FFlagAppChatDerivedConversationLatestActivity then
        sortByLatestActivity(conversations, arg2, arg3)
    else
        table.sort(conversations, compareByServerLastUpdated)
    end

    return conversations
end

local function createConversationListStore(arg1, arg2)
    local var1 = nil
    local var2, var3 = Signals.createSignal(false)

    arg1.addClearListener(function()
        var1 = nil
        var3(false)
    end)

    local function getOrderedConversationIds(arg3)
        local var4 = arg2
        local conversations = arg1.getConversations(arg3)

        if FFlagAppChatAnyServerSideConversationSearch then
            conversations = excludeSearchIntroduced(conversations)
        end
        if FFlagAppChatDerivedConversationLatestActivity then
            sortByLatestActivity(conversations, var4, arg3)
        else
            table.sort(conversations, compareByServerLastUpdated)
        end

        local conversationIds = getConversationIds(conversations)

        if var2(arg3) ~= true or var1 == nil then
            var1 = conversationIds
            return conversationIds
        end

        if #conversationIds == 0 then
            var1 = nil
            return {}
        end

        if containsAllFrozenConversations(conversationIds, var1) then
            return var1
        end

        var1 = conversationIds
        return conversationIds
    end

    return {
        getOrderedConversationIds = getOrderedConversationIds,
        getConversations = function(arg3)
            local conversations = {}
            for _, value in getOrderedConversationIds(arg3) do
                local conversation = arg1.getConversation(value, arg3)
                if conversation ~= nil then
                    table.insert(conversations, conversation)
                end
            end
            return conversations
        end,
        getListStatus = function(arg3)
            return arg1.getListStatus(arg3)
        end,
        setLatestMessagesFetching = function(bool1: boolean)
            var3(bool1)
        end
    }
end
return createConversationListStore

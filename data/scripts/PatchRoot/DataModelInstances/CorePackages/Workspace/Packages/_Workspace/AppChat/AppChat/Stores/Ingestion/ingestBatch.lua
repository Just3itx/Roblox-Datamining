-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local _Types = require(AppChat.MessageData.Types)
local GetConversationMessageStore = require(AppChat.Stores.GetConversationMessageStore)
local GetConversationMessageListStore = require(AppChat.Stores.GetConversationMessageListStore)
local IngestOperation = require(script.Parent.IngestOperation)

local function ingestBatch(str1: string, tbl1, arg1, str2: string?)
    local conversationMessageStore = GetConversationMessageStore(false)
    local conversationMessageListStore = GetConversationMessageListStore(false)

    local tbl2 = {}
    local result = {}

    for _, value in tbl1 do
        if value and value.id then
            tbl2[value.id] = value
            table.insert(result, value.id)
        end
    end

    if next(tbl2) ~= nil then
        conversationMessageStore.upsertMessages(tbl2)
    end

    if arg1 == IngestOperation.AppendAndAdvanceCursor then
        conversationMessageListStore.receivePage(str1, result, str2)
        return result
    end

    if arg1 == IngestOperation.Append then
        if #result > 0 then
            conversationMessageListStore.appendMessages(str1, result)
            return result
        end
    elseif #result > 0 then
        conversationMessageListStore.prependMessages(str1, result)
    end

    return result
end

return ingestBatch

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local getDeepValue = require(AppChat.Utils.getDeepValue)
local Cryo = require(AppChatParent.Cryo)
local messageSortPredicate = require(AppChat.Components.ChatConversation.Utils.messageSortPredicate)
local filterForLinksWithPolicy = require(AppChat.Components.ChatConversation.Utils.filterForLinksWithPolicy)
local populateMessageWithState = require(AppChat.Conversations.populateMessageWithState)
local _AppChatNetworking = require(AppChatParent.AppChatNetworking)

local function selectMessagesPure(arg1, tbl1)
    local conversation = arg1.conversation

    if not conversation then
        return {
            itemList = {},
            previousMessagesState = tbl1.previousMessagesState,
            previousSendingMessagesState = tbl1.previousSendingMessagesState,
            previousMessagesResult = tbl1.previousMessagesResult
        }
    end

    local messages = conversation.messages
    local sendingMessages = conversation.sendingMessages
    local conversationId = arg1.conversationId
    local var1 = tbl1.previousMessagesState[conversationId]
    local var2 = tbl1.previousSendingMessagesState[conversationId]
    local itemList = tbl1.previousMessagesResult[conversationId]

    if not messages then
        return {
            itemList = itemList or {},
            previousMessagesState = tbl1.previousMessagesState,
            previousSendingMessagesState = tbl1.previousSendingMessagesState,
            previousMessagesResult = tbl1.previousMessagesResult
        }
    end

    if messages == var1 and sendingMessages == var2 then
        return {
            itemList = itemList or {},
            previousMessagesState = tbl1.previousMessagesState,
            previousSendingMessagesState = tbl1.previousSendingMessagesState,
            previousMessagesResult = tbl1.previousMessagesResult
        }
    end

    local deepValue = getDeepValue(messages, "values")
    local var4 = not sendingMessages and {} or getDeepValue(sendingMessages, "values")
    local var5 = Cryo.Dictionary.join(deepValue, var4)
    local var6 = Cryo.List.sort(Cryo.Dictionary.values(var5), messageSortPredicate)

    local tbl2 = {}

    for value, value2 in var6 do
        local bool1 = not not var4[value2.id]
        local var7 = filterForLinksWithPolicy(value2)
        for value3, value4 in var7 do
            local var8 = var7[value3 + 1] or var6[value + 1]

            local tbl3 = {
                Users = arg1.Users,
                LocalUserId = arg1.localUserId
            }
            local var9 = populateMessageWithState(tbl3, value4, value2.id, conversation, tbl2[#tbl2], bool1, var8)

            var9.stable_key = `{var9.stableKey or var9.messageId}_{value3}`

            table.insert(tbl2, var9)
        end
    end

    local previousMessagesState = table.clone(tbl1.previousMessagesState)
    local previousSendingMessagesState = table.clone(tbl1.previousSendingMessagesState)
    local previousMessagesResult = table.clone(tbl1.previousMessagesResult)

    previousMessagesState[conversationId] = messages
    previousSendingMessagesState[conversationId] = sendingMessages
    previousMessagesResult[conversationId] = Cryo.List.reverse(tbl2)

    return {
        itemList = previousMessagesResult[conversationId],
        previousMessagesState = previousMessagesState,
        previousSendingMessagesState = previousSendingMessagesState,
        previousMessagesResult = previousMessagesResult
    }
end

return selectMessagesPure

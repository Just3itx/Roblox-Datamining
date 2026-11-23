-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local Rodux = require(AppChatParent.Rodux)

local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)
local CurrentConversationTimeoutEnded = require(AppChat.Conversations.Actions.CurrentConversationTimeoutEnded)

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local serializeChatTimeoutRange = require(AppChat.Utils.serializeChatTimeoutRange)

local FFlagAppChatReactiveFeatureRestrictions = require(AppChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AppChatNetworking.rodux.GetChatModerationStatuses.Succeeded.name] = function(arg1, tbl2)
    local responseBody = tbl2.responseBody
    local ids = if tbl2.postBody then tbl2.postBody.ids else nil

    if responseBody.user_timeout_range then
        local userTimeout = serializeChatTimeoutRange(responseBody.user_timeout_range)
        arg1 = Cryo.Dictionary.join(arg1, { userTimeout = userTimeout })
    elseif FFlagAppChatReactiveFeatureRestrictions and ids ~= nil then
        arg1 = Cryo.Dictionary.join(arg1, { userTimeout = {} })
    end

    if responseBody.conversation_timeout_ranges then
        local tbl3 = ({})

        for _, value in responseBody.conversation_timeout_ranges do
            local id = value.id
            tbl3[id] = true

            local var1 = serializeChatTimeoutRange(value.timeout_range)
            arg1 = Cryo.Dictionary.join(arg1, { byConversationId = Cryo.Dictionary.join(arg1.byConversationId, { [id] = var1 }) })
        end

        if FFlagAppChatReactiveFeatureRestrictions and ids ~= nil and #ids > 0 then
            for _, value in ids do
                if tbl3[value] then
                    continue
                end

                local join = Cryo.Dictionary.join
                local tbl4 = {
                    byConversationId = Cryo.Dictionary.join(arg1.byConversationId, { [value] = Cryo.None })
                }
                arg1 = join(arg1, tbl4)
            end
        end
    end

    return arg1
end

tbl1[RemovedConversation.name] = function(tbl2, arg1)
    local conversationId = arg1.conversationId
    return Cryo.Dictionary.join(
        tbl2,
        {
            byConversationId = Cryo.Dictionary.join(tbl2.byConversationId, { [conversationId] = Cryo.None })
        }
    )
end

tbl1[CurrentConversationTimeoutEnded.name] = function(tbl2, arg1)
    local unixTimestamp = DateTime.now().UnixTimestamp
    local var1 = if tbl2.userTimeout
        and tbl2.userTimeout.endTimestamp
        and tbl2.userTimeout.endTimestamp < unixTimestamp
        and (not FFlagAppChatReactiveFeatureRestrictions or tbl2.userTimeout.requiresAcknowledgement ~= true) then Cryo.Dictionary.join(tbl2, { userTimeout = {} }) else tbl2
    local conversationId = arg1.conversationId

    if not tbl2.byConversationId[conversationId]
        or not tbl2.byConversationId[conversationId].endTimestamp
        or unixTimestamp <= tbl2.byConversationId[conversationId].endTimestamp
        or FFlagAppChatReactiveFeatureRestrictions and tbl2.byConversationId[conversationId].requiresAcknowledgement == true
    then
        return var1
    end

    return Cryo.Dictionary.join(
        var1,
        {
            byConversationId = Cryo.Dictionary.join(var1.byConversationId, { [conversationId] = Cryo.None })
        }
    )
end

return (createReducer({ userTimeout = {}, byConversationId = {} }, tbl1))

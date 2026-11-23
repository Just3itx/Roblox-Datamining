-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local Rodux = require(AppChatParent.Rodux)

local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)

local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[AppChatNetworking.rodux.GetConversationsParticipantsMetadata.Succeeded.name] = function(arg1, arg2)
    for value, value2 in arg2.responseBody.conversation_participants_metadata do
        local tbl2 = ({})
        for value3, value4 in value2.participants_metadata do
            local tbl3 = {
                isPending = value4.is_pending
            }
            tbl3.isBlocked = value4.is_blocked
            tbl3.isInviter = value4.is_inviter
            tbl3.isInvited = value4.is_invited
            tbl2[value3] = tbl3
        end

        arg1 = Cryo.Dictionary.join(arg1, { [value] = tbl2 })
    end

    return arg1
end

tbl1[RemovedConversation.name] = function(tbl2, arg1)
    local conversationId = arg1.conversationId
    if not conversationId then
        return tbl2
    end
    return Cryo.Dictionary.join(tbl2, { [conversationId] = Cryo.None })
end

return createReducer({}, tbl1)

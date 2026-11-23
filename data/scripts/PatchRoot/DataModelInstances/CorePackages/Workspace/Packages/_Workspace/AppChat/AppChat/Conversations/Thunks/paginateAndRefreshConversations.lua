-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:00:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local getDeepValue = require(AppChat.Utils.getDeepValue)
local ConversationChannels = require(AppChat.Models.ConversationChannels)
local hasConversationChanged = require(AppChat.Conversations.hasConversationChanged)
local getShouldRefetchMessages = require(AppChat.Conversations.getShouldRefetchMessages)

local var1 = require(AppChat.Logger):new("paginateAndRefreshConversations")

local paginateForNewerMessages = require(AppChat.Conversations.Thunks.paginateForNewerMessages)

local function paginateAndRefreshConversations(str1: string?) -- Luacid: Inlined by compiler; 1 call site recovered
    return function(tbl1)
        local state = tbl1:getState()

        return tbl1:dispatch(AppChatNetworking.rodux.GetUserConversations.API(str1)):andThen(function(arg1)
            for _, conversation in arg1.responseBody.conversations do
                local var2 = getDeepValue
                local var3 = state
                local id = conversation.id
                local existing = var2(var3, `ChatAppReducer.Conversations.{tostring(id)}`)

                local new = ConversationChannels.fromChannelsApi(conversation)
                if not hasConversationChanged({ new = new, existing = existing }) then
                    return
                end

                if getShouldRefetchMessages({ new = new, existing = existing }) then
                    var1:debug("Fetching missing messages for conversation: {}", new.id)
                    tbl1:dispatch(paginateForNewerMessages(new))
                end
            end

            local nextCursor = arg1.responseBody.next_cursor
            if nextCursor and nextCursor ~= "" and typeof(nextCursor) == "string" then
                return tbl1:dispatch(paginateAndRefreshConversations(nextCursor))
            end
        end):catch(function<T>(arg1: T): T
            warn("Failure in paginateAndRefreshConversations: ", tostring(arg1))
            return arg1
        end)
    end
end

return function()
    return function(tbl1)
        return tbl1:dispatch((paginateAndRefreshConversations(nil)))
    end
end

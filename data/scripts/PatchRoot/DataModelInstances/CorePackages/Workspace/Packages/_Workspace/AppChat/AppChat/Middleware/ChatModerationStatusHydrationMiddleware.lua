-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local ClearUserSpecificData = require(AppChatParent.UserLib).Actions.ClearUserSpecificData

local RemovedConversation = require(AppChat.Conversations.Actions.RemovedConversation)
local GetChatModerationStatusDataHydration = require(AppChat.Stores.GetChatModerationStatusDataHydration)

local FFlagAppChatReactiveFeatureRestrictions = require(AppChatParent.SharedFlags).FFlagAppChatReactiveFeatureRestrictions
local FFlagAppChatUseDataHydrationForChatTimeouts = require(AppChat.Flags.FFlagAppChatUseDataHydrationForChatTimeouts)

local function ChatModerationStatusHydrationMiddleware(func1: (...any) -> (...any), _)
    return function(arg1)
        local var1 = func1(arg1)

        if arg1.type == AppChatNetworking.rodux.GetChatModerationStatuses.Succeeded.name then
            local conversationIds = not arg1.postBody and {} or arg1.postBody.ids or {}
            GetChatModerationStatusDataHydration(false).ingestResponse(
                arg1.responseBody,
                {
                    includeUser = FFlagAppChatReactiveFeatureRestrictions or #conversationIds == 0,
                    conversationIds = conversationIds
                }
            )
            return var1
        elseif arg1.type == RemovedConversation.name and arg1.conversationId then
            GetChatModerationStatusDataHydration(false).setConversationStatusNone(arg1.conversationId)
            return var1
        else
            if FFlagAppChatUseDataHydrationForChatTimeouts and arg1.type == ClearUserSpecificData.name then
                GetChatModerationStatusDataHydration(false).clear()
            end

            return var1
        end
    end
end
return ChatModerationStatusHydrationMiddleware

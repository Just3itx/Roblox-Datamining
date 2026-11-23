-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent
local Promise = require(AppChatParent.Promise)

local ConversationChannels = require(AppChat.Models.ConversationChannels)

local EventNames = require(AppChat.Analytics.EventNames)
local CreateConversationError = require(AppChat.Analytics.Enums.CreateConversationError)

return function(arg1, arg2, createdReason: string?)
    if not arg1 then
        return Promise.reject("No conversation returned.")
    end
    if arg1.status == "failed" then
        return Promise.reject("Failed to create conversation.")
    end

    local channelsApi = ConversationChannels.fromChannelsApi(arg1)

    if arg2 then
        local createConversationResult = if channelsApi then arg1.status else CreateConversationError.InvalidResponse
        arg2.fireAnalyticsEvent(EventNames.NewConversationCreated, {
            conversationId = channelsApi.id,
            createConversationResult = createConversationResult,
            participantsCount = #channelsApi.participants,
            createdReason = createdReason or "unknown"
        })
    end
    return channelsApi
end

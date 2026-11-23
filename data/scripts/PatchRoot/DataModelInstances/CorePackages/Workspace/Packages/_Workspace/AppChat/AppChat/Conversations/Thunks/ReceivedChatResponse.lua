-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:00:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local ReceivedMessages = require(AppChat.Conversations.Actions.ReceivedMessages)
local MessageModel = require(AppChat.Models.MessageModel)
local reportAnalyticsForNewMessages = require(AppChat.Utils.reportAnalyticsForNewMessages)
local var1 = require(AppChat.Logger):new(script.Name)

return function(arg1, arg2, arg3)
    return function(arg4)
        local sentChannelsApi = MessageModel.fromSentChannelsApi(arg2, arg1, arg3)

        if not sentChannelsApi then
            return
        end

        reportAnalyticsForNewMessages(sentChannelsApi, arg1)

        local conversation = arg4:getState().ChatAppReducer.Conversations[arg1]
        if not conversation then
            var1:warning("Dropping ReceivedChatResponse because conversation {} is no longer in state", arg1)

            return
        end
        if conversation.messages:Length() > 0 then
            sentChannelsApi.previousMessageId = conversation.messages:Last().id
        end
        arg4:dispatch(ReceivedMessages(arg1, { sentChannelsApi }))
    end
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:00:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local var1 = require(AppChat.Logger):new(script.Name)
local getDeepValue2 = require(AppChat.Utils.getDeepValue2)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local _ConversationChannels = require(AppChat.Models.ConversationChannels)
local getOtherParticipants = require(AppChat.Conversations.getOtherParticipants)

local FFlagAppChatConversationTrustedFriendUpsellBanner = require(AppChatParent.SharedFlags).FFlagAppChatConversationTrustedFriendUpsellBanner
local seedConversationTopModalFromRequest = if FFlagAppChatConversationTrustedFriendUpsellBanner then require(AppChat.Sdui.seedConversationTopModalFromRequest) else nil

return function(str1: string, isInExperience: boolean?)
    return function(arg1)
        local state = arg1:getState()

        local deepValue2 = getDeepValue2(state, `ChatAppReducer.Conversations.{str1}`)
        if not deepValue2 then
            var1:warning(`refreshConversationUnfilteredThreadsDetails: Conversation {str1} not found`)
            return
        end
        local str2 = str1
        local localUserId = state.LocalUserId
        if deepValue2.source == "friends" then
            local otherParticipants = getOtherParticipants(deepValue2, localUserId)
            if #otherParticipants ~= 1 then
                var1:warning(
                    `refreshConversationUnfilteredThreadsDetails: Friends Conversation {str1} has invalid number of participants {#otherParticipants}`
                )
                return
            end
            str2 = otherParticipants[1]
        end

        if deepValue2.source ~= "channels" and deepValue2.source ~= "friends" then
            var1:warning(
                `refreshConversationUnfilteredThreadsDetails: Conversation {str1} has invalid source {deepValue2.source}`
            )

            return
        end

        local api = AppChatNetworking.rodux.GetModalSequence.API
        local tbl1 = {
            modalSequence = AppChatNetworking.Constants.ModalSequence.ConversationTopModal,
            isInExperience = isInExperience,
            conversationId = if deepValue2.source == "channels" then str2 else nil,
            friendId = if deepValue2.source == "friends" then str2 else nil
        }
        local var2 = arg1:dispatch(api(tbl1))

        if FFlagAppChatConversationTrustedFriendUpsellBanner then
            var2 = seedConversationTopModalFromRequest(var2, str1)
        end

        var2:catch(function(arg2)
            var1:warning(
                `refreshConversationUnfilteredThreadsDetails: Error in GetModalSequence -> conversationTopModal request. Error: {tostring(arg2)}`
            )
        end)

        local api2 = AppChatNetworking.rodux.GetModalSequence.API
        local tbl2 = {
            modalSequence = AppChatNetworking.Constants.ModalSequence.ConversationOverlay,
            isInExperience = isInExperience,
            conversationId = if deepValue2.source == "channels" then str2 else nil,
            friendId = 0
        }

        if deepValue2.source ~= "friends" then
            str2 = nil
        end

        tbl2.friendId = str2

        arg1:dispatch(api2(tbl2)):catch(function(arg2)
            var1:warning(
                `refreshConversationUnfilteredThreadsDetails: Error in GetModalSequence -> conversationOverlay request. Error: {tostring(arg2)}`
            )
        end)
    end
end

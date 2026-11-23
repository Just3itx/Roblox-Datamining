-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local Cryo = require(AppChatParent.Cryo)
local Promise = require(AppChatParent.Promise)
local getDeepValue = require(AppChat.Utils.getDeepValue)
local multiGetConversationDetails = require(AppChat.Conversations.Thunks.multiGetConversationDetails)
local var1 = require(AppChat.Logger):new(script.Name)
local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local refreshConversationUnfilteredThreadsDetails = require(script.Parent.refreshConversationUnfilteredThreadsDetails)

local FIntUnfilteredThreadsPvDelayMs = require(AppChat.Flags.FIntUnfilteredThreadsPvDelayMs)

return function(str1: string?, bool1: boolean?)
    return function(arg1)
        local state = arg1:getState()
        local deepValue = getDeepValue(state, "ChatAppReducer.Conversations") or {}
        local var2 = Cryo.List.filterMap(Cryo.Dictionary.values(deepValue), function(arg2)
            return if arg2 and arg2.id and arg2.source ~= "friends" then arg2.id else nil
        end)

        return Promise.delay(FIntUnfilteredThreadsPvDelayMs / 1000):andThen(function()
            if var2 then
                arg1:dispatch(multiGetConversationDetails(var2)):catch(function(arg2)
                    var1:warning("Error in multiGetConversationDetails thunk. Error: {}", tostring(arg2))
                end)
            end
            arg1:dispatch(AppChatNetworking.rodux.GetChatLandingModal.API(bool1)):catch(function(arg2)
                var1:warning("Error in GetChatLandingModal request. Error: {}", tostring(arg2))
            end)

            if str1 then
                arg1:dispatch(refreshConversationUnfilteredThreadsDetails(str1, bool1))
            end
        end)
    end
end

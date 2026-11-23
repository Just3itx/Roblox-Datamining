-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")

local AppChatNetworking = require(AppChat.Parent.AppChatNetworking)
local getDeepValue = require(AppChat.Utils.getDeepValue)

local Logger = require(AppChat.Logger)

local function markConversationAsRead(arg1)
    return function(arg2)
        local deepValue = getDeepValue(arg2:getState(), string.format("ChatAppReducer.Conversations.%s", arg1 or ""))
        if deepValue and deepValue.hasUnreadMessages then
            Logger:info("Marking conversation {} as read", arg1)
            arg2:dispatch(AppChatNetworking.rodux.MarkConversation.API(arg1)):catch(function(arg3)
                Logger:error(`AppChatNetworking failure in markConversationAsRead, Status: {tostring(arg3)}`)
            end)
        end
    end
end

return markConversationAsRead

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local Cryo = require(AppChatParent.Cryo)
local Promise = require(AppChatParent.Promise)

local processConversations = require(script.Parent.processConversations)

return function(arg1)
    return function(arg2)
        if not arg1 or #arg1 == 0 then
            return Promise.resolve({})
        end
        local tbl1 = {}
        local getConversations = AppChatNetworking.Constants.PageSize.GET_CONVERSATIONS
        for i = 1, #arg1, getConversations do
            local range = Cryo.List.getRange(arg1, i, i + getConversations - 1)
            local api = AppChatNetworking.rodux.MultiGetConversationDetails.API
            table.insert(tbl1, arg2:dispatch(api(range)))
        end
        return Promise.all(tbl1):andThen(function(arg3)
            return Cryo.List.foldLeft(arg3, function(arg4, arg5)
                local conversations = arg5 and arg5.responseBody and arg5.responseBody.conversations
                if not conversations then
                    return arg4
                end
                return Cryo.List.join(arg4, conversations)
            end, {})
        end):tap(function(arg3)
            arg2:dispatch(processConversations(arg3))
        end)
    end
end

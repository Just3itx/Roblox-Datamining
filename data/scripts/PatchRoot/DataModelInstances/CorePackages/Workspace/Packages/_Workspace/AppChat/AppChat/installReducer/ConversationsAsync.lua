-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T09:51:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local Rodux = require(AppChatParent.Rodux)

local NetworkingChat = require(AppChat.Http.NetworkingChat)

local Immutable = require(AppChatParent.AppCommonLib).Immutable

local createReducer = Rodux.createReducer
local tbl1 = {}
tbl1[NetworkingChat.GetUserConversations.Succeeded.name] = function(arg1, arg2)
    if #arg2.responseBody < arg2.queryArgs.pageSize then
        return Immutable.JoinDictionaries(arg1, { oldestConversationIsFetched = true })
    end
    return arg1
end

tbl1[AppChatNetworking.rodux.GetUserConversations.Succeeded.name] = function(arg1, arg2)
    local nextCursor = arg2.responseBody.next_cursor
    if nextCursor == nil or nextCursor == "" then
        return Immutable.JoinDictionaries(arg1, { oldestConversationIsFetched = true })
    end
    return arg1
end

return createReducer({}, tbl1)

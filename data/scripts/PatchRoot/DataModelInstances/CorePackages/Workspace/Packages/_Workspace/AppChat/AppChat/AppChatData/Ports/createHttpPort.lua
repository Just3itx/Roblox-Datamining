-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local AppChatNetworking = require(AppChatParent.AppChatNetworking)
local _Http = require(AppChatParent.Http)
local _LuauPolyfill = require(AppChatParent.LuauPolyfill)

local function createHttpPort(func1: ((...any) -> (...any))?)
    local http = AppChatNetworking.http

    local function requestFor(str1: string): ((string, string, any) -> any)? -- Luacid: Inlined by compiler; 10 call sites recovered
        return if func1 == nil then nil else function(str2: string, str3: string, arg1)
            return func1(str1, str2, str3, arg1)
        end
    end

    return {
        SendChatTextMessage = function(arg1, arg2, arg3)
            return http.SendChatTextMessage(requestFor("SendChatTextMessage"), arg1, arg2, arg3)
        end,
        GetConversationMessages = function(arg1, arg2)
            return http.GetConversationMessages(requestFor("GetConversationMessages"), arg1, arg2)
        end,
        GetUserConversations = function(arg1)
            return http.GetUserConversations(requestFor("GetUserConversations"), arg1)
        end,
        GetConversations = function(arg1, arg2)
            return http.GetConversations(requestFor("GetConversations"), arg1, arg2)
        end,
        SearchConversations = function(arg1, arg2, arg3)
            return http.SearchConversations(requestFor("SearchConversations"), arg1, arg2, arg3)
        end,
        CreateConversation = function(arg1, arg2, arg3)
            return http.CreateConversation(requestFor("CreateConversation"), arg1, arg2, arg3)
        end,
        MarkConversationRead = function(arg1)
            return http.MarkConversationRead(requestFor("MarkConversationRead"), arg1)
        end,
        ClearGlobalUnreadCount = function()
            return http.ClearGlobalUnreadCount((requestFor("ClearGlobalUnreadCount")))
        end,
        RecordModalSequenceResponse = function(arg1)
            return http.RecordModalSequenceResponse(requestFor("RecordModalSequenceResponse"), arg1)
        end,
        GetMetadata = function()
            return http.GetMetadata((requestFor("GetMetadata")))
        end
    }
end

return createHttpPort

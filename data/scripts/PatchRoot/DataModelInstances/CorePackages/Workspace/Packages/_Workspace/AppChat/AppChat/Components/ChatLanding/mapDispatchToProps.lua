-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:11:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local RoactPaginator = require(AppChat.SocialLibraries).RoactPaginator
local Promise = require(AppChatParent.Promise)

local fetchConversationsByPage = require(AppChat.Conversations.Thunks.fetchConversationsByPage)

return function(func1: (...any) -> (...any))
    local module = {}
    module[RoactPaginator.fetchInit] = function()
        return func1(fetchConversationsByPage())
    end

    module[RoactPaginator.fetchWithCursor] = function(arg1)
        return Promise.new(function(callback)
            coroutine.wrap(function()
                local var1, var2, var3 = func1(fetchConversationsByPage(arg1)):await()
                if var1 then
                    callback(var2, var3)
                    return
                end
                callback(nil, arg1)
            end)()
        end)
    end

    return module
end

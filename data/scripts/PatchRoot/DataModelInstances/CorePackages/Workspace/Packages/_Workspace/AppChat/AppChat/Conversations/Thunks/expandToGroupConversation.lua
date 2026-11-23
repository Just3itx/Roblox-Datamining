-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local AppChatNetworking = require(AppChatParent.AppChatNetworking)

local parseNewConversationResponse = require(script.Parent.Parent.parseNewConversationResponse)

return function(str1: string, tbl1, arg1)
    return function(arg2)
        return arg2:dispatch(AppChatNetworking.rodux.ExpandToGroupConversation.API(str1, tbl1)):andThen(function(arg3)
            return parseNewConversationResponse(arg3.responseBody.new_conversation, arg1, "userExpandedToGroupConversation")
        end)
    end
end

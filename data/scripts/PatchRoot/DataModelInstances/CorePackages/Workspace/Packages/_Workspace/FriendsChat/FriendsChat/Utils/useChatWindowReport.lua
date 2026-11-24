-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextChatService = game:GetService("TextChatService")

local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)

local function useChatWindowReport(callback: ((...any) -> (...any))?)
    return React.useCallback(function(arg1)
        local chatWindowConfiguration = TextChatService:FindFirstChildOfClass("ChatWindowConfiguration")
        if chatWindowConfiguration and callback then
            callback(arg1, chatWindowConfiguration)
        end
    end, { callback })
end

return useChatWindowReport

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:00:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)

local FriendsChatDependencyContext = require(script.Parent.FriendsChatDependencyContext)

local function useChatWindow()
    local var1 = React.useContext(FriendsChatDependencyContext)
    if var1 == nil then
        error("useChatWindow must be used within a FriendsChatDependencyBridge")
    end
    return var1.ChatWindow
end

return useChatWindow

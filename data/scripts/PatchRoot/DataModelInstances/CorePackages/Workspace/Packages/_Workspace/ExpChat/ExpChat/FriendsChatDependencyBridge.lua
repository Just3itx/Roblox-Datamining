-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")
local ExpChatParent = ExpChat.Parent

local React = require(ExpChatParent.React)

local ChatWindow = require(ExpChat.ChatWindow.UI.ChatWindow)
local FriendsChatDependencyContext = require(ExpChatParent.FriendsChat.FriendsChatDependencyContext)

local value = { ChatWindow = ChatWindow }

local function FriendsChatDependencyBridge(tbl2)
    return React.createElement(FriendsChatDependencyContext.Provider, { value = value }, tbl2.children)
end

return FriendsChatDependencyBridge

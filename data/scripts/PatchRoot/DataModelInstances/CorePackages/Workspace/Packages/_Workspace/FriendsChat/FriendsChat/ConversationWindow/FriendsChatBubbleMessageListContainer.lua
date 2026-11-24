-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local React = require(FriendsChatParent.React)

local useFriendsChatBubbleMessageListViewModel = require(script.Parent.useFriendsChatBubbleMessageListViewModel)
local FriendsChatBubbleMessageListView = require(script.Parent.FriendsChatBubbleMessageListView)

local function FriendsChatBubbleMessageListContainer(arg1)
    local var1 = useFriendsChatBubbleMessageListViewModel(arg1)
    return React.createElement(FriendsChatBubbleMessageListView, var1)
end

return FriendsChatBubbleMessageListContainer

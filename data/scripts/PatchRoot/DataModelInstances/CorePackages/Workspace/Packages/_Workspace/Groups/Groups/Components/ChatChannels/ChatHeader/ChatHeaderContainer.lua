-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:40:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent

local React = require(GroupsParent.React)
local ChatHeaderView = require(script.Parent.ChatHeaderView)
local useChatHeaderViewModel = require(script.Parent.useChatHeaderViewModel)

local function ChatHeaderContainer(arg1)
    local var1 = useChatHeaderViewModel(arg1)
    return React.createElement(ChatHeaderView, var1)
end

return ChatHeaderContainer

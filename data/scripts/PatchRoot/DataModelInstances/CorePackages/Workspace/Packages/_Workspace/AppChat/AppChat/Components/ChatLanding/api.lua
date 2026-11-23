-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local React = require(AppChatParent.React)

return {
    ConversationListViewRecycler = function(arg1)
        local conversationListViewRecycler = require(script.Parent.ConversationListViewRecycler)

        return React.createElement(conversationListViewRecycler, arg1)
    end,
    ConversationRow = require(script.Parent.ConversationRow)
}

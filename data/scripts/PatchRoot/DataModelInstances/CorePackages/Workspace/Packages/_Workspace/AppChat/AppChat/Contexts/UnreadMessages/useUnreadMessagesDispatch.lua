-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent
local React = require(AppChatParent.React)

local UnreadMessagesDispatchContext = require(script.Parent.UnreadMessagesDispatchContext)

local function useUnreadMessagesDispatch()
    return React.useContext(UnreadMessagesDispatchContext)
end

return useUnreadMessagesDispatch

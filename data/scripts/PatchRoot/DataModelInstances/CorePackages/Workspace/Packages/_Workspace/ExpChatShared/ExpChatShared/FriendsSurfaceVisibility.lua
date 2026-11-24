-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:21:21Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatSharedParent = script:FindFirstAncestor("ExpChatShared").Parent

local getVisibleConversationId, setVisibleConversationId = require(ExpChatSharedParent.Signals).createSignal(nil)

return {
    getVisibleConversationId = getVisibleConversationId,
    setVisibleConversationId = setVisibleConversationId
}

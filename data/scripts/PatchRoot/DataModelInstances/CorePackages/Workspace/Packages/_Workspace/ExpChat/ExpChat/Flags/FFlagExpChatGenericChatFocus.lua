-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:30:41Z
-- Luau bytecode version: 14 | Luau type version: 3
local ExpChatParent = script:FindFirstAncestor("ExpChat").Parent
local SharedFlags = require(ExpChatParent.SharedFlags)

return game:DefineFastFlag("ExpChatGenericChatFocusRC1", false) and SharedFlags.FFlagFriendsChatConversationListFocusNav

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T08:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ExpChat = script:FindFirstAncestor("ExpChat")

local GetMessagesStore = require(ExpChat.Stores.GetMessagesStore)

return function(arg1)
    GetMessagesStore(false).handleLegacyBubbleCreated(arg1)
end

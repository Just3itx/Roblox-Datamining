-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:10:48Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local FFlagChatInputBarGuardInvalidUtf8 = require(FriendsChatParent.SharedFlags).FFlagChatInputBarGuardInvalidUtf8

return game:DefineFastFlag("FriendsChatEnforceInputCharacterLimit2", false) and FFlagChatInputBarGuardInvalidUtf8

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T12:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsCallingParent = script:FindFirstAncestor("FriendsCalling").Parent

return require(FriendsCallingParent.Loggers).Logger:new("FriendsCalling")

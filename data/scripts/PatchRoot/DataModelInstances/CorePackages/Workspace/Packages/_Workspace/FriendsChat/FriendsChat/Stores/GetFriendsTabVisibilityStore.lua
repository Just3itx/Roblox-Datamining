-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T13:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsChatParent = script:FindFirstAncestor("FriendsChat").Parent

local Signals = require(FriendsChatParent.Signals)

local createFriendsTabVisibilityStore = require(script.createFriendsTabVisibilityStore)

return Signals.createComputed(createFriendsTabVisibilityStore)

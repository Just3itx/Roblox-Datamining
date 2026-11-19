-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T15:20:38Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagFriendsStoreSortOnlineFriendsByRank = require(script.Parent.FFlagFriendsStoreSortOnlineFriendsByRank)
local FFlagDataHydrationAccountReset = require(script.Parent.FFlagDataHydrationAccountReset)

return game:DefineFastFlag("SduiSocialDataMigrateOffLegacyPresence2", false)
    and FFlagFriendsStoreSortOnlineFriendsByRank
    and FFlagDataHydrationAccountReset

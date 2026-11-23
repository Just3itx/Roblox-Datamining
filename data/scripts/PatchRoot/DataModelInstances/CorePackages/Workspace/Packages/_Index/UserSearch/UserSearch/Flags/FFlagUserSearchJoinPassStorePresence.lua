-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserSearch = script:FindFirstAncestor("UserSearch")

local FFlagUserSearchPresenceStoreMigration = require(UserSearch.Flags.FFlagUserSearchPresenceStoreMigration)

return game:DefineFastFlag("UserSearchJoinPassStorePresence", false) and FFlagUserSearchPresenceStoreMigration

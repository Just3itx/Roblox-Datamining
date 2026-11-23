-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:11:00Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserSearch = script:FindFirstAncestor("UserSearch")
local UserSearchParent = UserSearch.Parent

local RODUX_KEY = require(UserSearch.Common.Constants).RODUX_KEY
return require(UserSearchParent.RoduxFriends).config({ keyPath = RODUX_KEY .. ".Friends" })

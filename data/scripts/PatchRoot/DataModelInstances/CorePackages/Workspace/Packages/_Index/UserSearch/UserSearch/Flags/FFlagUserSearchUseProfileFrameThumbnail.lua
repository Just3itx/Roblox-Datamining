-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserSearchParent = script:FindFirstAncestor("UserSearch").Parent
local GetFFlagProfileFrameThumbnailEnabled = require(UserSearchParent.SharedFlags).GetFFlagProfileFrameThumbnailEnabled

return game:DefineFastFlag("UserSearchUseProfileFrameThumbnail", false) and GetFFlagProfileFrameThumbnailEnabled()

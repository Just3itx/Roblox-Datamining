-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local FriendsMenuParent = script:FindFirstAncestor("FriendsMenu").Parent
local GetFFlagProfileFrameThumbnailEnabled = require(FriendsMenuParent.SharedFlags).GetFFlagProfileFrameThumbnailEnabled

return game:DefineFastFlag("FriendsMenuUseProfileFrameThumbnail", false) and GetFFlagProfileFrameThumbnailEnabled()

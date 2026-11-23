-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:41:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local UserTileParent = script:FindFirstAncestor("UserTile").Parent
local GetFFlagProfileFrameThumbnailEnabled = require(UserTileParent.SharedFlags).GetFFlagProfileFrameThumbnailEnabled

return game:DefineFastFlag("UserTileIncludeProfileFrameProp", false) and GetFFlagProfileFrameThumbnailEnabled()

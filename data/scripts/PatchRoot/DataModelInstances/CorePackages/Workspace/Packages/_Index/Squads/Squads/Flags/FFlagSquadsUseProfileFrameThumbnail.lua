-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local SquadsParent = script:FindFirstAncestor("Squads").Parent
local GetFFlagProfileFrameThumbnailEnabled = require(SquadsParent.SharedFlags).GetFFlagProfileFrameThumbnailEnabled

return game:DefineFastFlag("SquadsUseProfileFrameThumbnail", false) and GetFFlagProfileFrameThumbnailEnabled()

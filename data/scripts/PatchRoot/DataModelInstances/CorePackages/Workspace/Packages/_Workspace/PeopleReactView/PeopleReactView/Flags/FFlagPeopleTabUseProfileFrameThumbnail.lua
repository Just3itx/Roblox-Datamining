-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent
local GetFFlagProfileFrameThumbnailEnabled = require(PeopleReactViewParent.SharedFlags).GetFFlagProfileFrameThumbnailEnabled

return game:DefineFastFlag("PeopleTabUseProfileFrameThumbnail", false) and GetFFlagProfileFrameThumbnailEnabled()

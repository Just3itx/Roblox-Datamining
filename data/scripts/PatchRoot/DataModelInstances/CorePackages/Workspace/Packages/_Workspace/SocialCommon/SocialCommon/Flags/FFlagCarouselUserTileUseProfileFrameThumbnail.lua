-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:11:40Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialCommonParent = script:FindFirstAncestor("SocialCommon").Parent
local GetFFlagProfileFrameThumbnailEnabled = require(SocialCommonParent.SharedFlags).GetFFlagProfileFrameThumbnailEnabled

return game:DefineFastFlag("CarouselUserTileUseProfileFrameThumbnail", false) and GetFFlagProfileFrameThumbnailEnabled()

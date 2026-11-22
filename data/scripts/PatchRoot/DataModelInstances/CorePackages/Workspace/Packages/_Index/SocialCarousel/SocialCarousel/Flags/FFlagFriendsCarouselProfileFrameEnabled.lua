-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T18:01:26Z
-- Luau bytecode version: 14 | Luau type version: 3
local SocialCarouselParent = script:FindFirstAncestor("SocialCarousel").Parent
local GetFFlagProfileFrameThumbnailEnabled = require(SocialCarouselParent.SharedFlags).GetFFlagProfileFrameThumbnailEnabled

return game:DefineFastFlag("FriendsCarouselProfileFrameEnabled", false) and GetFFlagProfileFrameThumbnailEnabled()

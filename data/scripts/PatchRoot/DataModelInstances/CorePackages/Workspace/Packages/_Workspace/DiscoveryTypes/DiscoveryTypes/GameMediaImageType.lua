-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
local DiscoveryTypesParent = script:FindFirstAncestor("DiscoveryTypes").Parent

return {
    Image = 1,
    YouTubeVideo = 33,
    Video = if require(DiscoveryTypesParent.SharedFlags).FFlagLuaAppEdpMediaGalleryVideoPreview then 62 else nil,
    GamePreviewVideo = 86
}

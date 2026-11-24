-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
local DiscoveryTypesParent = script:FindFirstAncestor("DiscoveryTypes").Parent
return {
    Game = "Game",
    CatalogAsset = "CatalogAsset",
    CatalogBundle = "CatalogBundle",
    RecommendedFriend = "RecommendedFriend",
    GameCoPlay = "GameCoPlay",
    TrendingSearches = "TrendingSearches",
    Song = "Song",
    AdLink = if require(DiscoveryTypesParent.SharedFlags).FFlagLuaAppEnableNxMRoduxApportioning then "AdLink" else nil
}

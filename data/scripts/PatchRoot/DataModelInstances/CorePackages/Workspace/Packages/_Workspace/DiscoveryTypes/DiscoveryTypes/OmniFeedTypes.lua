-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T05:51:12Z
-- Luau bytecode version: 14 | Luau type version: 3
local DiscoveryTypesParent = script:FindFirstAncestor("DiscoveryTypes").Parent

return {
    GenreExplorer = "GenreExplorerLabel",
    Carousel = "Carousel",
    AvatarCarousel = "AvatarCarousel",
    UserInfo = "UserInfo",
    FriendCarousel = "FriendCarousel",
    FriendRecommendationCarousel = "FriendRecommendationCarousel",
    HomeGameGrid = "SortlessGrid",
    JoinYourFriendsCarousel = "JoinYourFriendsCarousel",
    ServerDrivenUi = "sdui",
    ServerDrivenUiV2 = "SduiV2",
    SearchGameGrid = "SearchGameGrid",
    SearchText = "SearchText",
    UpsellCard = "UpsellCard",
    Prompts = "Prompts",
    UserSearchGrid = "UserSearchGrid",
    Pills = "Pills",
    SearchPillCarousel = "SearchPillCarousel",
    SongCarousel = if require(DiscoveryTypesParent.SharedFlags).FFlagEnableTopSongsSort then "SongCarousel" else nil
}

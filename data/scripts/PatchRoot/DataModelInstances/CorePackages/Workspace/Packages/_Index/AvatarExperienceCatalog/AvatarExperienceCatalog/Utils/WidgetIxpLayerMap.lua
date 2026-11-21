-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:21:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local AppUserLayers = require(AvatarExperienceCatalogParent.ExperimentLayers).AppUserLayers

return {
    TrendingWidget = AppUserLayers.AvatarMarketplaceALGOONLYTrendingWidget,
    ThemedAvatarItemsWidget = AppUserLayers.AvatarMarketplaceALGOONLYThematicWidget,
    PersonalizedAvatarLooksWidget = AppUserLayers.AvatarMarketplaceALGOONLYAvatarWidget,
    PopularAmongFriendsWidget = AppUserLayers.AvatarMarketplaceALGOONLYFriendsWidget,
    CurationWidget = AppUserLayers.AvatarMarketplaceALGOONLYCurationWidget
}

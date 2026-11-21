-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:11:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local FFlagAXCatalogOffersBannerEnabled = require(AvatarExperienceCatalogParent.AvatarExperienceFlags).FFlagAXCatalogOffersBannerEnabled

local createAXShoppingCartStore = require(AvatarExperienceCatalog.Stores.createAXShoppingCartStore)
local createCatalogOffersBannerStore = require(AvatarExperienceCatalog.Stores.createCatalogOffersBannerStore)

local function getCatalogStores()
    return {
        shoppingCartStore = createAXShoppingCartStore(),
        catalogOffersBannerStore = if FFlagAXCatalogOffersBannerEnabled then createCatalogOffersBannerStore() else nil
    }
end

return getCatalogStores

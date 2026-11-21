-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent

local React = require(AvatarExperienceCatalogParent.React)

local _MarketplaceOffersBannerTypes = require(AvatarExperienceCatalog.Api.GetMarketplaceOffersBanner.MarketplaceOffersBannerTypes)
local _createCatalogOffersBannerStore = require(AvatarExperienceCatalog.Stores.createCatalogOffersBannerStore)
local catalogOffersBannerAppStorage = require(AvatarExperienceCatalog.Utils.catalogOffersBannerAppStorage)

local function useCatalogOffersBannerDismissHydration(arg1, arg2)
    React.useLayoutEffect(function()
        if arg2 == nil then
            return
        end

        if catalogOffersBannerAppStorage.shouldHydrateDismissed(arg2) then
            arg1.setDismissed(true)
        else
            arg1.setDismissed(false)
        end
    end, { arg2, arg1 })
end

return useCatalogOffersBannerDismissHydration

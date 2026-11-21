-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local Url = require(AvatarExperienceCatalogParent.Http).Url
local _LuauPolyfill = require(AvatarExperienceCatalogParent.LuauPolyfill)

local makeAXResponseHandler = require(AvatarExperienceCatalog.Utils.makeAXResponseHandler)
local normalizeMarketplaceOffersBannerResponse = require(script.Parent.normalizeMarketplaceOffersBannerResponse)
local _MarketplaceOffersBannerTypes = require(script.Parent.MarketplaceOffersBannerTypes)
local constants = require(script.Parent.constants)

return {
    getMarketplaceOffersBanner = function(userId: string, func1: (...any) -> (...any), str1: string?)
        local featureKey = if str1 == "cart" then constants.OFFERS_FOR_USER_FEATURE_KEY_CART else constants.OFFERS_FOR_USER_FEATURE_KEY_FEED
        local var2 = Url:makeQueryString({ userId = userId, featureKey = featureKey })

        local var3, var4 = func1(`{Url.APIS_URL}{constants.OFFERS_V1_RELATIVE_PATH}?{var2}`, "GET")
        return makeAXResponseHandler(var3, normalizeMarketplaceOffersBannerResponse, {
            modelMismatchCounter = constants.FETCH_MARKETPLACE_OFFERS_BANNER_MODEL_MISMATCH_COUNTER_NAME,
            latencyCounter = constants.FETCH_MARKETPLACE_OFFERS_BANNER_LATENCY_COUNTER_NAME
        }), var4
    end
}

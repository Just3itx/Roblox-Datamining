-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _MarketplaceOffersBannerTypes = require(script.Parent.MarketplaceOffersBannerTypes)

local function getMarketplaceOffersBannerOfferDisplayTitle(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return arg1.localizedText
end

return {
    getMarketplaceOffersBannerOfferDisplayTitle = getMarketplaceOffersBannerOfferDisplayTitle,
    getMarketplaceOffersBannerOfferDisplayId = function(arg1)
        return arg1.offerId
    end,
    marketplaceOffersBannerPayloadHasRenderableOffer = function(arg1)
        for _, offer in arg1.offers do
            if getMarketplaceOffersBannerOfferDisplayTitle(offer) ~= nil then
                return true
            end
        end
        return false
    end
}

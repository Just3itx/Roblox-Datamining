-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalog = script:FindFirstAncestor("AvatarExperienceCatalog")
local HttpService = game:GetService("HttpService")

local AvatarExperienceCatalogParent = AvatarExperienceCatalog.Parent
local Url = require(AvatarExperienceCatalogParent.Http).Url
local _LuauPolyfill = require(AvatarExperienceCatalogParent.LuauPolyfill)

local makeAXResponseHandler = require(AvatarExperienceCatalog.Utils.makeAXResponseHandler)
local normalizeCartPricingForOffersResponse = require(script.Parent.normalizeCartPricingForOffersResponse)
local _CartPricingForOffersTypes = require(script.Parent.CartPricingForOffersTypes)
local constants = require(script.Parent.constants)

local function postCartPricingForOffers(func1: (...any) -> (...any), input)
    local var1, var2 = func1(`{Url.APIS_URL}{constants.CART_PRICING_URL}`, "POST", { postBody = HttpService:JSONEncode(input) })
    return makeAXResponseHandler(var1, normalizeCartPricingForOffersResponse, {
        modelMismatchCounter = constants.POST_CART_PRICING_FOR_OFFERS_MODEL_MISMATCH_COUNTER_NAME,
        latencyCounter = constants.POST_CART_PRICING_FOR_OFFERS_LATENCY_COUNTER_NAME
    }), var2
end

return postCartPricingForOffers

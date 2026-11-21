-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local normalize = AvatarExperienceCommon.Utils.normalize
local normalizeBoolean = normalize.normalizeBoolean
local normalizeNumber = normalize.normalizeNumber
local normalizeNotEmptyString = normalize.normalizeNotEmptyString
local makeNormalizeTableFn = normalize.makeNormalizeTableFn
local makeNormalizeListFn = normalize.makeNormalizeListFn
local makeRequired = normalize.makeRequired

local _CartPricingForOffersTypes = require(script.Parent.CartPricingForOffersTypes)

local FFlagAXUpdateOffersEndsUIWithBadge = AvatarExperienceFlags.FFlagAXUpdateOffersEndsUIWithBadge

local fn = makeNormalizeTableFn({
    discounts = {
        fn = makeNormalizeListFn(
            (makeNormalizeTableFn({
                discountCampaign = { fn = normalizeNotEmptyString },
                localizedDiscountAttribution = { fn = normalizeNotEmptyString },
                robuxDiscountAmount = { fn = normalizeNumber },
                robuxDiscountPercentage = { fn = normalizeNumber }
            }))
        )
    },
    originalPrice = { fn = normalizeNumber },
    totalDiscountAmount = { fn = normalizeNumber },
    totalDiscountPercentage = { fn = normalizeNumber }
})

local normalizeTableFn2 = makeNormalizeTableFn({
    collectibleItemId = makeRequired(normalizeNotEmptyString),
    discountInformation = { fn = fn },
    priceInRobux = { fn = normalizeNumber },
    regularPriceInRobux = { fn = normalizeNumber }
})
local normalizeTableFn3 = if FFlagAXUpdateOffersEndsUIWithBadge then makeNormalizeTableFn({
    expirationTimeUtc = { fn = normalizeNotEmptyString },
    localizedDescription = { fn = normalizeNotEmptyString },
    offerId = makeRequired(normalizeNotEmptyString),
    selected = { fn = normalizeBoolean }
}) else makeNormalizeTableFn({
    localizedDescription = { fn = normalizeNotEmptyString },
    offerId = makeRequired(normalizeNotEmptyString),
    selected = { fn = normalizeBoolean }
})

local function normalizeCartPricingForOffersResponse(arg1)
    if arg1 == nil then
        return nil, nil
    end

    if type(arg1) ~= "table" then
        return nil, "CartPricingForOffers: unexpected response body type"
    end

    local tbl1 = {
        items = {}
    }
    local tbl2 = {}

    if arg1.items ~= nil then
        local items, var2 = makeNormalizeListFn(normalizeTableFn2)(arg1.items)
        if var2 then
            table.insert(tbl2, `items normalization failed with: {var2}`)
        end
        tbl1.items = items
    end

    if arg1.availableOffers ~= nil then
        local availableOffers, var2 = makeNormalizeListFn(normalizeTableFn3)(arg1.availableOffers)
        if var2 then
            table.insert(tbl2, `availableOffers normalization failed with: {var2}`)
        end
        tbl1.availableOffers = availableOffers
    end

    tbl1.savingsSummary = normalizeNotEmptyString(arg1.savingsSummary)

    return tbl1, if next(tbl2) then table.concat(tbl2, " ") else nil
end

return normalizeCartPricingForOffersResponse

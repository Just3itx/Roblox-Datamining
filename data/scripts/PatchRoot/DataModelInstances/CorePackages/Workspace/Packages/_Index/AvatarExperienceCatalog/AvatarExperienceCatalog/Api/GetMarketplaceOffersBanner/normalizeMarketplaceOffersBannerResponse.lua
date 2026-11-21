-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T01:41:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent
local AvatarExperienceCommon = require(AvatarExperienceCatalogParent.AvatarExperienceCommon)
local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)
local normalize = AvatarExperienceCommon.Utils.normalize
local normalizeNotEmptyString = normalize.normalizeNotEmptyString
local makeNormalizeTableFn = normalize.makeNormalizeTableFn
local makeRequired = normalize.makeRequired

local _MarketplaceOffersBannerTypes = require(script.Parent.MarketplaceOffersBannerTypes)
local decodeLuauUnicodeEscapes = require(script.Parent.decodeLuauUnicodeEscapes)

local FFlagAXUpdateOffersEndsUIWithBadge = AvatarExperienceFlags.FFlagAXUpdateOffersEndsUIWithBadge

local function normalizeDisplayString(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1, var2 = normalizeNotEmptyString(arg1)
    if var1 == nil then
        return nil, var2
    end
    return decodeLuauUnicodeEscapes(var1), nil
end

local normalizeTableFn = makeNormalizeTableFn({
    modalTitle = makeRequired(normalizeDisplayString),
    offerBodyLinkText = makeRequired(normalizeDisplayString),
    modalHeroIcon = normalizeNotEmptyString,
    termsBody = normalizeDisplayString,
    termsModalTitle = normalizeDisplayString
})

local function normalizeModalForOfferRow(tbl1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = nil
    if type(tbl1.modal) == "table" then
        tbl1 = tbl1.modal
    elseif normalizeNotEmptyString(tbl1.modalTitle) == nil then
        tbl1 = var1
    end

    if not tbl1 then
        return nil
    end

    local var2 = normalizeTableFn(tbl1)
    return if var2 and var2.modalTitle and var2.offerBodyLinkText then var2 else nil
end

local function normalizeOfferRow(arg1)
    if type(arg1) ~= "table" then
        return nil, `expected offer row to be a table, got {type(arg1)}`
    end

    local icon = normalizeNotEmptyString(arg1.icon)
    local localizedText, _ = normalizeDisplayString(arg1.localizedText)
    local offerId = normalizeNotEmptyString(arg1.offerId)
    local expirationTimeInUtc = if FFlagAXUpdateOffersEndsUIWithBadge then normalizeNotEmptyString(arg1.expirationTimeInUTC) else nil

    if not (icon or localizedText or offerId) then
        return nil, "offer row has no recognized identity fields (icon, localizedText, offerId)"
    end

    local tbl1 = {}
    if icon then
        tbl1.icon = icon
    end
    if localizedText then
        tbl1.localizedText = localizedText
    end
    if offerId then
        tbl1.offerId = offerId
    end
    if FFlagAXUpdateOffersEndsUIWithBadge and expirationTimeInUtc then
        tbl1.expirationTimeInUTC = expirationTimeInUtc
    end
    tbl1.modal = normalizeModalForOfferRow(arg1)
    return tbl1, nil
end

local function normalizeMarketplaceOffersBannerResponse(arg1)
    if arg1 == nil then
        return nil, nil
    elseif type(arg1) ~= "table" then
        return nil, `MarketplaceOffersBanner: expected response body to be a table, got {type(arg1)}`
    else
        local offers = arg1.offers
        if offers == nil then
            return nil, nil
        elseif type(offers) ~= "table" then
            return nil, `MarketplaceOffersBanner: expected 'offers' field to be a table, got {type(offers)}`
        elseif #offers == 0 then
            return nil, nil
        else
            local tbl1 = {}
            local tbl2 = {}
            for k, offer in offers do
                local var1, var2 = normalizeOfferRow(offer)
                if var2 then
                    table.insert(tbl1, `offers[{k}]: {var2}`)
                end
                if var1 then
                    table.insert(tbl2, var1)
                end
            end

            local var1 = if next(tbl1) then "MarketplaceOffersBanner: " .. table.concat(tbl1, "; ") else nil

            if #tbl2 == 0 then
                return nil, var1
            end

            return { offers = tbl2 }, var1
        end
    end
end

return normalizeMarketplaceOffersBannerResponse

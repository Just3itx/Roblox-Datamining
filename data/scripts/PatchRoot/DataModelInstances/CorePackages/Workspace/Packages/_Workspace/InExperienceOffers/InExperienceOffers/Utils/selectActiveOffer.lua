-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:40:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")

local FFlagOffersRespectExpiration = require(InExperienceOffers.Flags.FFlagOffersRespectExpiration)
local isOfferExpired = require(InExperienceOffers.Utils.isOfferExpired)

local _Types = require(InExperienceOffers.Types)

local function selectActiveOffer(tbl1, str1: string)
    if tbl1 == nil then
        return nil
    end
    for _, value in tbl1 do
        local presentationData = value.presentationData
        if value.offerStatus ~= "AVAILABLE"
            or presentationData == nil
            or presentationData[str1] == nil
            or FFlagOffersRespectExpiration and isOfferExpired(value)
        then
            continue
        end

        return {
            offerId = value.offerId,
            offerStatus = value.offerStatus,
            featureKeys = value.featureKeys,
            expirationTimeInUTC = value.expirationTimeInUTC,
            presentationData = presentationData
        }
    end

    return nil
end

return selectActiveOffer

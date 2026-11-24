-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")

local getOffersForKey = require(InExperienceOffers.Utils.getOffersForKey)
local selectActiveOffer = require(InExperienceOffers.Utils.selectActiveOffer)

local _Types = require(InExperienceOffers.Types)

local function getOfferBadgeText(arg1, str1: string?)
    if str1 == nil then
        return nil
    end

    local offersForKey = getOffersForKey(arg1, str1)
    local var1 = selectActiveOffer(offersForKey, "menuBadge")
    if var1 == nil then
        return nil
    end

    local menuBadge = var1.presentationData.menuBadge
    return if menuBadge == nil then nil else menuBadge.title
end

return getOfferBadgeText

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")
local InExperienceOffersParent = InExperienceOffers.Parent

local SignalsReact = require(InExperienceOffersParent.SignalsReact)

local GetOffersStore = require(InExperienceOffers.Stores.GetOffersStore)
local getOfferBadgeText = require(InExperienceOffers.Utils.getOfferBadgeText)

local function useOfferBadgeText(str1: string?)
    local var1 = SignalsReact.useSignalState(GetOffersStore(false).getOffers)
    return getOfferBadgeText(var1, str1)
end

return useOfferBadgeText

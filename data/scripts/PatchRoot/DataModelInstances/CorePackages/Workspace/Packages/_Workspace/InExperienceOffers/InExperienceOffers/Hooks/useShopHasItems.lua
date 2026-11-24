-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")
local InExperienceOffersParent = InExperienceOffers.Parent

local SignalsReact = require(InExperienceOffersParent.SignalsReact)

local GetOffersStore = require(InExperienceOffers.Stores.GetOffersStore)

local function useShopHasItems()
    return SignalsReact.useSignalState(GetOffersStore(false).getShopHasItems)
end

return useShopHasItems

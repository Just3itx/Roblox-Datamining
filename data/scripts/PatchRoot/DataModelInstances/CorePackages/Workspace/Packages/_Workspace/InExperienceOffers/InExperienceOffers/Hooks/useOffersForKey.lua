-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")
local InExperienceOffersParent = InExperienceOffers.Parent

local SignalsReact = require(InExperienceOffersParent.SignalsReact)

local GetOffersStore = require(InExperienceOffers.Stores.GetOffersStore)
local getOffersForKey = require(InExperienceOffers.Utils.getOffersForKey)

local _Types = require(InExperienceOffers.Types)

local function useOffersForKey(str1: string)
    local offersStore = GetOffersStore(false)
    local var1 = SignalsReact.useSignalState(offersStore.getOffers)
    return getOffersForKey(var1, str1)
end

return useOffersForKey

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")
local InExperienceOffersParent = InExperienceOffers.Parent

local Signals = require(InExperienceOffersParent.Signals)
local FFlagHideOfferNotificationsWhenShopEmpty = require(InExperienceOffersParent.SharedFlags).FFlagHideOfferNotificationsWhenShopEmpty

local GetOffersStore = require(InExperienceOffers.Stores.GetOffersStore)
local getOfferBadgeText = require(InExperienceOffers.Utils.getOfferBadgeText)

local function createOfferBadgeTextSignal(str1: string)
    return Signals.createComputed(function(arg1)
        if FFlagHideOfferNotificationsWhenShopEmpty and not GetOffersStore(false).getShopHasItems(arg1) then
            return nil
        end
        local var1 = GetOffersStore(false).getOffers(arg1)
        return getOfferBadgeText(var1, str1)
    end)
end

return createOfferBadgeTextSignal

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Chrome = script:FindFirstAncestor("Chrome")

local CorePackages = game:GetService("CorePackages")

local SignalsReact = require(CorePackages.Packages.SignalsReact)

local InExperienceOffers = require(CorePackages.Workspace.Packages.InExperienceOffers)

local useNineDotActivityIndicator = require(Chrome.ChromeShared.Hooks.useNineDotActivityIndicator)

local getOffersStore = InExperienceOffers.getOffersStore
local NotificationLocation = InExperienceOffers.NotificationLocation

local function useOfferNineDotActivityIndicator()
    local var1 = SignalsReact.useSignalState(getOffersStore(false).getOfferNotificationShownWithEnum)

    useNineDotActivityIndicator("in_experience_offers", var1 == NotificationLocation.Hamburger)
end

return useOfferNineDotActivityIndicator

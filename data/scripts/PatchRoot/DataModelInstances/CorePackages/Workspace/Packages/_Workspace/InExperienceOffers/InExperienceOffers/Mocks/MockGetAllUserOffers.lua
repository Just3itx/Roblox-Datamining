-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceOffers = script:FindFirstAncestor("InExperienceOffers")
local InExperienceOffersParent = InExperienceOffers.Parent

local Promise = require(InExperienceOffersParent.Promise)
local _Types = require(InExperienceOffers.Types)

local tbl1 = {
    offers = {
        {
            offerId = "mock-welcome-offer",
            offerStatus = "AVAILABLE",
            featureKeys = { "ROBLOX_SHOP", "MARKETPLACE_CART" },
            expirationTimeInUTC = "2030-01-01T00:00:00Z",
            presentationData = {
                {
                    type = "BANNER",
                    banner = {
                        title = "Sample banner offer",
                        icon = "rbxassetid://0",
                        modal = {
                            title = "Sample offer modal title",
                            body = "Sample offer description with terms.",
                            icon = "rbxassetid://0",
                            buttonText = "Shop now",
                            termsAndConditions = {
                                title = "Terms & Conditions",
                                body = "Sample terms and conditions.",
                                buttonText = "View terms"
                            }
                        }
                    }
                },
                {
                    type = "MENU_BADGE",
                    menuBadge = { title = "20% off" }
                },
                {
                    type = "TOOLTIP",
                    tooltip = { title = "Sample tooltip", buttonText = "Shop now" }
                }
            }
        },
        {
            offerId = "mock-no-terms-offer",
            offerStatus = "AVAILABLE",
            featureKeys = { "ROBLOX_SHOP" },
            expirationTimeInUTC = "2030-01-01T00:00:00Z",
            presentationData = {{
                type = "BANNER",
                banner = {
                    title = "Sample banner (no terms)",
                    icon = "rbxassetid://0",
                    modal = {
                        title = "Sample offer modal (no terms)",
                        body = "Sample offer description without terms.",
                        icon = "rbxassetid://0",
                        buttonText = "Shop now"
                    }
                }
            }}
        },
        {
            offerId = "mock-no-modal-offer",
            offerStatus = "AVAILABLE",
            featureKeys = { "ROBLOX_SHOP" },
            expirationTimeInUTC = "2030-01-01T00:00:00Z",
            presentationData = {{
                type = "BANNER",
                banner = { title = "Sample banner (no modal)", icon = "rbxassetid://0" }
            }}
        },
        {
            offerId = "mock-used-offer",
            offerStatus = "USED",
            featureKeys = { "ROBLOX_SHOP" },
            expirationTimeInUTC = "2030-01-01T00:00:00Z",
            presentationData = {{
                type = "BANNER",
                banner = { title = "Sample used offer", icon = "rbxassetid://0" }
            }}
        },
        {
            offerId = "mock-contentless-offer",
            offerStatus = "UNAVAILABLE",
            featureKeys = { "MARKETPLACE_CART" }
        }
    }
}

local function getAllUserOffersMock(_)
    return Promise.resolve(tbl1)
end

return getAllUserOffersMock

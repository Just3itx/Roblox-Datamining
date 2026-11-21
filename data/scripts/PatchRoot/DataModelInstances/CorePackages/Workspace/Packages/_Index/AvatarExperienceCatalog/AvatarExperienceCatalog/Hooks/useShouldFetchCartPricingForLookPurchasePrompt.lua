-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T02:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceCatalogParent = script:FindFirstAncestor("AvatarExperienceCatalog").Parent

local AvatarExperienceFlags = require(AvatarExperienceCatalogParent.AvatarExperienceFlags)

local useHasAtLeastOneCatalogOffer = require(script.Parent.useHasAtLeastOneCatalogOffer)

local function useShouldFetchCartPricingForLookPurchasePrompt(): boolean
    local var1 = useHasAtLeastOneCatalogOffer()

    return not not (not AvatarExperienceFlags.FFlagPurchasePromptCartPricingRequireOffer or var1)
end

return useShouldFetchCartPricingForLookPurchasePrompt

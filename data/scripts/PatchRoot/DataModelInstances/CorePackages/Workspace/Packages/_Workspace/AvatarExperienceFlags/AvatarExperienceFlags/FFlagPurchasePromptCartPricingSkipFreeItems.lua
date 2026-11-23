-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceFlagsParent = script:FindFirstAncestor("AvatarExperienceFlags").Parent
local FFlagMarketplaceOffersOptOutRoot = require(AvatarExperienceFlagsParent.SharedFlags).FFlagMarketplaceOffersOptOutRoot

return game:DefineFastFlag("PurchasePromptCartPricingSkipFreeItems2", false) and FFlagMarketplaceOffersOptOutRoot

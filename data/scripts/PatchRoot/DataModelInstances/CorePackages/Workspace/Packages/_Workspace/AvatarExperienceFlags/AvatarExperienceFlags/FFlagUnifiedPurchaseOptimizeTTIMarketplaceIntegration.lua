-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:11:02Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceFlagsParent = script:FindFirstAncestor("AvatarExperienceFlags").Parent

local FFlagUnifiedPurchaseOptimizeTTIMarketplace = require(AvatarExperienceFlagsParent.SharedFlags).FFlagUnifiedPurchaseOptimizeTTIMarketplace

return game:DefineFastFlag("UnifiedPurchaseOptimizeTTIMarketplaceIntegration", false)
    and FFlagUnifiedPurchaseOptimizeTTIMarketplace

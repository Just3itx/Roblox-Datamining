-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:31:19Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent
local FFlagEnableRobuxInExperienceShop = require(InExperienceShopParent.SharedFlags).FFlagEnableRobuxInExperienceShop

return game:DefineFastFlag("SkipPaymentSessionForPlainRobux", false) and FFlagEnableRobuxInExperienceShop

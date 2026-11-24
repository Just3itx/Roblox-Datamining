-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:30:43Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent
local FFlagEnableRobuxInExperienceShop = require(InExperienceShopParent.SharedFlags).FFlagEnableRobuxInExperienceShop

return game:DefineFastFlag("HideBonusInShopWhenNotClaimable", false) and FFlagEnableRobuxInExperienceShop

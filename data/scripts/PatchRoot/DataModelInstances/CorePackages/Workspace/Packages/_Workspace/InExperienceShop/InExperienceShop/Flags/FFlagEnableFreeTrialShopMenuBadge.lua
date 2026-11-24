-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

return game:DefineFastFlag("EnableFreeTrialShopMenuBadge", false)
    and require(script.Parent.FFlagLuaAppEnableGamePassFreeTrials)
    and require(InExperienceShopParent.SharedFlags).FFlagEnableCustomTextInMenuTrailingBadge

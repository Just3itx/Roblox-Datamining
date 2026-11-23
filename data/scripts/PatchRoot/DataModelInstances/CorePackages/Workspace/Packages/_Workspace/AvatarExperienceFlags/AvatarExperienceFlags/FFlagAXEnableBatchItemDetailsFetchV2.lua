-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceFlagsParent = script:FindFirstAncestor("AvatarExperienceFlags").Parent
return require(AvatarExperienceFlagsParent.SharedFlags).FFlagEnableInspectAndBuyV2RootFlag
    and game:DefineFastFlag("AXEnableBatchItemDetailsFetchV2", false)

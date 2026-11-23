-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:51:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceFlagsParent = script:FindFirstAncestor("AvatarExperienceFlags").Parent
local FFlagEnableMeTabProfile = require(AvatarExperienceFlagsParent.SharedFlags).FFlagEnableMeTabProfile
return game:DefineFastFlag("AXEnableFoundationSegmentedMenu", false) or FFlagEnableMeTabProfile

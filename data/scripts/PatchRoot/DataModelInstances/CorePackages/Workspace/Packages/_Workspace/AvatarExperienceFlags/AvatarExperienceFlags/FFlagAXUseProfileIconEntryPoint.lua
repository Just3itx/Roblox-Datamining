-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T16:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceFlagsParent = script:FindFirstAncestor("AvatarExperienceFlags").Parent
local SharedFlags = require(AvatarExperienceFlagsParent.SharedFlags)
local FFlagAXEnableProfileTab = SharedFlags.FFlagAXEnableProfileTab
local FFlagAXPPEReturnToEntrySurface = SharedFlags.FFlagAXPPEReturnToEntrySurface

return game:DefineFastFlag("AXUseProfileIconEntryPoint", false) and FFlagAXEnableProfileTab and FFlagAXPPEReturnToEntrySurface

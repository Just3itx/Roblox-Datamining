-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent
local FFlagAXCustomizeBackgrounds = require(ProfilePlatformParent.AvatarExperienceFlags).FFlagAXCustomizeBackgrounds

return game:DefineFastFlag("ProfilePlatformEditBackgroundMenuItem", false) and FFlagAXCustomizeBackgrounds

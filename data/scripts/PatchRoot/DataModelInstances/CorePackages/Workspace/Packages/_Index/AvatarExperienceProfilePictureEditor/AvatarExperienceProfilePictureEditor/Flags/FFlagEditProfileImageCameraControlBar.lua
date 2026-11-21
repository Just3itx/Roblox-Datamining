-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:41:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceProfilePictureEditorParent = script:FindFirstAncestor("AvatarExperienceProfilePictureEditor").Parent

local FFlagAXMigrateBuilderIcons = require(AvatarExperienceProfilePictureEditorParent.AvatarExperienceFlags).FFlagAXMigrateBuilderIcons

return game:DefineFastFlag("EditProfileImageCameraControlBar", false) and FFlagAXMigrateBuilderIcons

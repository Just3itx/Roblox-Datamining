-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T05:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatformParent = script:FindFirstAncestor("ProfilePlatform").Parent
local FFlagProfilePlatformNewProfileHeader = require(ProfilePlatformParent.SharedFlags).FFlagProfilePlatformNewProfileHeader

return game:DefineFastFlag("ProfilePlatformAboutBeforeActionClient", false) and FFlagProfilePlatformNewProfileHeader

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:38Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local LuaSocialLibrariesDeps = require(ProfilePlatformParent.LuaSocialLibrariesDeps)
local RODUX_KEY = require(ProfilePlatform.Common.Constants).RODUX_KEY

return (LuaSocialLibrariesDeps.RoduxPresence.config({ keyPath = RODUX_KEY .. ".Presence" }))

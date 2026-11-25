-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T06:01:34Z
-- Luau bytecode version: 14 | Luau type version: 3
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent
local LuaSocialLibrariesDeps = require(ProfilePlatformParent.LuaSocialLibrariesDeps)
local RODUX_KEY = require(ProfilePlatform.Common.Constants).RODUX_KEY

return (LuaSocialLibrariesDeps.RoduxGames.config({ keyPath = RODUX_KEY .. ".Games" }))

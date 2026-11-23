-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
local BuildExperience = script:FindFirstAncestor("BuildExperience")

local FFlagBuildWithGroups = require(BuildExperience.Flags.FFlagBuildWithGroups)

return game:DefineFastFlag("BuildExperienceCursorSearchPages", false) and FFlagBuildWithGroups

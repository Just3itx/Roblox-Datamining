-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:00:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local Signals = require(BuildExperienceParent.Signals)
local createAssistantBuildStore = require(script.createAssistantBuildStore)

return Signals.createComputed(createAssistantBuildStore)

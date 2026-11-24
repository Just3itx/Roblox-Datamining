-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T03:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createExperienceEventInfoStore = require(script.Parent.createExperienceEventInfoStore)

return Signals.createComputed(createExperienceEventInfoStore)

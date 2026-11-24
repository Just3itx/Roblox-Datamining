-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T04:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
local DataHydrationParent = script:FindFirstAncestor("DataHydration").Parent

local Signals = require(DataHydrationParent.Signals)

local createAgeRecommendationStore = require(script.Parent.createAgeRecommendationStore)

return Signals.createComputed(createAgeRecommendationStore)

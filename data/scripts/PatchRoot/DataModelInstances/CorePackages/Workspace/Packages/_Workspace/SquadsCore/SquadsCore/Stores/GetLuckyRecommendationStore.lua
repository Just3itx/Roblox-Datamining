-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T18:10:43Z
-- Luau bytecode version: 14 | Luau type version: 3
local SquadsCoreParent = script:FindFirstAncestor("SquadsCore").Parent
local Signals = require(SquadsCoreParent.Signals)

local createLuckyRecommendationStore = require(script.createLuckyRecommendationStore)

return Signals.createComputed(createLuckyRecommendationStore)

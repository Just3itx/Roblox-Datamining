-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:31:23Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceOffersParent = script:FindFirstAncestor("InExperienceOffers").Parent
local Signals = require(InExperienceOffersParent.Signals)
local createOffersStore = require(script.createOffersStore)

return Signals.createComputed(createOffersStore)

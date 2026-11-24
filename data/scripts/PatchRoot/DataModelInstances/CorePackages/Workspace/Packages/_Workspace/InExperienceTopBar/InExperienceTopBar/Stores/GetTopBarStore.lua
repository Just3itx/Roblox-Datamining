-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:11:03Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceTopBarParent = script:FindFirstAncestor("InExperienceTopBar").Parent
local Signals = require(InExperienceTopBarParent.Signals)
local createTopBarStore = require(script.createTopBarStore)

return Signals.createComputed(createTopBarStore)

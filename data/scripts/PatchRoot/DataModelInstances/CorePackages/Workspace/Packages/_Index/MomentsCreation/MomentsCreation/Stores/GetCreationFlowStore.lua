-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:30:55Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsCreationParent = script:FindFirstAncestor("MomentsCreation").Parent
local Signals = require(MomentsCreationParent.Signals)
local createCreationFlowStore = require(script.createCreationFlowStore)

return Signals.createComputed(createCreationFlowStore)

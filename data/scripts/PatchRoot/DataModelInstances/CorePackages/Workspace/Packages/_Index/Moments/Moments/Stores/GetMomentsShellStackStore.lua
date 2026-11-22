-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:31:01Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsParent = script:FindFirstAncestor("Moments").Parent
local Signals = require(MomentsParent.Signals)
local createMomentsShellStackStore = require(script.createMomentsShellStackStore)

return Signals.createComputed(createMomentsShellStackStore)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T04:51:17Z
-- Luau bytecode version: 14 | Luau type version: 3
local MomentsParent = script:FindFirstAncestor("Moments").Parent
local Signals = require(MomentsParent.Signals)
local createExperienceDetailsSheetStore = require(script.Parent.createExperienceDetailsSheetStore)

return Signals.createComputed(createExperienceDetailsSheetStore)

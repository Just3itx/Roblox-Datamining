-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:34Z
-- Luau bytecode version: 14 | Luau type version: 3
local InExperienceSideSheetParent = script:FindFirstAncestor("InExperienceSideSheet").Parent
local Signals = require(InExperienceSideSheetParent.Signals)
local createSideSheetConfigStore = require(script.createSideSheetConfigStore)

return Signals.createComputed(createSideSheetConfigStore)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:20Z
-- Luau bytecode version: 14 | Luau type version: 3
local ShareSheetParent = script:FindFirstAncestor("ShareSheet").Parent

local Signals = require(ShareSheetParent.Signals)

local createUniversalShareSheetStore = require(script.Parent.createUniversalShareSheetStore)

return Signals.createComputed(createUniversalShareSheetStore)

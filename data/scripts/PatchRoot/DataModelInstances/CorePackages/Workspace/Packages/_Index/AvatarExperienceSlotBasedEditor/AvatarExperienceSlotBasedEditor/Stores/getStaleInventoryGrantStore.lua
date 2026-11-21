-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T04:50:49Z
-- Luau bytecode version: 14 | Luau type version: 3
local AvatarExperienceSlotBasedEditorParent = script:FindFirstAncestor("AvatarExperienceSlotBasedEditor").Parent

local Signals = require(AvatarExperienceSlotBasedEditorParent.Signals)

local createStaleInventoryGrantStore = require(script.Parent.createStaleInventoryGrantStore)

return Signals.createComputed(createStaleInventoryGrantStore)

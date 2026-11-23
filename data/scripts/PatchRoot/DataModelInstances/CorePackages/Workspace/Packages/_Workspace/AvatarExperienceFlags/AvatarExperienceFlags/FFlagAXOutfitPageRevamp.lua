-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T15:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXMigrateOutfitsToUserInventory = require(script.Parent.FFlagAXMigrateOutfitsToUserInventory)

local engineFeature = game:GetEngineFeature("MakeupOutfits")

return game:DefineFastFlag("AXOutfitPageRevamp3", false) and FFlagAXMigrateOutfitsToUserInventory and engineFeature

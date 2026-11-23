-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T15:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXMigrateOutfitsToUserInventory = require(script.Parent.FFlagAXMigrateOutfitsToUserInventory)

return game:DefineFastFlag("AXRefetchInventoryOnUpdate", false) and FFlagAXMigrateOutfitsToUserInventory

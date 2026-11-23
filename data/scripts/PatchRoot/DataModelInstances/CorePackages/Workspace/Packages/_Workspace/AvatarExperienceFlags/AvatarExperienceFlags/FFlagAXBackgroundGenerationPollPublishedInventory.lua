-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T14:30:56Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXRefetchInventoryOnUpdate = require(script.Parent.FFlagAXRefetchInventoryOnUpdate)

return game:DefineFastFlag("AXBackgroundGenerationPollPublishedInventory", false) and FFlagAXRefetchInventoryOnUpdate

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T15:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXInventoryDurablesSupport = require(script.Parent.FFlagAXInventoryDurablesSupport)
local FFlagAXAvatarEditorStoresContext = require(script.Parent.FFlagAXAvatarEditorStoresContext)

return game:DefineFastFlag("AXMigrateOutfitsToUserInventory2", false)
    and FFlagAXInventoryDurablesSupport
    and FFlagAXAvatarEditorStoresContext

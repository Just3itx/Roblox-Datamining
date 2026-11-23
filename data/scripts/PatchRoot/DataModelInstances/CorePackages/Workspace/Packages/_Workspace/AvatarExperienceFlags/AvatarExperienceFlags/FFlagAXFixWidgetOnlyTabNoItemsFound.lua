-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T15:10:42Z
-- Luau bytecode version: 14 | Luau type version: 3
local FFlagAXRootRFYMigration = require(script.Parent.FFlagAXRootRFYMigration)
local FFlagAXMoveAllTabToWidgetOnly = require(script.Parent.FFlagAXMoveAllTabToWidgetOnly)

return FFlagAXRootRFYMigration
    and FFlagAXMoveAllTabToWidgetOnly
    and game:DefineFastFlag("AXFixWidgetOnlyTabNoItemsFound", false)

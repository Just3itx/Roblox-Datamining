-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T03:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local bool1 = game:DefineFastFlag("UserTileAddDataHydrationWrapper", false)

return {
    ["jest.config"] = script["jest.config"],
    UserTileEventHandlers = require(script.Components.UserTileEventHandlers),
    UserTile = if bool1 then require(script.UserTileEntry.UserTileContainer) else require(script.Components.UserTile),
    LayoutMode = require(script.Enums.LayoutMode)
}

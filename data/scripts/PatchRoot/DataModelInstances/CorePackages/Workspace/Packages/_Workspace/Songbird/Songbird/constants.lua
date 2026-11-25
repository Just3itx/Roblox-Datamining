-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T17:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Songbird = script:FindFirstAncestor("Songbird")

local _ReactOtter = require(Songbird.Parent.ReactOtter)

return {
    BIG_VECTOR = Vector2.new(math.huge, math.huge),
    ARTIST_NAME_HEIGHT = 14,
    TRACK_NAME_HEIGHT = 16,
    ICON_SIZE = UDim2.fromOffset(36, 36),
    WINDOW_HEIGHT = 44,
    SUBMENU_WIDTH = 200,
    ICON_BUTTON_WIDTH = 44
}

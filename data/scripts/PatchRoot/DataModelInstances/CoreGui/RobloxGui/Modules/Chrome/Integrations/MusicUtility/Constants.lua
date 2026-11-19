-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T18:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
local Chrome = script:FindFirstAncestor("Chrome")

local Constants = require(Chrome.ChromeShared.Unibar.Constants)

return {
    MIN_TRACK_DETAILS_WIDTH = 48 / Constants.ICON_CELL_WIDTH,
    MAX_TRACK_DETAILS_WIDTH = 78 / Constants.ICON_CELL_WIDTH,
    MUSIC_WINDOW_MAX_SIZE = Vector2.new(400, 80)
}

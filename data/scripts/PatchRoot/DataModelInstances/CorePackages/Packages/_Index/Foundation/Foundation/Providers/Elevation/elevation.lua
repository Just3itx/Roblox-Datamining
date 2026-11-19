-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T09:50:54Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local ElevationLayer = require(Foundation.Enums.ElevationLayer)

local ELEVATION_LAYERS = {
    [ElevationLayer.Popover] = { start = 4, finish = 99, step = 1 },
    [ElevationLayer.Drawer] = { start = 100, finish = 199, step = 10 },
    [ElevationLayer.Sheet] = { start = 200, finish = 299, step = 10 },
    [ElevationLayer.Dialog] = { start = 300, finish = 399, step = 10 },
    [ElevationLayer.Notification] = { start = 400, finish = 499, step = 1 }
}

return {
    ELEVATION_LAYERS = ELEVATION_LAYERS,
    getRelativeIndex = function(tbl2)
        local var1 = ELEVATION_LAYERS[tbl2.layer]
        return tbl2.zIndex - var1.start
    end
}

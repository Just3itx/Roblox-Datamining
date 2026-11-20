-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T06:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local ElevationLayer = require(Foundation.Enums.ElevationLayer)
local tbl1

if require(Foundation.Utility.Flags).FoundationFloatingElevationLayer then
    tbl1 = {}
    tbl1[ElevationLayer.Popover] = { start = 4, finish = 99, step = 1 }

    tbl1[ElevationLayer.Floating] = { start = 100, finish = 199, step = 10 }
    tbl1[ElevationLayer.Drawer] = { start = 200, finish = 299, step = 10 }
    tbl1[ElevationLayer.Sheet] = { start = 300, finish = 399, step = 10 }
    tbl1[ElevationLayer.Dialog] = { start = 400, finish = 499, step = 10 }
    tbl1[ElevationLayer.Notification] = { start = 600, finish = 699, step = 1 }
else
    tbl1 = {}
    tbl1[ElevationLayer.Popover] = { start = 4, finish = 99, step = 1 }
    tbl1[ElevationLayer.Drawer] = { start = 100, finish = 199, step = 10 }
    tbl1[ElevationLayer.Sheet] = { start = 200, finish = 299, step = 10 }
    tbl1[ElevationLayer.Dialog] = { start = 300, finish = 399, step = 10 }

    tbl1[ElevationLayer.Notification] = { start = 400, finish = 499, step = 1 }
    tbl1[ElevationLayer.Floating] = { start = 500, finish = 599, step = 10 }
end

return {
    ELEVATION_LAYERS = tbl1,
    getRelativeIndex = function(tbl2)
        local var1 = tbl1[tbl2.layer]
        return tbl2.zIndex - var1.start
    end
}

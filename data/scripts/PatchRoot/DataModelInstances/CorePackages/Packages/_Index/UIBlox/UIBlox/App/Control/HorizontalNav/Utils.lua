-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.shouldShowGradientsForScrollingFrame(arg1): (boolean, boolean, boolean)
    local absoluteSizeX = arg1.AbsoluteSize.X
    local offset = arg1.CanvasSize.X.Offset
    local canvasPositionX = arg1.CanvasPosition.X

    return absoluteSizeX < offset, canvasPositionX > 20, canvasPositionX + absoluteSizeX < offset - 20
end

return module

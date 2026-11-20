-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:10:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isScrollingFrameOverflowingY(arg1, num1: number?): boolean
    return arg1.AbsoluteCanvasSize.Y > arg1.AbsoluteWindowSize.Y + (if num1 == nil then 1 else num1)
end

return isScrollingFrameOverflowingY

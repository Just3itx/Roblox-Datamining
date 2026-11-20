-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:40:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Foundation = script:FindFirstAncestor("Foundation")
local Breakpoint = require(Foundation.Enums.Breakpoint)
local Constants = require(Foundation.Constants)

local SIZE_BY_BREAKPOINT = {
    [Breakpoint.XSmall] = 1400,
    [Breakpoint.Small] = 1400,
    [Breakpoint.Medium] = 1600,
    [Breakpoint.Large] = 1600,
    [Breakpoint.XLarge] = 1800,
    [Breakpoint.XXLarge] = 1800
}

return {
    LEADING_ACTIONS_LAYOUT_ORDER = Constants.MIN_LAYOUT_ORDER,
    LEADING_LAYOUT_ORDER = 1,
    CONTENT_LAYOUT_ORDER = 2,
    TRAILING_LAYOUT_ORDER = 3,
    TRAILING_ACTIONS_LAYOUT_ORDER = Constants.MAX_LAYOUT_ORDER - 1,
    SIZE_BY_BREAKPOINT = SIZE_BY_BREAKPOINT
}

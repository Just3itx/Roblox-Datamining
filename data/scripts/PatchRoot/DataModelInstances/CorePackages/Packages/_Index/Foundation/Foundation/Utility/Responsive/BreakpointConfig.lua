-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T10:21:10Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local Foundation = script:FindFirstAncestor("Foundation")

local Breakpoint = require(Foundation.Enums.Breakpoint)
local BreakpointShortName = require(Foundation.Enums.BreakpointShortName)

return {
    shortNames = {
        [Breakpoint.XSmall] = BreakpointShortName.xs,
        [Breakpoint.Small] = BreakpointShortName.sm,
        [Breakpoint.Medium] = BreakpointShortName.md,
        [Breakpoint.Large] = BreakpointShortName.lg,
        [Breakpoint.XLarge] = BreakpointShortName.xl,
        [Breakpoint.XXLarge] = BreakpointShortName.xxl
    },
    widths = {
        [Breakpoint.XSmall] = 360,
        [Breakpoint.Small] = 600,
        [Breakpoint.Medium] = 1140,
        [Breakpoint.Large] = 1520,
        [Breakpoint.XLarge] = 1920,
        [Breakpoint.XXLarge] = math.huge
    },
    order = {
        Breakpoint.XSmall,
        Breakpoint.Small,
        Breakpoint.Medium,
        Breakpoint.Large,
        Breakpoint.XLarge,
        Breakpoint.XXLarge
    }
}

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:40:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local Foundation = require(SplitPaneParent.Foundation)
local AppComposition = require(SplitPaneParent.AppComposition)
local SharedFlags = require(SplitPaneParent.SharedFlags)

local Breakpoint = Foundation.Enums.Breakpoint
local resolveBreakpoint = AppComposition.resolveBreakpoint
local FFlagEnableSplitPane = SharedFlags.FFlagEnableSplitPane

local Large = Breakpoint.Large

local tbl1 = {
    [Breakpoint.XSmall] = 1,
    [Breakpoint.Small] = 2,
    [Breakpoint.Medium] = 3,
    [Breakpoint.Large] = 4,
    [Breakpoint.XLarge] = 5,
    [Breakpoint.XXLarge] = 6
}

local function isBreakpointAtLeast(arg1, large): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return (tbl1[arg1] or 0) >= (tbl1[large] or 0)
end

return {
    isSplitEnabledForWidth = function(num1: number): boolean
        return num1 >= 800
    end,
    shouldDefaultToCollapsed = function(num1: number): boolean
        return if FFlagEnableSplitPane then not isBreakpointAtLeast(resolveBreakpoint(num1), Large) else false
    end
}

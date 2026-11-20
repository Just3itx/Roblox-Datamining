-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppCompositionParent = script:FindFirstAncestor("AppComposition").Parent
local Breakpoint = require(AppCompositionParent.Foundation).Enums.Breakpoint

local tbl1 = {
    [Breakpoint.XSmall] = 360,
    [Breakpoint.Small] = 600,
    [Breakpoint.Medium] = 1140,
    [Breakpoint.Large] = 1520,
    [Breakpoint.XLarge] = 1920,
    [Breakpoint.XXLarge] = math.huge
}

local tbl2 = {
    Breakpoint.XSmall,
    Breakpoint.Small,
    Breakpoint.Medium,
    Breakpoint.Large,
    Breakpoint.XLarge,
    Breakpoint.XXLarge
}

local function resolveBreakpoint(num1: number)
    for _, value in tbl2 do
        if num1 <= (tbl1[value] or 0) then
            return value
        end
    end
    return Breakpoint.XXLarge
end

return resolveBreakpoint

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:20:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameFiltersParent = script:FindFirstAncestor("GameFilters").Parent
local Responsive = require(GameFiltersParent.Responsive)
local useBreakpointXOrSmaller = Responsive.useBreakpointXOrSmaller

local function shouldUsePeekView()
    return useBreakpointXOrSmaller(Responsive.Keys.Small)
end

return shouldUsePeekView

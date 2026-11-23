-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T04:50:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AccountUpgradeParent = script:FindFirstAncestor("AccountUpgrade").Parent

local Responsive = require(AccountUpgradeParent.Responsive)

local function useMobilePage()
    return (Responsive.useBreakpointXOrSmaller(Responsive.Keys.Small))
end

return useMobilePage

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent

local SplitPaneSlot = require(SplitPaneParent.AppSplitView).Enums.SplitPaneSlot

local function isSupportPaneScreen(arg1): boolean
    return arg1.descriptor.options.splitPaneEligibility == SplitPaneSlot.Support
end

return isSupportPaneScreen

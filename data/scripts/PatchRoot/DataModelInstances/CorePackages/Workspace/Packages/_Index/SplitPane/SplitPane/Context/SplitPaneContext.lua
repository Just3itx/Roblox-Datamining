-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
local SplitPaneParent = script:FindFirstAncestor("SplitPane").Parent
return require(SplitPaneParent.React).createContext(
    {
        renderSupportContent = nil,
        supportPaneResizable = nil,
        onContentRegionRectChanged = nil,
        resolveEligibility = nil
    }
)

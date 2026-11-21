-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T18:01:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GameDetailParent = script:FindFirstAncestor("GameDetail").Parent
return require(GameDetailParent.Rodux).makeActionCreator("SetGameDetailsPeekViewState", function(viewState)
    return { viewState = viewState }
end)

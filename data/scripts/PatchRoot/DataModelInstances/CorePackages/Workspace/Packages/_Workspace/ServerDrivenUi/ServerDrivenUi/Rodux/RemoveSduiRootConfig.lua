-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T13:40:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerDrivenUiParent = script:FindFirstAncestor("ServerDrivenUi").Parent
return require(ServerDrivenUiParent.Rodux).makeActionCreator(script.Name, function(feedStoreKey: string)
    return { feedStoreKey = feedStoreKey }
end)

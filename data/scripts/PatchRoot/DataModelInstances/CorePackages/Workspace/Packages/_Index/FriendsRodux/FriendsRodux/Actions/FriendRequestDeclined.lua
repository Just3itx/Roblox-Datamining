-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:00:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRoduxParent = script:FindFirstAncestor("FriendsRodux").Parent
return require(FriendsRoduxParent.Rodux).makeActionCreator(script.Name, function(ids)
    return { ids = ids }
end)

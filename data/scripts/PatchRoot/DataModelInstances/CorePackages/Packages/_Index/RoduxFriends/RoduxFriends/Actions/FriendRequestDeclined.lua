-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:50:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxFriendsParent = script:FindFirstAncestor("RoduxFriends").Parent
return require(RoduxFriendsParent.Rodux).makeActionCreator(script.Name, function(ids)
    return { ids = ids }
end)

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:50:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxFriendsParent = script:FindFirstAncestor("RoduxFriends").Parent
return require(RoduxFriendsParent.Rodux).makeActionCreator(script.Name, function(userId1, userId2)
    return {
        payload = { userId1 = userId1, userId2 = userId2 }
    }
end)

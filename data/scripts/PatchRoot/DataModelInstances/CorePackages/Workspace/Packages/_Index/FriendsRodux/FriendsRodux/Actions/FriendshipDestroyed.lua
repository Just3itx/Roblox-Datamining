-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:00:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRoduxParent = script:FindFirstAncestor("FriendsRodux").Parent
return require(FriendsRoduxParent.Rodux).makeActionCreator(script.Name, function(userId1, userId2)
    return {
        payload = { userId1 = userId1, userId2 = userId2 }
    }
end)

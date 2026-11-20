-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxFriendsParent = script:FindFirstAncestor("RoduxFriends").Parent
return require(RoduxFriendsParent.Rodux).makeActionCreator(script.Name, function(count: number)
    assert(type(count) == "number", "Request count must be a number")

    return {
        payload = { count = count }
    }
end)

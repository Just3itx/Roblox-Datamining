-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:01:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRoduxParent = script:FindFirstAncestor("FriendsRodux").Parent
local Rodux = require(FriendsRoduxParent.Rodux)
local followingStatuses = require(script.followingStatuses)

return function(arg1)
    return Rodux.combineReducers({ followingStatuses = followingStatuses(arg1) })
end

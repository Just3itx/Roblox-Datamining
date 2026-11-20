-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:51:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxFriendsParent = script:FindFirstAncestor("RoduxFriends").Parent
local Rodux = require(RoduxFriendsParent.Rodux)
local byUserId = require(script.byUserId)
local bySource = require(script.bySource)
local hasIncomingFriendRequest = require(script.hasIncomingFriendRequest)

return function(arg1)
    return Rodux.combineReducers(
        {
            byUserId = byUserId(arg1),
            bySource = bySource(arg1),
            hasIncomingFriendRequest = hasIncomingFriendRequest(arg1)
        }
    )
end

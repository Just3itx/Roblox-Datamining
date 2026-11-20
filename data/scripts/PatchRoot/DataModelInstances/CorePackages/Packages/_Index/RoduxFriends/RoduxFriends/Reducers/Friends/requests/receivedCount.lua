-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxFriends = script:FindFirstAncestor("RoduxFriends")
local RoduxFriendsParent = RoduxFriends.Parent
local Rodux = require(RoduxFriendsParent.Rodux)
local Actions = RoduxFriends.Actions
local RequestReceivedCountUpdated = require(Actions.RequestReceivedCountUpdated)

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl1 = {}
    tbl1[RequestReceivedCountUpdated.name] = function(_, arg2)
        assert(type(arg2.payload.count) == "number", "Expected count to be a number")

        return arg2.payload.count
    end

    tbl1[friendsNetworking.GetFriendRequestsCount.Succeeded.name] = function(_, arg2)
        return arg2.responseBody.count
    end

    return createReducer(0, tbl1)
end

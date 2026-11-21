-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:01:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Rodux = require(scriptParentParentParentParentParent.Rodux)

local _roduxFriendsTypes = require(scriptParentParentParentParent.roduxFriendsTypes)
local Actions = scriptParentParentParentParent.Actions
local ClearNewFriendRequestsCountUpdated = require(Actions.ClearNewFriendRequestsCountUpdated)

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking
    local createReducer = Rodux.createReducer
    local tbl1 = {}
    tbl1[ClearNewFriendRequestsCountUpdated.name] = function(_, _): number
        return 0
    end
    tbl1[friendsNetworking.GetNewFriendRequestsCount.Succeeded.name] = function(_, arg2)
        return arg2.responseBody.count
    end
    tbl1[friendsNetworking.ClearNewFriendRequests.Succeeded.name] = function(_, _): number
        return 0
    end

    return createReducer(0, tbl1)
end

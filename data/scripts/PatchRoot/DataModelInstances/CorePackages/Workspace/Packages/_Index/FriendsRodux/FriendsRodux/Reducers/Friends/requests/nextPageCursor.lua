-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:01:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Rodux = require(scriptParentParentParentParentParent.Rodux)
local _roduxFriendsTypes = require(scriptParentParentParentParent.roduxFriendsTypes)

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl1 = {}
    tbl1[friendsNetworking.GetFriendRequests.Succeeded.name] = function(_, arg2)
        return arg2.responseBody.nextPageCursor
    end
    tbl1[friendsNetworking.DeclineAllFriendRequests.Succeeded.name] = function(_, _)
        return nil
    end

    return createReducer(nil, tbl1)
end

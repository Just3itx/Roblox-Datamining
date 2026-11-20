-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxFriendsParent = script:FindFirstAncestor("RoduxFriends").Parent
local Rodux = require(RoduxFriendsParent.Rodux)
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent

local getDeepValue = require(scriptParentParentParentParent.getDeepValue)
local llama = require(RoduxFriendsParent.llama)

local tbl1 = {}

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[friendsNetworking.GetFriendRequests.Succeeded.name] = function(_, arg2)
        local data = arg2.responseBody.data
        return (llama.Dictionary.map(data, function(arg3)
            return getDeepValue(arg3, "friendRequest.originSourceType"), tostring(arg3.id)
        end))
    end

    return createReducer(tbl2, tbl3)
end

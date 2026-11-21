-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:01:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Rodux = require(scriptParentParentParentParentParent.Rodux)

local Actions = scriptParentParentParentParent.Actions
local FriendRequestCreated = require(Actions.FriendRequestCreated)
local FriendRequestDeclined = require(Actions.FriendRequestDeclined)
local FriendshipCreated = require(Actions.FriendshipCreated)

local removeIdsFromRequestsStore = require(scriptParentParentParentParent.Reducers.Friends.utils.removeIdsFromRequestsStore)
local _roduxFriendsTypes = require(scriptParentParentParentParent.roduxFriendsTypes)

local llama = require(scriptParentParentParentParentParent.llama)

local tbl1 = {}

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking
    local networkingBlocking = arg1.networkingBlocking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[friendsNetworking.AcceptFriendRequestFromUserId.Succeeded.name] = function(tbl4, arg2)
        local ids = arg2.ids

        return removeIdsFromRequestsStore(tbl4, ids)
    end
    tbl3[friendsNetworking.DeclineFriendRequestFromUserId.Succeeded.name] = function(tbl4, arg2)
        local ids = arg2.ids

        return removeIdsFromRequestsStore(tbl4, ids)
    end
    tbl3[friendsNetworking.GetFriendRequests.Succeeded.name] = function(tbl4, arg2)
        local data = arg2.responseBody.data

        local tbl5 = {}
        for _, value in pairs(data) do
            local id = value.id
            tbl5[tostring(id)] = true
        end
        return (llama.Dictionary.join(tbl4, tbl5))
    end
    tbl3[FriendRequestCreated.name] = function(tbl4, arg2)
        local requesteeId = arg2.requesteeId

        return llama.Dictionary.join(tbl4, { [tostring(requesteeId)] = true })
    end

    tbl3[FriendRequestDeclined.name] = function(tbl4, arg2)
        local ids = arg2.ids

        return removeIdsFromRequestsStore(tbl4, ids)
    end
    tbl3[FriendshipCreated.name] = function(arg2, arg3)
        assert(type(arg3.payload.userId1) == "string", "Expected userId1 to be a string")
        assert(type(arg3.payload.userId2) == "string", "Expected userId2 to be a string")

        return removeIdsFromRequestsStore(arg2, { arg3.payload.userId1, arg3.payload.userId2 })
    end
    tbl3[friendsNetworking.DeclineAllFriendRequests.Succeeded.name] = function()
        return {}
    end

    tbl3[networkingBlocking.BlockUserById.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.namedIds.users)
        return removeIdsFromRequestsStore(arg2, { str1 })
    end

    return createReducer(tbl2, tbl3)
end

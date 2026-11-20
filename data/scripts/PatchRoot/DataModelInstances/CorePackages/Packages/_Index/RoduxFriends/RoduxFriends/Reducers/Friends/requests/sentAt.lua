-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:51:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Rodux = require(scriptParentParentParentParentParent.Rodux)

local _roduxFriendsTypes = require(scriptParentParentParentParent.roduxFriendsTypes)

local Actions = scriptParentParentParentParent.Actions
local FriendRequestCreated = require(Actions.FriendRequestCreated)
local FriendRequestDeclined = require(Actions.FriendRequestDeclined)
local FriendshipCreated = require(Actions.FriendshipCreated)

local removeIdsFromRequestsStore = require(scriptParentParentParentParent.Reducers.Friends.utils.removeIdsFromRequestsStore)

local llama = require(scriptParentParentParentParentParent.llama)

local tbl1 = {}

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

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
            tbl5[tostring(id)] = DateTime.fromIsoDate(value.friendRequest.sentAt)
        end

        return llama.Dictionary.join(tbl4, tbl5)
    end
    tbl3[FriendRequestCreated.name] = function(tbl4, arg2)
        local str1 = tostring(arg2.requesteeId)
        local sentAt = arg2.sentAt

        return llama.Dictionary.join(tbl4, { [str1] = DateTime.fromIsoDate(sentAt) })
    end

    tbl3[FriendRequestDeclined.name] = function(tbl4, arg2)
        local ids = arg2.ids

        return removeIdsFromRequestsStore(tbl4, ids)
    end
    tbl3[FriendshipCreated.name] = function(tbl4, arg2)
        return removeIdsFromRequestsStore(tbl4, { arg2.payload.userId1, arg2.payload.userId2 })
    end
    tbl3[friendsNetworking.DeclineAllFriendRequests.Succeeded.name] = function()
        return tbl1
    end

    return createReducer(tbl2, tbl3)
end

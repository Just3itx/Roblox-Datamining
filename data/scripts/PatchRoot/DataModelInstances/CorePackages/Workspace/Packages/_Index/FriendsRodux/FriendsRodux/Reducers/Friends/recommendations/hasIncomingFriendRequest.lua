-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:01:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Rodux = require(scriptParentParentParentParentParent.Rodux)
local llama = require(scriptParentParentParentParentParent.llama)

local Actions = scriptParentParentParentParent.Actions
local RecommendationCreated = require(Actions.RecommendationCreated)
local FriendRequestDeclined = require(Actions.FriendRequestDeclined)

local _roduxFriendsTypes = require(scriptParentParentParentParent.roduxFriendsTypes)

local tbl1 = {}

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[RecommendationCreated.name] = function(arg2, arg3)
        local recommendedUser = arg3.payload.recommendedUser
        local str1 = tostring(recommendedUser.id)
        local bool1 = not not recommendedUser.hasIncomingFriendRequest

        return llama.Dictionary.join(arg2, { [str1] = bool1 })
    end

    tbl3[friendsNetworking.GetFriendRecommendationsFromUserId.Succeeded.name] = function(arg2, arg3)
        local var1 = llama.List.filter(arg3.responseBody.data, function(arg4): boolean
            return arg4.contextType ~= "Contacts"
        end, {})

        local var2 = llama.List.reduce(var1, function(arg4, arg5)
            local id = arg5.id
            arg4[tostring(id)] = not not arg5.friendRequest
            return arg4
        end, {})

        return llama.Dictionary.join(arg2, var2)
    end

    tbl3[friendsNetworking.DeclineFriendRequestFromUserId.Succeeded.name] = function(arg2, arg3)
        local ids = arg3.ids
        local var1 = llama.List.reduce(ids, function(arg4, arg5)
            arg4[tostring(arg5)] = false
            return arg4
        end, {})

        return llama.Dictionary.join(arg2, var1)
    end

    tbl3[FriendRequestDeclined.name] = function(arg2, arg3)
        local ids = arg3.ids
        local var1 = llama.List.reduce(ids, function(arg4, arg5)
            arg4[tostring(arg5)] = false
            return arg4
        end, {})

        return llama.Dictionary.join(arg2, var1)
    end

    tbl3[friendsNetworking.DeclineAllFriendRequests.Succeeded.name] = function(_)
        return tbl1
    end

    return createReducer(tbl2, tbl3)
end

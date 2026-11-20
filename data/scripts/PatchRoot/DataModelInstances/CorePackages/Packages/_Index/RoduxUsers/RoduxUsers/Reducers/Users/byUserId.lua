-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RoduxUsers = script:FindFirstAncestor("RoduxUsers")
local RoduxUsersParent = RoduxUsers.Parent
local Rodux = require(RoduxUsersParent.Rodux)
local Cryo = require(RoduxUsersParent.Cryo)

local Actions = RoduxUsers.Actions
local Models = RoduxUsers.Models
local UserRemoved = require(Actions.UserRemoved)
local UserUpdated = require(Actions.UserUpdated)
local UserModel = require(Models.UserModel)

local tbl1 = {}

local function func1(arg1, arg2)
    local tbl2 = ({})

    for _, value in ipairs(arg2) do
        local id = tostring(value.id)

        tbl2[id] = UserModel.new({
            id = id,
            username = value.name or "",
            displayName = value.displayName or "",
            hasVerifiedBadge = value.hasVerifiedBadge,
            created = value.created
        })
    end

    return Cryo.Dictionary.join(arg1, tbl2)
end

return function(arg1)
    local usersNetworking = arg1.usersNetworking
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[usersNetworking.GetUserV2FromUserId.Succeeded.name] = function(arg2, arg3)
        return func1(arg2, { arg3.responseBody })
    end

    tbl3[usersNetworking.GetSkinnyUsersFromUserIds.Succeeded.name] = function(arg2, arg3)
        return func1(arg2, arg3.responseBody.data)
    end

    tbl3[friendsNetworking.GetFriendsFromUserId.Succeeded.name] = function(arg2, arg3)
        return func1(arg2, arg3.responseBody.data)
    end

    tbl3[friendsNetworking.GetFriendRequests.Succeeded.name] = function(arg2, arg3)
        return func1(arg2, arg3.responseBody.data)
    end

    tbl3[friendsNetworking.GetFriendRecommendationsFromUserId.Succeeded.name] = function(arg2, arg3)
        return func1(arg2, arg3.responseBody.data)
    end

    tbl3[UserUpdated.name] = function(arg2, arg3)
        assert(UserModel.isValid(arg3.payload))

        return Cryo.Dictionary.join(arg2, { [arg3.payload.id] = arg3.payload })
    end

    tbl3[UserRemoved.name] = function(arg2, arg3)
        assert(type(arg3.payload.id) == "string", "Expected id to be a string")

        return Cryo.Dictionary.join(arg2, { [arg3.payload.id] = Cryo.None })
    end

    return createReducer(tbl2, tbl3)
end

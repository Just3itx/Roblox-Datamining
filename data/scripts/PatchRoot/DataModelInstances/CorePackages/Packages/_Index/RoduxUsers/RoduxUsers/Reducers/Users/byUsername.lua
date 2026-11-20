-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:30:52Z
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

local function func1(id, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = nil
    for k, value in pairs(arg1) do
        if value == id then
            return k
        end
    end

    return var1
end

local function func2(arg1, arg2)
    local tbl1 = ({})
    for _, value in ipairs(arg2) do
        if value.name then
            local name = value.name
            tbl1[name] = tostring(value.id)
        end
    end

    return Cryo.Dictionary.join(arg1, tbl1)
end

local tbl1 = {}
return function(arg1)
    local usersNetworking = arg1.usersNetworking
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[usersNetworking.GetUserV2FromUserId.Succeeded.name] = function(arg2, arg3)
        return func2(arg2, { arg3.responseBody })
    end

    tbl3[usersNetworking.GetSkinnyUsersFromUserIds.Succeeded.name] = function(arg2, arg3)
        return func2(arg2, arg3.responseBody.data)
    end

    tbl3[friendsNetworking.GetFriendsFromUserId.Succeeded.name] = function(arg2, arg3)
        return func2(arg2, arg3.responseBody.data)
    end

    tbl3[friendsNetworking.GetFriendRequests.Succeeded.name] = function(arg2, arg3)
        return func2(arg2, arg3.responseBody.data)
    end

    tbl3[friendsNetworking.GetFriendRecommendationsFromUserId.Succeeded.name] = function(arg2, arg3)
        return func2(arg2, arg3.responseBody.data)
    end

    tbl3[UserUpdated.name] = function(arg2, arg3)
        assert(UserModel.isValid(arg3.payload))

        return Cryo.Dictionary.join(arg2, { [arg3.payload.username] = arg3.payload.id })
    end

    tbl3[UserRemoved.name] = function(arg2, arg3)
        assert(type(arg3.payload.id) == "string", "Expected id to be a string")

        local var1 = func1(arg3.payload.id, arg2)

        if var1 then
            return Cryo.Dictionary.join(arg2, { [var1] = Cryo.None })
        end

        return arg2
    end

    return createReducer(tbl2, tbl3)
end

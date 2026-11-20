-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:51:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local Rodux = require(scriptParentParentParentParentParent.Rodux)
local llama = require(scriptParentParentParentParentParent.llama)

local Models = scriptParentParentParentParent.Models
local Recommendation = require(Models.Recommendation)
local Actions = scriptParentParentParentParent.Actions
local RecommendationCreated = require(Actions.RecommendationCreated)
local FriendshipCreated = require(Actions.FriendshipCreated)
local RecommendationDestroyed = require(Actions.RecommendationDestroyed)

local _roduxFriendsTypes = require(scriptParentParentParentParent.roduxFriendsTypes)

local tbl1 = {}

local function func1(tbl2, arg1) -- Luacid: Inlined by compiler; 3 call sites recovered
    local var1 = arg1[tbl2.baseUserId]

    if var1 then
        return (llama.Dictionary.removeKey(var1, tbl2.recommendedUserId))
    end

    return nil
end

local function func2(arg1, arg2)
    return llama.Dictionary.join(arg2, {
        [arg1.userId1] = func1({ baseUserId = arg1.userId1, recommendedUserId = arg1.userId2 }, arg2),
        [arg1.userId2] = func1({ baseUserId = arg1.userId2, recommendedUserId = arg1.userId1 }, arg2)
    })
end

local function func3<T>(tbl2: {baseFriendId: number, users: number}, arg1: T): T -- Luacid: Inlined by compiler; 1 call site recovered
    local var1 = arg1

    llama.Dictionary.map(tbl2.users, function(arg2)
        var1 = func2({ userId1 = tbl2.baseFriendId, userId2 = tostring(arg2.id) }, var1)
    end)

    return var1
end

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking
    local networkingBlocking = arg1.networkingBlocking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[RecommendationCreated.name] = function(arg2, arg3)
        local str1 = tostring(arg3.payload.baseUserId)
        local str2 = tostring(arg3.payload.recommendedUser.id)

        local var1 = arg2[str1] or {}

        return llama.Dictionary.join(
            arg2,
            {
                [str1] = llama.Dictionary.join(var1, { [str2] = Recommendation.format(arg3.payload.recommendedUser) })
            }
        )
    end

    tbl3[RecommendationDestroyed.name] = function(arg2, arg3)
        return llama.Dictionary.join(arg2, { [arg3.payload.baseUserId] = func1(arg3.payload, arg2) })
    end

    tbl3[friendsNetworking.GetFriendRecommendationsFromUserId.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.namedIds.users)
        local data = arg3.responseBody.data

        local var1 = llama.Dictionary.map(data, function(arg4, _)
            local contactId = if arg4.contextType == "Contacts" then arg4.contactId else tostring(arg4.id)
            return Recommendation.format({
                id = contactId,
                contactId = arg4.contactId,
                mutualFriendsList = arg4.mutualFriendsList,
                rank = arg4.rank,
                contextType = arg4.contextType,
                thumbnailEntities = arg4.thumbnailEntities,
                displayName = arg4.displayName
            }), contactId
        end)

        local var2 = arg2[str1] or {}

        return llama.Dictionary.join(arg2, { [str1] = llama.Dictionary.join(var2, var1) })
    end

    tbl3[FriendshipCreated.name] = function(arg2, arg3)
        return func2(arg3.payload, arg2)
    end

    tbl3[friendsNetworking.GetFriendsFromUserId.Succeeded.name] = function(arg2, arg3)
        local tbl4 = {
            baseFriendId = tostring(arg3.namedIds.users),
            users = arg3.responseBody.data
        }
        return func3(tbl4, arg2)
    end

    tbl3[friendsNetworking.AcceptFriendRequestFromUserId.Succeeded.name] = function(arg2, arg3)
        local userId2 = tostring(arg3.ids[1])
        local userId1 = tostring(arg3.additionalData.currentUserId)

        return func2({ userId1 = userId1, userId2 = userId2 }, arg2)
    end

    tbl3[networkingBlocking.BlockUserById.Succeeded.name] = function(arg2, arg3)
        local userId1 = tostring(arg3.additionalData.currentUserId)
        local userId2 = tostring(arg3.namedIds.users)

        return func2({ userId1 = userId1, userId2 = userId2 }, arg2)
    end

    return createReducer(tbl2, tbl3)
end

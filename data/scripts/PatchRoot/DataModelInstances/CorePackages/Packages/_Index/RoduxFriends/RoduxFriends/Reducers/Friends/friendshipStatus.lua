-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T13:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local Rodux = require(scriptParentParentParentParent.Rodux)
local llama = require(scriptParentParentParentParent.llama)

local Actions = scriptParentParentParent.Actions
local FriendshipCreated = require(Actions.FriendshipCreated)
local FriendshipDestroyed = require(Actions.FriendshipDestroyed)
local FriendRequestCreated = require(Actions.FriendRequestCreated)
local FriendRequestDeclined = require(Actions.FriendRequestDeclined)

local _roduxFriendsTypes = require(scriptParentParentParent.roduxFriendsTypes)

local tbl1 = {}

local function mapFriendshipStatusToEnum(str1: string) -- Luacid: Inlined by compiler; 8 call sites recovered
    if str1 == "NotFriends" then
        return Enum.FriendStatus.NotFriend
    elseif str1 == "Friends" then
        return Enum.FriendStatus.Friend
    elseif str1 == "RequestSent" then
        return Enum.FriendStatus.FriendRequestSent
    elseif str1 == "RequestReceived" then
        return Enum.FriendStatus.FriendRequestReceived
    end

    return Enum.FriendStatus.Unknown
end

local function difference(tbl2, tbl3)
    local tbl4 = ({})
    for _, value in pairs(tbl2) do
        tbl4[value] = true
    end

    for _, value in pairs(tbl3) do
        tbl4[value] = nil
    end

    local result = ({})
    local num1 = 0
    for _, value in pairs(tbl2) do
        if tbl4[value] then
            num1 += 1
            result[num1] = value
        end
    end

    return result
end

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[friendsNetworking.GetFriendshipStatus.Succeeded.name] = function(arg2, arg3)
        local tbl4 = ({})
        for _, value in pairs(arg3.responseBody.data) do
            local str1 = tostring(value.id)
            local status = value.status
            tbl4[str1] = if status == "NotFriends" then mapFriendshipStatusToEnum("NotFriends") elseif status == "Friends" then mapFriendshipStatusToEnum("Friends") elseif status == "RequestSent" then mapFriendshipStatusToEnum("RequestSent") elseif status == "RequestReceived" then mapFriendshipStatusToEnum("RequestReceived") else Enum.FriendStatus.Unknown
        end
        return llama.Dictionary.join(arg2, tbl4)
    end

    tbl3[friendsNetworking.GetExtendedFriendshipStatus.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.ids[1])
        local join = llama.Dictionary.join
        local tbl4 = {}
        local status = arg3.responseBody.status
        tbl4[str1] = if status == "NotFriends" then mapFriendshipStatusToEnum("NotFriends") elseif status == "Friends" then mapFriendshipStatusToEnum("Friends") elseif status == "RequestSent" then mapFriendshipStatusToEnum("RequestSent") elseif status == "RequestReceived" then mapFriendshipStatusToEnum("RequestReceived") else Enum.FriendStatus.Unknown
        return join(arg2, tbl4)
    end

    tbl3[friendsNetworking.GetFriendsFromUserId.Succeeded.name] = function(arg2, arg3)
        local var1 = llama.Dictionary.keys(llama.Dictionary.filter(arg2, function(friendStatus): boolean
            return friendStatus == Enum.FriendStatus.Friend
        end))
        local var2 = llama.List.map(llama.Dictionary.values(arg3.responseBody.data), function(arg4): string
            return tostring(arg4.id)
        end)
        local tbl4 = difference(var2, var1)
        local tbl5 = difference(var1, var2)
        for _, value in pairs(tbl4) do
            arg2 = llama.Dictionary.join(arg2, { [value] = Enum.FriendStatus.Friend })
        end

        for _, value in pairs(tbl5) do
            arg2 = llama.Dictionary.join(arg2, { [value] = Enum.FriendStatus.Unknown })
        end

        return arg2
    end

    tbl3[friendsNetworking.UnfriendTargetUserId.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.namedIds.users)
        return llama.Dictionary.join(arg2, { [str1] = Enum.FriendStatus.NotFriend })
    end

    tbl3[friendsNetworking.AcceptFriendRequestFromUserId.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.ids[1])
        return llama.Dictionary.join(arg2, { [str1] = Enum.FriendStatus.Friend })
    end

    tbl3[friendsNetworking.DeclineFriendRequestFromUserId.Succeeded.name] = function(arg2, arg3)
        local ids = arg3.ids
        local tbl4 = {}
        for _, value in pairs(ids) do
            tbl4[tostring(value)] = Enum.FriendStatus.NotFriend
        end
        return llama.Dictionary.join(arg2, tbl4)
    end

    tbl3[friendsNetworking.GetFriendRequests.Succeeded.name] = function(arg2, arg3)
        local data = arg3.responseBody.data
        local tbl4 = {}
        for _, value in pairs(data) do
            local id = value.id
            tbl4[tostring(id)] = Enum.FriendStatus.FriendRequestReceived
        end
        return llama.Dictionary.join(arg2, tbl4)
    end

    tbl3[friendsNetworking.DeclineAllFriendRequests.Succeeded.name] = function(arg2)
        local tbl4 = {}
        for k, value in pairs(arg2) do
            if value == Enum.FriendStatus.FriendRequestReceived then
                tbl4[tostring(k)] = Enum.FriendStatus.NotFriend
            end
        end
        return llama.Dictionary.join(arg2, tbl4)
    end

    tbl3[friendsNetworking.RequestFriendshipFromUserId.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.namedIds.users)
        return llama.Dictionary.join(arg2, { [str1] = Enum.FriendStatus.FriendRequestSent })
    end

    tbl3[friendsNetworking.RequestFriendshipFromContactId.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.namedIds.contacts)
        return llama.Dictionary.join(arg2, { [str1] = Enum.FriendStatus.FriendRequestSent })
    end

    tbl3[FriendshipDestroyed.name] = function(arg2, arg3)
        local str1 = tostring(arg3.payload.userId1)
        return llama.Dictionary.join(arg2, { [str1] = Enum.FriendStatus.NotFriend })
    end

    tbl3[FriendshipCreated.name] = function(arg2, arg3)
        local str1 = tostring(arg3.payload.userId1)
        return llama.Dictionary.join(arg2, { [str1] = Enum.FriendStatus.Friend })
    end

    tbl3[FriendRequestCreated.name] = function(arg2, arg3)
        local str1 = tostring(arg3.requesteeId)
        return llama.Dictionary.join(arg2, { [str1] = Enum.FriendStatus.FriendRequestReceived })
    end

    tbl3[FriendRequestDeclined.name] = function(arg2, arg3)
        local ids = arg3.ids
        local tbl4 = {}
        for _, value in pairs(ids) do
            tbl4[tostring(value)] = Enum.FriendStatus.NotFriend
        end
        return llama.Dictionary.join(arg2, tbl4)
    end

    return createReducer(tbl2, tbl3)
end

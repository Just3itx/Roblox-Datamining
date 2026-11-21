-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRodux = script:FindFirstAncestor("FriendsRodux")
local FriendsRoduxParent = FriendsRodux.Parent
local Rodux = require(FriendsRoduxParent.Rodux)
local llama = require(FriendsRoduxParent.llama)

local Actions = FriendsRodux.Actions
local FriendshipCreated = require(Actions.FriendshipCreated)
local FriendshipDestroyed = require(Actions.FriendshipDestroyed)

local _roduxFriendsTypes = require(FriendsRodux.roduxFriendsTypes)

local addUser = require(script.Parent.utils.addUser)
local removeUser = require(script.Parent.utils.removeUser)
local setFriendshipsInStore = require(script.Parent.utils.setFriendshipsInStore)
local removeTargetUserFriendshipInStore = require(script.Parent.utils.removeTargetUserFriendshipInStore)

local tbl1 = {}

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

    local createReducer = Rodux.createReducer
    local tbl2 = tbl1
    local tbl3 = {}
    tbl3[FriendshipCreated.name] = function(arg2, arg3)
        assert(type(arg3.payload.userId1) == "string", "Expected userId1 to be a string")
        assert(type(arg3.payload.userId2) == "string", "Expected userId2 to be a string")

        return llama.Dictionary.join(arg2, {
            [arg3.payload.userId1] = addUser(arg2[arg3.payload.userId1], arg3.payload.userId2),
            [arg3.payload.userId2] = addUser(arg2[arg3.payload.userId2], arg3.payload.userId1)
        })
    end

    tbl3[FriendshipDestroyed.name] = function(arg2, arg3)
        assert(type(arg3.payload.userId1) == "string", "Expected userId1 to be a string")
        assert(type(arg3.payload.userId2) == "string", "Expected userId2 to be a string")

        return llama.Dictionary.join(arg2, {
            [arg3.payload.userId1] = removeUser(arg2[arg3.payload.userId1], arg3.payload.userId2),
            [arg3.payload.userId2] = removeUser(arg2[arg3.payload.userId2], arg3.payload.userId1)
        })
    end

    tbl3[friendsNetworking.GetFriendsFromUserId.Succeeded.name] = function(arg2, arg3)
        return setFriendshipsInStore(arg2, arg3)
    end

    tbl3[friendsNetworking.UnfriendTargetUserId.Succeeded.name] = function(arg2, arg3)
        return removeTargetUserFriendshipInStore(arg2, arg3)
    end
    tbl3[friendsNetworking.AcceptFriendRequestFromUserId.Succeeded.name] = function(arg2, arg3)
        local str1 = tostring(arg3.ids[1])
        local str2 = tostring(arg3.additionalData.currentUserId)

        return llama.Dictionary.join(arg2, { [str1] = addUser(arg2[str1], str2), [str2] = addUser(arg2[str2], str1) })
    end

    return createReducer(tbl2, tbl3)
end

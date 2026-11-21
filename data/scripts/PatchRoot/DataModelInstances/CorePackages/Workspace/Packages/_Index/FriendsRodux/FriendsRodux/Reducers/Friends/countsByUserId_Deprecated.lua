-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T17:01:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsRodux = script:FindFirstAncestor("FriendsRodux")
local FriendsRoduxParent = FriendsRodux.Parent
local llama = require(FriendsRoduxParent.llama)

local Actions = FriendsRodux.Actions
local FriendshipCreated = require(Actions.FriendshipCreated)
local FriendshipDestroyed = require(Actions.FriendshipDestroyed)
local addUser = require(script.Parent.utils.addUser)
local removeUser = require(script.Parent.utils.removeUser)
local setFriendshipsInStore = require(script.Parent.utils.setFriendshipsInStore)
local removeTargetUserFriendshipInStore = require(script.Parent.utils.removeTargetUserFriendshipInStore)
local countUserFriendsInStore = require(script.Parent.utils.countUserFriendsInStore)
local _roduxFriendsTypes = require(FriendsRodux.roduxFriendsTypes)

local tbl1 = {
    byUserId = {},
    countsByUserId = {}
}

return function(arg1)
    local friendsNetworking = arg1.friendsNetworking

    return function(arg2, arg3)
        local var1 = arg2 or tbl1

        if arg3 and arg3.type == FriendshipCreated.name then
            assert(type(arg3.payload.userId1) == "string", "Expected userId1 to be a string")
            assert(type(arg3.payload.userId2) == "string", "Expected userId2 to be a string")

            return (llama.Dictionary.join(var1.countsByUserId, {
                [arg3.payload.userId1] = #addUser(var1.byUserId[arg3.payload.userId1], arg3.payload.userId2),
                [arg3.payload.userId2] = #addUser(var1.byUserId[arg3.payload.userId2], arg3.payload.userId1)
            }))
        end

        if arg3 and arg3.type == FriendshipDestroyed.name then
            assert(type(arg3.payload.userId1) == "string", "Expected userId1 to be a string")
            assert(type(arg3.payload.userId2) == "string", "Expected userId2 to be a string")

            return (llama.Dictionary.join(var1.countsByUserId, {
                [arg3.payload.userId1] = #removeUser(var1.byUserId[arg3.payload.userId1], arg3.payload.userId2),
                [arg3.payload.userId2] = #removeUser(var1.byUserId[arg3.payload.userId2], arg3.payload.userId1)
            }))
        end

        if arg3 and arg3.type == friendsNetworking.GetFriendsFromUserId.Succeeded.name then
            local var2 = setFriendshipsInStore(var1.byUserId, arg3)
            return (countUserFriendsInStore(var2))
        end

        if not arg3 or arg3.type ~= friendsNetworking.UnfriendTargetUserId.Succeeded.name then
            return var1.countsByUserId
        end

        local var2 = removeTargetUserFriendshipInStore(arg2.byUserId, arg3)
        return (countUserFriendsInStore(var2))
    end
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:01:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local Players = dependencies.Players

local llama = dependencies.llama
local RoduxFriends = dependencies.RoduxFriends

return function(str1: string?)
    local function friendshipCreatedWithUser(arg1)
        local friendshipCreated = RoduxFriends.Actions.FriendshipCreated
        local id = arg1.id
        local var1 = str1 or tostring(Players.LocalPlayer.UserId)
        return friendshipCreated(id, var1)
    end

    return {
        AddUser = function(arg1): {any}
            return if arg1.user.isFriend then { friendshipCreatedWithUser(arg1.user) } else { arg1 }
        end,
        AddUsers = function(arg1)
            return llama.Dictionary.values(llama.Dictionary.map(arg1.users, function(arg2, _)
                if arg2.isFriend then
                    return friendshipCreatedWithUser(arg2)
                end

                return nil
            end))
        end,
        SetFriendRequestsCount = function(arg1)
            return { RoduxFriends.Actions.RequestReceivedCountUpdated(arg1.count) }
        end
    }
end

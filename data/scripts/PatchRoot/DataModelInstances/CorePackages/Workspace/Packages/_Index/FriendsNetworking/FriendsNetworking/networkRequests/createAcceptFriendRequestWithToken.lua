-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FRIENDS_URL = require(script.Parent.Parent.FRIENDS_URL)
local _networkingFriendsTypes = require(script.Parent.Parent.networkingFriendsTypes)

return function(arg1)
    return arg1.roduxNetworking.POST("AcceptFriendRequestWithToken", function(arg2, arg3)
        return arg2(FRIENDS_URL, { currentUserId = arg3.currentUserId }):path("v1"):path("users"):id(arg3.targetUserId):path(
            "accept-friend-request-with-token"
        ):body(
            {
                friendingToken = arg3.friendingToken
            }
        )
    end)
end

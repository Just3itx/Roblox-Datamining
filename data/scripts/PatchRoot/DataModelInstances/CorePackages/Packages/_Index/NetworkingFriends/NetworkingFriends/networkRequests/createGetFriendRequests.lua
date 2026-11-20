-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FRIENDS_URL = require(script.Parent.Parent.FRIENDS_URL)
local _networkingFriendsTypes = require(script.Parent.Parent.networkingFriendsTypes)

return function(arg1)
    return arg1.roduxNetworking.GET({ Name = "GetFriendRequests" }, function(arg2, arg3)
        return arg2(FRIENDS_URL, { currentUserId = arg3.currentUserId }):path("v1"):path("my"):path("friends"):path("requests"):queryArgs(
            {
                fetchMutualFriends = arg3.fetchMutualFriends,
                sortOrder = arg3.sortOrder,
                limit = arg3.limit,
                cursor = arg3.cursor
            }
        )
    end)
end

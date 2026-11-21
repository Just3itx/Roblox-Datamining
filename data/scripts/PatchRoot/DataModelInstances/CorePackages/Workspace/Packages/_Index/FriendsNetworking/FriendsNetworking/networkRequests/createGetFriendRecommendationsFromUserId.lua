-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:41:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FRIENDS_URL = require(script.Parent.Parent.FRIENDS_URL)
local _networkingFriendsTypes = require(script.Parent.Parent.networkingFriendsTypes)

return function(arg1)
    return arg1.roduxNetworking.GET("GetFriendRecommendationsFromUserId", function(arg2, arg3)
        return arg2(FRIENDS_URL):path("v1"):path("users"):id(arg3.targetUserId):path("friends"):path("recommendations"):queryArgs(
            {
                source = arg3.source,
                includeProfileFrame = arg3.includeProfileFrame
            }
        )
    end)
end

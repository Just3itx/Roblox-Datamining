-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:10:50Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FRIENDS_URL = require(script.Parent.Parent.FRIENDS_URL)
local _networkingFriendsTypes = require(script.Parent.Parent.networkingFriendsTypes)

return function(arg1)
    return arg1.roduxNetworking.GET({ Name = "GetTencentFriendsSuggestion" }, function(arg2, arg3)
        return arg2(FRIENDS_URL):path("v1"):path("tecent-friends-suggestion"):queryArgs(
            {
                userOpenId = arg3.userOpenId,
                userAccessToken = arg3.userAccessToken,
                type = arg3.type,
                appType = arg3.appType
            }
        )
    end)
end

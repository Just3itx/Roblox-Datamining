-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:41:26Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsNetworkingParent = script:FindFirstAncestor("FriendsNetworking").Parent

local FRIENDS_URL = require(script.Parent.Parent.FRIENDS_URL)
local _networkingFriendsTypes = require(script.Parent.Parent.networkingFriendsTypes)

local FFlagAddFriendsSessionId = require(FriendsNetworkingParent.SharedFlags).FFlagAddFriendsSessionId

return function(arg1)
    return arg1.roduxNetworking.GET("GetFriendRequests", function(arg2, arg3)
        local var1 = arg2(FRIENDS_URL, { currentUserId = arg3.currentUserId }):path("v1"):path("my"):path("friends"):path("requests")
        local tbl1 = {
            fetchMutualFriends = arg3.fetchMutualFriends,
            sortOrder = arg3.sortOrder,
            limit = arg3.limit,
            cursor = arg3.cursor,
            sessionId = if FFlagAddFriendsSessionId then arg3.sessionId else nil,
            uprankUnseen = true
        }
        return var1:queryArgs(tbl1)
    end)
end

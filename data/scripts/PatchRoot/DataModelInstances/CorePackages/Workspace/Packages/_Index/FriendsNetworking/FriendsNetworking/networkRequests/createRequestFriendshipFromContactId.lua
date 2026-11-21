-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FRIENDS_URL = require(script.Parent.Parent.FRIENDS_URL)
local _networkingFriendsTypes = require(script.Parent.Parent.networkingFriendsTypes)

return function(arg1)
    return arg1.roduxNetworking.POST("RequestFriendshipFromContactId", function(arg2, tbl1)
        return arg2(FRIENDS_URL, { currentUserId = tbl1.currentUserId }):path("v1"):path("contacts"):id(tbl1.contactId):path(
            "request-friendship"
        ):body(
            {}
        )
    end)
end

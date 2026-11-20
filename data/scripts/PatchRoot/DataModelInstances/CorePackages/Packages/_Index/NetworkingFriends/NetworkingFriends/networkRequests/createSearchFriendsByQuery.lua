-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FRIENDS_URL = require(script.Parent.Parent.FRIENDS_URL)
local _networkingFriendsTypes = require(script.Parent.Parent.networkingFriendsTypes)

return function(arg1)
    return arg1.roduxNetworking.GET({ Name = "SearchFriendsByQuery" }, function(arg2, arg3, tbl1)
        local var1 = arg2(FRIENDS_URL):path("v1"):path("users"):id(arg3):path("friends"):path("search")
        local tbl2 = {
            query = if tbl1 then tbl1.query else nil,
            userSort = if tbl1 then tbl1.userSort else nil,
            cursor = if tbl1 then tbl1.cursor else nil,
            limit = if tbl1 then tbl1.limit else nil
        }
        return var1:queryArgs(tbl2)
    end)
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T16:31:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsMenuParent = script:FindFirstAncestor("FriendsMenu").Parent

local Url = require(FriendsMenuParent.Http).Url

return function(arg1, str1: string, query: string, limit: number?, cursor: string?)
    local var1 = Url:makeQueryString({ query = query, cursor = cursor, limit = limit })

    return arg1(string.format("%s/users/%s/friends/search?%s", Url.FRIEND_URL, str1, var1), "GET")
end

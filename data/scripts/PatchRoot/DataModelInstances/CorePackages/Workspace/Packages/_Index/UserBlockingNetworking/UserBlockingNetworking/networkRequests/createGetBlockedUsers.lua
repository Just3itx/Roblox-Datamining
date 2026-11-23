-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)

return function(tbl1)
    return tbl1.roduxNetworking.GET("GetBlockedUsers", function(arg1, tbl2)
        local var1 = arg1(API_URL, { currentUserId = if tbl2 then tbl2.currentUserId or nil else nil }):path("user-blocking-api"):path("v1"):path(
            "users"
        ):path(
            "get-blocked-users"
        )
        local tbl3 = {
            cursor = if tbl2 then tbl2.cursor or nil else nil,
            count = tbl2 and tbl2.count or nil
        }
        return var1:queryArgs(tbl3)
    end)
end

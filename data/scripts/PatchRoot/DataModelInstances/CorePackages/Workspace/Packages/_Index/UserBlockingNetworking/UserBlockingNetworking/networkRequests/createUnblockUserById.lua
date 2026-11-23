-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:31:03Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)

return function(tbl1)
    return tbl1.roduxNetworking.POST("UnblockUserById", function(arg1, tbl2)
        return arg1(API_URL, { params = tbl2.currentUserId }):path("user-blocking-api"):path("v1"):path("users"):id(tbl2.userId):path(
            "unblock-user"
        ):body(
            {}
        )
    end)
end

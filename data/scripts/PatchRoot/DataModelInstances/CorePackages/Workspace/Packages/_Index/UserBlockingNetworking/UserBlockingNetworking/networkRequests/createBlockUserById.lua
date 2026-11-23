-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T01:30:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)

return function(tbl1)
    return tbl1.roduxNetworking.POST("BlockUserById", function(arg1, tbl2)
        return arg1(API_URL, { currentUserId = tbl2.currentUserId }):path("user-blocking-api"):path("v1"):path("users"):id(tbl2.userId):path(
            "block-user"
        ):body(
            {}
        )
    end)
end

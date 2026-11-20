-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:20:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local USERS_URL = require(script.Parent.Parent.USERS_URL)

return function(arg1)
    return arg1.roduxNetworking.GET({ Name = "GetUserV2FromUserId" }, function(arg2, arg3)
        return arg2(USERS_URL):path("v1"):path("users"):id(arg3)
    end)
end

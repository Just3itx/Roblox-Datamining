-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:20:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local USERS_URL = require(script.Parent.Parent.USERS_URL)

return function(arg1)
    return arg1.roduxNetworking.POST({ Name = "SetDescription" }, function(arg2, localUserId, description)
        return arg2(USERS_URL, { LocalUserId = localUserId }):path("v1"):path("description"):body({ description = description })
    end)
end

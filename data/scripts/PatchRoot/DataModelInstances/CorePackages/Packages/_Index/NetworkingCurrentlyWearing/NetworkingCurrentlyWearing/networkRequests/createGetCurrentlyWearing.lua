-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:01:10Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AVATAR_URL = require(script.Parent.Parent.AVATAR_URL)

return function(arg1)
    return arg1.roduxNetworking.GET({ Name = "GetCurrentlyWearing" }, function(arg2, arg3)
        return arg2(AVATAR_URL):path("v1"):path("users"):id(arg3):path("currently-wearing")
    end)
end

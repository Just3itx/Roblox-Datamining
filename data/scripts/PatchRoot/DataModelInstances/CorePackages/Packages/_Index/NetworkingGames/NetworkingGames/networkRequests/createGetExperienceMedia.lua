-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:11:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GAMES_URL = require(script.Parent.Parent.GAMES_URL)

return function(arg1)
    return arg1.roduxNetworking.GET({ Name = "GetExperienceMedia" }, function(arg2, arg3)
        return arg2(GAMES_URL):path("v2"):path("games"):id(arg3):path("media")
    end)
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T14:20:47Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local byUserId = require(script.Presence.byUserId)
local byGameId = require(script.Presence.byGameId)
local byGameInstanceId = require(script.Presence.byGameInstanceId)
local byPlaceId = require(script.Presence.byPlaceId)

return function(arg1)
    return function(arg2, arg3)
        local var1 = arg2 or {
            byUserId = {},
            byGameInstanceId = {},
            byGameId = {},
            byPlaceId = {}
        }

        return {
            byUserId = byUserId(arg1)(var1.byUserId, arg3),
            byGameInstanceId = byGameInstanceId(arg1)(var1, arg3),
            byGameId = byGameId(arg1)(var1, arg3),
            byPlaceId = byPlaceId(arg1)(var1, arg3)
        }
    end
end

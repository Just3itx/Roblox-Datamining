-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:11:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _networkingPresenceTypes = require(scriptParentParent.networkingPresenceTypes)

local PRESENCE_URL = require(scriptParentParent.PRESENCE_URL)

return function(arg1)
    return arg1.roduxNetworking.POST({ Name = "SetInvisibilityStatus" }, function(arg2, isInvisible: boolean)
        return arg2(PRESENCE_URL):path("v1"):path("presence"):path("set-invisibility-status"):body({ isInvisible = isInvisible })
    end)
end

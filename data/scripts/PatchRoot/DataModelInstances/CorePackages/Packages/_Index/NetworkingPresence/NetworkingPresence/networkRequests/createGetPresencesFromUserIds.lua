-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:11:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _networkingPresenceTypes = require(scriptParentParent.networkingPresenceTypes)
local PRESENCE_URL = require(scriptParentParent.PRESENCE_URL)

return function(arg1)
    return arg1.roduxNetworking.POST({ Name = "GetPresencesFromUserIds" }, function(arg2, userIds)
        return arg2(PRESENCE_URL):path("v1"):path("presence"):path("users"):body({ userIds = userIds }):setStatusIds(userIds)
    end)
end

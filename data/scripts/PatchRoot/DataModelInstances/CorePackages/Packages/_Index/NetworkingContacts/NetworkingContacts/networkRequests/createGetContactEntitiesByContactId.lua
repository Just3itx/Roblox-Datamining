-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:01:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)
local _networkRequestsTypes = require(scriptParentParent.Types.networkRequestsTypes)

return function(arg1)
    return arg1.roduxNetworking.POST({ Name = "GetContactEntitiesByContactId" }, function(arg2, userContactIds)
        return arg2(API_URL):path("contacts-api"):path("v1"):path("contacts"):path("entities"):body(
            { userContactIds = userContactIds }
        )
    end)
end

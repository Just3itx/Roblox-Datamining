-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:20:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local API_URL = require(scriptParentParent.API_URL)
local _networkRequestsTypes = require(scriptParentParent.Types.networkRequestsTypes)

return function(arg1)
    return arg1.roduxNetworking.GET(script.Name, function(arg2, arg3)
        return arg2(API_URL):path("user-settings-api"):path("v1"):path("user-settings"):queryArgs(arg3)
    end)
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:41:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local _networkRequestsTypes = require(scriptParentParent.Types.networkRequestsTypes)

local ACCOUNT_INFORMATION_URL = require(scriptParentParent.ACCOUNT_INFORMATION_URL)

return function(arg1)
    return arg1.roduxNetworking.GET({ Name = "GetPhoneInformation" }, function(arg2)
        return arg2(ACCOUNT_INFORMATION_URL):path("v1"):path("phone")
    end)
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CALL_URL = require(script.Parent.Parent.CALL_URL)
local _networkingCallTypes = require(script.Parent.Parent.networkingCallTypes)

return function(arg1)
    return (arg1.roduxNetworking.GET({ Name = "GetSuggestedCallees" }, function(arg2)
        return arg2(CALL_URL):path("call"):path("v1"):path("get-suggested-callees")
    end))
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:51:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CALL_URL = require(script.Parent.Parent.CALL_URL)
local _networkingCallTypes = require(script.Parent.Parent.networkingCallTypes)

return function(arg1)
    return (arg1.roduxNetworking.GET({ Name = "GetCallHistory" }, function(arg2, arg3)
        local var1 = arg2(CALL_URL):path("call"):path("v1"):path("get-call-history")
        local tbl1 = {
            universeId = if arg3 then arg3.universeId else nil,
            limit = if arg3 then arg3.limit else nil,
            cursor = if arg3 then arg3.cursor else nil
        }
        return var1:queryArgs(tbl1)
    end))
end

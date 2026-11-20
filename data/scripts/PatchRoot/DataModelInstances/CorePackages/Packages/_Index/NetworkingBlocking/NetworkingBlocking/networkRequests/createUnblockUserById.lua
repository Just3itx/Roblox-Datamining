-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:50:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local ACCOUNT_SETTINGS_URL = require(scriptParentParent.ACCOUNT_SETTINGS_URL)

return function(tbl1)
    return tbl1.roduxNetworking.POST({ Name = "UnblockUserById" }, function(arg1, tbl2)
        return arg1(ACCOUNT_SETTINGS_URL, { params = tbl2.currentUserId }):path("v1"):path("users"):id(tbl2.userId):path("unblock"):body(
            {}
        )
    end)
end

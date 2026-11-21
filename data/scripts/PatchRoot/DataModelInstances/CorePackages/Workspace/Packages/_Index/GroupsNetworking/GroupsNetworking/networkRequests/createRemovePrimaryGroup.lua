-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T23:50:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsNetworking = script:FindFirstAncestor("GroupsNetworking")

local GROUPS_URL = require(GroupsNetworking.GROUPS_URL)

return function(tbl1)
    return tbl1.roduxNetworking.DELETE("RemovePrimaryGroup", function(arg1)
        return arg1(GROUPS_URL):path("v1"):path("user"):path("groups"):path("primary")
    end)
end

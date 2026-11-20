-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ALIAS_URL = require(script.Parent.Parent.ALIAS_URL)
local _networkingAliasesTypes = require(script.Parent.Parent.networkingAliasesTypes)

return function(arg1)
    return arg1.roduxNetworking.POST({ Name = "GetTagsFromUserIds" }, function(arg2, targetUserIds)
        return arg2(ALIAS_URL):path("v1"):path("user"):path("get-tags"):body({ targetUserIds = targetUserIds })
    end)
end

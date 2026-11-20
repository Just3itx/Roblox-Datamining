-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local networkRequests = script.Parent.networkRequests
local createGetTagsFromUserIds = require(networkRequests.createGetTagsFromUserIds)
local createSetUserTag = require(networkRequests.createSetUserTag)
local _networkingAliasesTypes = require(script.Parent.networkingAliasesTypes)

return function(arg1)
    return {
        GetTagsFromUserIds = createGetTagsFromUserIds(arg1),
        SetUserTag = createSetUserTag(arg1)
    }
end

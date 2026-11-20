-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:00:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local networkRequests = scriptParent.networkRequests
local createUploadContactsByUser = require(networkRequests.createUploadContactsByUser)
local createFindContactFriends = require(networkRequests.createFindContactFriends)
local createGetContactEntitiesByContactId = require(networkRequests.createGetContactEntitiesByContactId)
local _networkRequestsTypes = require(scriptParent.Types.networkRequestsTypes)

return function(arg1)
    return {
        UploadContactsByUser = createUploadContactsByUser(arg1),
        FindContactFriends = createFindContactFriends(arg1),
        GetContactEntitiesByContactId = createGetContactEntitiesByContactId(arg1)
    }
end

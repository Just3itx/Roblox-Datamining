-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:20:44Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local networkRequests = script.Parent.networkRequests
local createGetSkinnyUsersFromUserIds = require(networkRequests.createGetSkinnyUsersFromUserIds)
local createGetUsernameHistoryFromUserId = require(networkRequests.createGetUsernameHistoryFromUserId)
local createGetUserV2FromUserId = require(networkRequests.createGetUserV2FromUserId)
local createGetDisplayNameValidation = require(networkRequests.createGetDisplayNameValidation)
local createSetDisplayName = require(networkRequests.createSetDisplayName)
local createSetDescription = require(networkRequests.createSetDescription)

return function(arg1)
    return {
        GetSkinnyUsersFromUserIds = createGetSkinnyUsersFromUserIds(arg1),
        GetUsernameHistoryFromUserId = createGetUsernameHistoryFromUserId(arg1),
        GetUserV2FromUserId = createGetUserV2FromUserId(arg1),
        GetDisplayNameValidation = createGetDisplayNameValidation(arg1),
        SetDisplayName = createSetDisplayName(arg1),
        SetDescription = createSetDescription(arg1)
    }
end

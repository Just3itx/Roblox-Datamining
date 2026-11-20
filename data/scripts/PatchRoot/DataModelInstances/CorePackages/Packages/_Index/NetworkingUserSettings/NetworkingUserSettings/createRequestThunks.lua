-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:20:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local networkRequests = scriptParent.networkRequests
local createGetUserSettings = require(networkRequests.createGetUserSettings)
local createUpdateUserSettings = require(networkRequests.createUpdateUserSettings)
local createGetUserSettingsMetadata = require(networkRequests.createGetUserSettingsMetadata)
local _networkRequestsTypes = require(scriptParent.Types.networkRequestsTypes)

return function(arg1)
    return {
        GetUserSettings = createGetUserSettings(arg1),
        UpdateUserSettings = createUpdateUserSettings(arg1),
        GetUserSettingsMetadata = createGetUserSettingsMetadata(arg1)
    }
end

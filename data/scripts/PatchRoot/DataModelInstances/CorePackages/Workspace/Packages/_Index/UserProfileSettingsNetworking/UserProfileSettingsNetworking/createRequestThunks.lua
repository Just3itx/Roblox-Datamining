-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T02:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local networkRequests = script.Parent.networkRequests
local createGetUserProfileSettings = require(networkRequests.createGetUserProfileSettings)
local createSetUserProfileSettings = require(networkRequests.createSetUserProfileSettings)

return function(tbl1)
    return {
        GetUserProfileSettings = createGetUserProfileSettings(tbl1),
        SetUserProfileSettings = createSetUserProfileSettings(tbl1)
    }
end

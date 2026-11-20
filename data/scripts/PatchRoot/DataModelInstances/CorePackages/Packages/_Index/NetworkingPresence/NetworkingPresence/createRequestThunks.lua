-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:11:15Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local networkRequests = script.Parent.networkRequests

local createGetPresencesFromUserIds = require(networkRequests.createGetPresencesFromUserIds)
local createSetInvisibilityStatus = require(networkRequests.createSetInvisibilityStatus)
local _networkingPresenceTypes = require(script.Parent.networkingPresenceTypes)

return function(arg1)
    return {
        GetPresencesFromUserIds = createGetPresencesFromUserIds(arg1),
        SetInvisibilityStatus = createSetInvisibilityStatus(arg1)
    }
end

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local networkRequests = scriptParent.networkRequests
local createGetPhoneInformation = require(networkRequests.createGetPhoneInformation)
local _networkRequestsTypes = require(scriptParent.Types.networkRequestsTypes)

return function(arg1)
    return {
        GetPhoneInformation = createGetPhoneInformation(arg1)
    }
end

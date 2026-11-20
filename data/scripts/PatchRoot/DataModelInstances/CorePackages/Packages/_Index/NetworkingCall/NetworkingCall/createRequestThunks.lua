-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:51:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local _networkingCallTypes = require(script.Parent.networkingCallTypes)

local networkRequests = script.Parent.networkRequests
local createGetCallHistory = require(networkRequests.createGetCallHistory)

local createGetSuggestedCallees = require(networkRequests.createGetSuggestedCallees)

return function(arg1)
    return {
        GetCallHistory = createGetCallHistory(arg1),
        GetSuggestedCallees = createGetSuggestedCallees(arg1)
    }
end

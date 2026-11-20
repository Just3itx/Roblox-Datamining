-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local networkRequests = script.networkRequests
local createGetCurrentlyWearing = require(networkRequests.createGetCurrentlyWearing)
local createGetItemDetails = require(networkRequests.createGetItemDetails)

return {
    config = function(arg1) -- name: createRequestThunks
        return {
            GetCurrentlyWearing = createGetCurrentlyWearing(arg1),
            GetItemDetails = createGetItemDetails(arg1)
        }
    end
}

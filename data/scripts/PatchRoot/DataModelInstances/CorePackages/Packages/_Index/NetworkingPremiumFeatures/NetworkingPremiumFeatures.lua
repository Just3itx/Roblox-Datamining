-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T11:11:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local networkRequests = script.networkRequests
local createGetUserPremiumMembershipStatus = require(networkRequests.createGetUserPremiumMembershipStatus)

return {
    config = function(arg1) -- name: createRequestThunks
        return {
            GetUserPremiumMembershipStatus = createGetUserPremiumMembershipStatus(arg1)
        }
    end
}

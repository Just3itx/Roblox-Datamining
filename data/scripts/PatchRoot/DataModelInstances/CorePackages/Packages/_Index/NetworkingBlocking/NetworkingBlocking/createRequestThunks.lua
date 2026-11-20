-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:50:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local networkRequests = script.Parent.networkRequests
local createGetBlockedUsers = require(networkRequests.createGetBlockedUsers)
local createBlockUserById = require(networkRequests.createBlockUserById)
local createUnblockUserById = require(networkRequests.createUnblockUserById)

return function(tbl1)
    return {
        GetBlockedUsers = createGetBlockedUsers(tbl1),
        BlockUserById = createBlockUserById(tbl1),
        UnblockUserById = createUnblockUserById(tbl1)
    }
end
